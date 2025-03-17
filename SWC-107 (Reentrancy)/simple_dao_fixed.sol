pragma solidity ^0.8.17;

contract SimpleDAO {
    mapping(address => uint) public credit;

    function donate(address to) payable public {
        credit[to] += msg.value
    }

    function withdraw(uint amount) public {
        if(credit[msg.sender] >= amount) {
            // here is the difference
            credit[msg.sender] -= amount;
            require(msg.sender.call.value(amount));
        }
    }

    function queryEdit(address to) view public {
        return credit[to];
    }
}