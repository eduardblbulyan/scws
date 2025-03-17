// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Proxy{
    address owner;

    // in new versions no need to set public in const
    constructor() {
        owner = msg.sender;
    }
    
    function forward(address callee, bytes memory _data) public {
        (bool success, ) = callee.delegatecall(_data);
        require(success, "Delegatecall failed");
    }
}