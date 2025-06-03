// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
  address private sepoliaAddress = address(0x694AA1769357215DE4FAC081bf1f309aDC325306); // Sepolia address for ETH/USD price feed

  // uint256 public minimumUSD = 50 * 10**18; // 50 USD in wei
  uint256 public minimumUSD = 5;

  function fund() public payable {
    require(msg.value >= minimumUSD, "You need to spend more ETH!");
  }

  function getLatestPrice() public view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(sepoliaAddress);
    (, int price, , , ) = priceFeed.latestRoundData();
    return convertUsdToWei(price);
  }

  function convertUsdToWei(int256 usdAmount) private pure returns (uint256) {
    // USD has 8 decimals, ETH has 18 decimals
    // To convert USD to wei, we multiply by 10^10 (to adjust for the difference in decimals)
    return uint256(usdAmount * 1e10);
  }
}
