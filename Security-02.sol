// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;



contract EtherStore {
    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public payable {
        uint bal = balances[msg.sender];
        require(bal > 0);
        //(bool sent, ) = msg.sender.call{value: bal}("") ORIGINAL HOMEWORK
        (bool sent, ) = msg.sender.call{value: msg.value}(""); //OUR CHANGE
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


