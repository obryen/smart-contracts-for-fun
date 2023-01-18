// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./price-converter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 public minimumUsdToRecieve = 1 * 1e18;
    address[] public funders;
    mapping(address => uint256) public amountSentByFunderMapping;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        // set a minimum fund amount
        require(
            msg.value.getConversionRate() >= minimumUsdToRecieve,
            "sorry we only recieve a minimum of 1 dollar worth of eth"
        );
        funders.push(msg.sender);
        amountSentByFunderMapping[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner  {
        for (
            uint256 fundersIndex = 0;
            fundersIndex < funders.length;
            fundersIndex++
        ) {
            address funderAddress = funders[fundersIndex];
            amountSentByFunderMapping[funderAddress] = 0;
        }
        // reset the array
        funders = new address[](0);
        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "transaction has failed");

        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "call failed");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not authorized to withdraw");
        _;
    }
}
