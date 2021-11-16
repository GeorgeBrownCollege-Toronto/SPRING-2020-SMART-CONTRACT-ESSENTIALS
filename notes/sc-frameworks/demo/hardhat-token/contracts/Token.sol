// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Token {
    string public name = "The GBC Token";

    string public symbol = "GBC";

    uint256 public totalSupply = 1000000;

    mapping(address => uint256) public balances;

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _amount);

    address public owner;

    constructor(address _owner) {
        balances[_owner] = totalSupply;
        owner = _owner;
    }

    function transfer(address _receiver, uint256 _amount) external {
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_receiver] = balances[_receiver] + _amount;
        emit Transfer(msg.sender, _receiver, _amount);
    }

    function balanceOf(address _account) public view returns (uint256 _balance) {
        _balance = balances[_account];
    }

    function transFerETHBalance() external payable {
        (bool _success, ) = msg.sender.call{ value: msg.value }("");
        require(_success, "Token:success");
    }

    /* solhint-disable no-empty-blocks */
    function testCodeComplexity(
        uint256 a,
        uint256 b,
        uint256 c,
        uint256 d,
        uint256 e
    ) external pure {
        if (a > b) {
            if (b > c) {
                if (c > d) {
                    if (d > e) {} else {}
                }
            }
        }
        for (uint256 i = 0; i < b; i += 1) {}
        do {
            d++;
        } while (b > c);
        while (d > e) {}
    }
    /* solhint-disable no-empty-blocks */
}
