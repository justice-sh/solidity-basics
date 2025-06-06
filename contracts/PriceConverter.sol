// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
  /**
   * @notice Converts ETH to USD based on the latest price feed.
   * @param ethAmount The amount of ETH to convert.
   * @return The equivalent amount in USD.
   */
  function convertEthToUsd(uint256 ethAmount) internal pure returns (uint256) {
    return (getMockPrice() * ethAmount) / 1e18; // Convert ETH to USD in Wei
  }

  /**
   * @notice Gets the latest ETH price in USD from the price feed.
   * @return The latest ETH price in USD with 8 decimals.
   */
  function getPrice() internal view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(
      0x694AA1769357215DE4FAC081bf1f309aDC325306
    );
    (, int256 answer, , , ) = priceFeed.latestRoundData();
    return uint256(answer * 1e10); // Convert price to wei
  }

  /**
   * @notice Gets a mock ETH price in USD for testing purposes.
   * @return The mock ETH price in USD with 18 decimals (or mock ETH/USD price in wei).
   */
  function getMockPrice() internal pure returns (uint256) {
    return 2462e18; // This implies that 1 USD === 2462 ETH
  }

  // Assignment: Convert USD to ETH
  // This function converts a given USD amount to ETH based on the current price feed
  function convertUsdToEth(uint256 usdAmount) public pure returns (uint256) {
    return (usdAmount * 1e18 * 1e18) / getMockPrice(); // Convert USD to ETH in wei
  }
}
