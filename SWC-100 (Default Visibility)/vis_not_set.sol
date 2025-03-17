// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract HashForEther {
    function wihtdrawWinnings() {
        require(address(msg.sender)==address(0));
        _sendWinnings();
    }

    function _sendWinnings(){
        payable(msg.sender).transfer(address(this).balance);
    }
}