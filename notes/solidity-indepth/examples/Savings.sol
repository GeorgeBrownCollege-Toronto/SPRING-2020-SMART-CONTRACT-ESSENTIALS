// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

error WithdrawFailure();

contract Savings {
    address owner;
    uint256 deadline;
    
    constructor(uint256 $numOfDays) payable {
        owner = msg.sender;
        deadline = block.timestamp + ($numOfDays * 1 days);
    }
    
    // weeks, days, seconds, minutes, hours
    
    // 1 = 1 seconds
    // 1 minutes = 60 seconds
    // 1 hours = 60 minutes
    // 1 days = 24 hours
    // 1 weeks = 7 days
    
    function deposit(uint256 $amount) public payable {
        require(msg.value == $amount);
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    
    function withdraw() public onlyOwner {
        require(block.timestamp >= deadline);
        // payable(msg.sender).transfer(address(this).balance);
        bool isSuccess = payable(msg.sender).send(address(this).balance);
        if(!isSuccess){
            revert WithdrawFailure();
        }
        // transfer, send 
    }
    
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
}
