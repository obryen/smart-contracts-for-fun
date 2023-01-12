// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    address public constant contractAddress =
        0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e;

    function getPrice() internal view returns (uint256) {
        // ABI, address needed
        // Eth to usd data feed contract address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            contractAddress
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface i = AggregatorV3Interface(contractAddress);
        return i.version();
    }

    function getDecimalPlaces() public view returns (uint256) {
        AggregatorV3Interface d = AggregatorV3Interface(contractAddress);
        return d.decimals();
    }

    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
