//SPDX-License-Identifier: Unlicense

pragma solidity  ^0.8.7;

contract Token {

    mapping(address => uint) public money;

    function setToken(address _address, uint _amount) public {
        money[_address] = _amount;
    }

    function sendToken(address _from, address _to, uint _amount) public {
        money[_from] -= _amount;
        money[_to] += _amount;
    }
}