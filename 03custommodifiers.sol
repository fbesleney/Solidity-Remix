// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract User {

    address private owner;
    mapping(address=>bool) public users;

    constructor() {
        owner = msg.sender; 
    }

    function addUser(address newUser) public onlyOwner isUserExist(newUser){
        users[newUser]=true;
    } 

    function deleteUser() public checkUser {
        users[msg.sender]=false;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function getOwner() external view returns (address) {
        return owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    modifier checkUser() {
         require(users[msg.sender], "User not exist");
         //require(msg.sender == user, "Caller is not the user himself");
        _;
    }
    modifier isUserExist(address user) {
        require(!users[user], "User already added");
        _;
    }
} 