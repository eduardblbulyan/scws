pragma solidity ^0.8.17;

contract Bank{
    function supportsToken() external returns(bytes32) {
        return keccak256(abi.encodePacked("Ed Token"));
    }
}

contract ModifierEntrancy {
    mapping (address => uint) public tokenBalance;
    string constant name = "Ed Token";
    Bank bank;

    modifier hasNoBalance {
        require(tokenBalance[msg.sender] == 0);
        _;
    }

    modifier supportsToken() {
        require(keccak256(abi.encodePacked("Ed Token")) == bank.supportsToken());
        _;
    }

    constructor() public{
        bank = new Bank();
    }

    // if contract has 0 balance and supports given token -> give some tokens
    // NOTE: In the fixed version supportsToken comes before hasNoBalance
    function airDrop() supportsToken hasNoBalance public {
        tokenBalance[msg.sender] += 20;
    }
}