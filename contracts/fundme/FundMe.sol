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

  function fund() public payable {
    require(msg.value.convertEthToUsd() >= MINIMUM_USD, "You need to spend more ETH!");
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] += msg.value;
    contributionCount[msg.sender] += 1;
  }
}
