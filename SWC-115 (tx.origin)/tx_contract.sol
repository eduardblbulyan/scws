// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract TXContract {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function sendTo(address receiver, uint amount) public {
        require(tx.origin == owner);
        payable(receiver).transfer(amount);
    }
}