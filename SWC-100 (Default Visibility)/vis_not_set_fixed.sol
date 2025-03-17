// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract HashForEther {
    function wihtdrawWinnings() public {
        require(address(msg.sender)==address(0));
        _sendWinnings();
    }

    // function set to internal
    function _sendWinnings() internal{
        payable(msg.sender).transfer(address(this).balance);
    }
}