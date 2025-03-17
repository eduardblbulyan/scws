// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Refunder {
    address[] private refundAddresses;
    mapping (address => uint) public refunds;

    constructor() {
        refundAddresses.push(address(0x79B483371E87d664cd39491b5F06250165e4b184));
    }
    // bad
    function refundAll() public {
        for(uint x; x < refundAddresses.length; x++){
            require(payable(refundAddresses[x]).send(refunds[refundAddresses[x]]));
            // doubly bad, now a single failure on send will hold up all funds
        }
    }
}