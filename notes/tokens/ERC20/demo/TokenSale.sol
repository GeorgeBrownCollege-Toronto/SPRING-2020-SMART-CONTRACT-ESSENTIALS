/**
 *Submitted for verification at Etherscan.io on 2020-10-04
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
 * deployed at 0xa1Bb3f2Ab45b82CbEe9fa925744B4be39133aFa7 on ropsten
 * 
 */

interface IERC20Token {
    function balanceOf(address owner) external returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function decimals() external returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract AliceICO {
    IERC20Token public tokenContract;  // the token being sold
    uint256 public price;              // the price, in wei, per token
    address public alice;

    uint256 public aliceCoinsSold;

    event Sold(address buyer, uint256 amount);

     constructor(IERC20Token _tokenContract, uint256 _price) {
        alice = msg.sender;
        tokenContract = _tokenContract;
        price = _price;
    }

    function buyTokens(uint256 numberOfTokens) public payable {
        require(msg.value == numberOfTokens * price);

        uint256 scaledAmount = numberOfTokens *
            (uint256(10) ** tokenContract.decimals());

        require(tokenContract.allowance(alice,address(this)) >= scaledAmount);

        emit Sold(msg.sender, numberOfTokens);
        aliceCoinsSold += numberOfTokens;

        require(tokenContract.transferFrom(alice,msg.sender, scaledAmount));
        
        if (aliceCoinsSold >= tokenContract.allowance(alice,address(this))) {
            endSale();
        }
    }

    function endSale() public {
        require(msg.sender == alice);

        // Destroy this contract, sending all collected ether to the owner.
        selfdestruct(payable(alice));
    }
}
