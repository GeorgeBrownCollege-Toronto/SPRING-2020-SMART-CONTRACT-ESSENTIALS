// SPDX-License-Identifier: MIT

pragma solidity ^0.7.1;

/* A demo contract for token
 * Run the test as follows:
 * 1) create MetaCoin with account A
 * 2) Copy the address of account B
 * 3) run MetaCoin.sendCoin(account B, 100) with account A
 * 4) check MetaCoin.getBalance(account B) for balance of account B.
 * 5) check MetaCoin.getBalanceInEth(account B, 2) for balance in Eth.
 * 6) check MetaCoin.getBalance(account A) for balance of account A. 
 */

library ConvertLib{
	function convert(uint amount,uint conversionRate) public pure returns (uint convertedAmount)
	{
		return amount * conversionRate;
	}
}

contract MetaCoin {
    mapping (address => uint) public balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() {
        balances[msg.sender] = 10000;
    }

    function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
        if (balances[msg.sender] < amount) return false;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function getBalanceInEth(address addr) public view returns(uint){
        return ConvertLib.convert(getBalance(addr),2);
    }

    function getBalance(address addr) public view returns(uint) {
        return balances[addr];
    }
}
