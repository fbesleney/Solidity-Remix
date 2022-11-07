// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;

contract Ownable {
    address private owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner=msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        owner = address(0);
    }

    function getOwner() public view returns(address){
        return owner;
    }


    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


contract Test1 is Ownable {
    
    mapping(address => bool) public users;

    function addUser(address newUser) public onlyOwner {
        users[newUser]=true;
    } 
}
contract Test2 is Ownable {
    
    mapping(address => bool) public users;

    function addUser(address newUser) public onlyOwner {
        users[newUser]=true;
    } 

    function renounceOwnership() public pure override {
        revert('renounceOwnership disabled');
    }
}