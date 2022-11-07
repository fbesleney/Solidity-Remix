// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract auction {

    uint public auctionOffer;
    address public auctionOwner;
    address public beneficiary;
    uint public auctionEndTime; 
    address public highestBidder;
    uint public highestBid;
    uint public bidTime;
    mapping(address => uint) public pendingReturns;
    bool public ended = true;

    
    constructor (){

       auctionOwner = msg.sender;
       //auctionWinner = highestBidder;
       //highestBid = highestBidder[teklifi];
       //auctionEndTime = 10 minutes;
       //bidTime = highestBidder[teklif verdiği an];

       
   }
        uint timeStart;
        uint timeEnd;
        
    modifier timerOver{
        require(block.timestamp <= timeEnd, "The Auction is over!");
        _;
    }

    function start() public{
        timeStart = block.timestamp; 
    }
    function end(uint totalTime) public {
        timeEnd = totalTime + timeStart;
    }

    function getTimeLeft() public timerOver view returns(uint){
        return timeEnd - block.timestamp;
    }

   

   event HighestBidIncreased(address highestBidder, uint highestBid);
   //event auctionEnded(uint highestBid, address highestBidder, uint bidTime);



    function bid(uint bidAmount) public {
        require(ended, "Auction time is passed");
        require(highestBid < bidAmount, "Your bid has to be greater than highest!");
        highestBid = bidAmount;
        highestBidder = msg.sender;
        emit HighestBidIncreased(msg.sender, bidAmount);
    }





}








