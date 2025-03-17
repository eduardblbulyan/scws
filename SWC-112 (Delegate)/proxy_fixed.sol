// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Proxy{
    address callee;
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        callee = address(0x0);
        owner = msg.sender;
    }

    function setCallee(address newCallee) public onlyOwner {
        callee = newCallee;
    }

    function forward(bytes memory _data) public {
        (bool success, ) = callee.delegatecall(_data);
        require(success, "Delegatecall failed");
    }
}