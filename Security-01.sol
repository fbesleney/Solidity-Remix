// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/*==============================================================================
    DISCLAIMER:

    This contract has intentional bugs, don't use in production
==============================================================================*/

contract Vote {
    uint256 public voteFee;
    uint256 public payout;
    uint256 public maxVotes;
    bool public voteFinished;

    mapping(address => uint256) public votes;

    constructor(uint256 _startAmt, uint256 _maxVotes) payable {
        //require(_startAmt == msg.value,"should equal to start amount");
        //require(_startAmt > 10,"should bigger than 10");

        payout = _startAmt;
        voteFee = _startAmt / 10;
        maxVotes = _maxVotes;
    }

    modifier onlyFinished() { 
        require(voteFinished,"not finished"); 
        _; 
    }

    modifier onlyNotFinished() {
        require(!voteFinished,"finished"); 
        _; 
    }

    function vote(address _who) external payable onlyNotFinished {
        require(msg.value >= voteFee,"not enough fee");
        votes[_who] += msg.value / voteFee;
        payout += msg.value;

        if (votes[_who] == maxVotes) {
            voteFinished = true;
        }
    }

    function claim() external onlyFinished {
        require(votes[msg.sender] >= maxVotes, "Not the winner");

        (bool success,) = payable(msg.sender).call{ value: payout}("");
        require(success, "Call failed");
        payout=0;
    }

}