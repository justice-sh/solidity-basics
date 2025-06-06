// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
  using PriceConverter for uint256;

  // uint256 public MINIMUM_USD = 50 * 10**18; // 50 USD in wei
  uint256 public MINIMUM_USD = 5e18;

  address[] public funders; // Array to store funders
  mapping(address => uint256) public addressToAmountFunded; // Mapping to track how much each address has funded
  mapping(address => uint256) public contributionCount;

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function fund() public payable {
    require(msg.value.convertEthToUsd() >= MINIMUM_USD, "You need to spend more ETH!");
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] += msg.value;
    contributionCount[msg.sender] += 1;
  }

  function withdraw() public onlyOwner {
    for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
      address funder = funders[funderIndex];
      addressToAmountFunded[funder] = 0; // Reset the funding amount for each funder
    }
    funders = new address[](0); // Reset the funders array

    // transfer
    // payable(msg.sender).transfer(address(this).balance);

    // send
    // bool sendSuccess = payable(msg.sender).send(address(this).balance);
    // require(sendSuccess, "Send failed");

    // call - as of recording, this is the recommended way to send/receive eth or your blockchain native token.
    // (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: this(address).balance}("");
    (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(callSuccess, "Call failed");
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can call this function");
    _;
  }
}
