// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.24;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
  /**
   * @notice Converts ETH to USD based on the latest price feed.
   * @param ethAmount The amount of ETH to convert.
   * @return The equivalent amount in USD.
   */
  function convertEthToUsd(uint256 ethAmount) internal view returns (uint256) {
    uint256 ethUsdPrice = getPrice(); // Latest ETH/USD price in wei
    uint256 ethAmountInUSD = (ethUsdPrice * ethAmount) / 1e18; // Convert ETH to USD
    return ethAmountInUSD;
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

  // Assignment: Convert USD to ETH
  // This function converts a given USD amount to ETH based on the current price feed
  function convertUsdToEth(uint256 usdAmount) public view returns (uint256) {
    uint256 ethUsdPrice = getPrice(); // Latest ETH price in wei
    uint256 usdAmountInWei = (usdAmount * 1e18) / ethUsdPrice; // Convert USD to ETH
    return usdAmountInWei;
  }
}
