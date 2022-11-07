//SPDX-License-Identifier: Unlicense

pragma solidity  ^0.8.7;

contract exercise{
    /* uint public number = 40;
    int public number2 = 20;
    uint public number3;
    string public str; */

    uint favoriteNumber;
    
    struct People {
        string name;
        uint256 favoriteNumber;
    }

    People[] public peoples;
    mapping(string => uint) public nameToFavoriteNumber;


    constructor() {
    }

    function storeNumber(uint _number) public {
        favoriteNumber = _number;

    }

    function getNumber() public view returns(uint) {
        return favoriteNumber;
    }

    function addPeople(string memory _name, uint _favoriteNumber) public {
        People memory _newPeople = People(_name, _favoriteNumber);
        peoples.push(_newPeople);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }



}
