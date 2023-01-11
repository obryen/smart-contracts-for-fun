// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUsdToRecieve = 1 * 1e18;
    address EthToUsdFeedAddress = 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e;
    address[] public funders; 
    mapping(address => uint256) public  amountSentByFunderMapping;
    function fund() public payable {
        // set a minimum fund amount
        require(
            getConversionRate(msg.value)> minimumUsdToRecieve,
            "sorry we only recieve a minimum of 1 dollar worth of eth"
        );
        funders.push(msg.sender);
        amountSentByFunderMapping[msg.sender] = msg.value;
    }

    function getPrice() public view returns (uint256) {
        // ABI, address needed
        // Eth to usd data feed contract address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            EthToUsdFeedAddress
        );
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10) ;
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface i = AggregatorV3Interface(EthToUsdFeedAddress);
        return i.version();
    }

    function getDecimalPlaces() public view returns (uint256){
        AggregatorV3Interface d = AggregatorV3Interface(EthToUsdFeedAddress);
        return d.decimals();
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd  = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
    // function withdraw() public {}

    // function setLimit() public {}
}
