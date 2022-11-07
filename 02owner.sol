// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypes {
    bytes32  password;
    uint loginCount;
    bool isLogin;
    address public owner;
    mapping(address => bool) public users;

    constructor(bytes32 _password){
        password = _password;
        owner = msg.sender;

    }

    function login(bytes32 _password) public onlyOwner returns(bool) {
        require(msg.sender == owner, "not owner");
        require(isLogin == false, "Already Login");
        require(loginCount < 10, "Login exeeded");
        //require(_password == password, "Password not match");
        require(password == keccak256(abi.encodePacked((_password))),"Password not match");

        loginCount++;
        isLogin = true;
        return true;

    }

    function logout() public loginCheck returns(bool) {
        //require(isLogin == true, "Already log out");
        isLogin = false;
        return true;
    }

    function loginStatus() public view returns(uint){
        if(isLogin == true){
            return 1;
        }
        return 0;
        
    }
    
    function addUser(address _newUser) public onlyOwner loginCheck userCheck(_newUser) {
        require(users[_newUser] == false, "user already added");
        users[_newUser] = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier userCheck(address _newUser){
        require(users[_newUser] == false, "user already added");
        _;
    }

    modifier loginCheck(){
        require(isLogin == true, "Please Login");
        _;
    }
}