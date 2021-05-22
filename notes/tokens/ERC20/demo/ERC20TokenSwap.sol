// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./StandardERC20.sol";

contract TokenSwap {
    
    // Owner1 = 100 token1
    // Owner2 = 100 token2
    // Owner1 and Onwer2 to trade 10 token1 for 20 token2
    // Owner1 or Owner2 can deploy TokenSwap
    // Owner1 approves TokensSwap to withdraw 10 token1 
    // Owner2 approves TokensSwap to withdraw 20 token2
    // Owner1 or Owner2 can call TokensSwap.swap()
    // Swapping of Token1 and Token2 is done.
    
    IERC20 public token1;
    address public owner1;
    uint256 public amount1;
    IERC20 public token2;
    address public owner2;
    uint256 public amount2;
    
    
    constructor(
        IERC20  _token1,
        address  _owner1,
        uint256  _amount1,
        IERC20  _token2,
        address  _owner2,
        uint256  _amount2
    ) {
        token1 = _token1;
        owner1 = _owner1;
        amount1 = _amount1;
        token2 = _token2;
        owner2 = _owner2;
        amount2 =  _amount2;
    
    }
    
    function swap() external {
        require(msg.sender == owner1 || msg.sender == owner2);
        require(token1.allowance(owner1, address(this)) >= amount1);
        require(token2.allowance(owner2, address(this)) >= amount1);
        
        require(token1.transferFrom(owner1,owner2,amount1));
        require(token2.transferFrom(owner2,owner1,amount2));
    }
}
