// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// @ts-ignore
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
  address private sepoliaAddress = address(0x694AA1769357215DE4FAC081bf1f309aDC325306); // Sepolia address for ETH/USD price feed

  // uint256 public minimumUSD = 50 * 10**18; // 50 USD in wei
  uint256 public minimumUSD = 5e18;

  function fund() public payable {
    require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
  }

  function getLatestPrice() public view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(sepoliaAddress);
    (, int price, , , ) = priceFeed.latestRoundData();
    // USD has 8 decimals, ETH has 18 decimals
    // To convert USD to wei, we multiply by 10^10 (to adjust for the difference in decimals)
    return uint256(price * 1e10);
  }

  function getConversionRate(uint256 ethAmount) public view returns (uint256) {
    uint256 ethPrice = getLatestPrice();
    uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18; // Convert ETH to USD
    return ethAmountInUSD;
  }
}
