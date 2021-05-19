// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ClientReceipt {
    event Deposit(
        address indexed _from,
        bytes4 indexed _id,
        uint _value
    );

    function deposit(bytes4 _id) public payable {
        // Events are emitted using `emit`, followed by
        // the name of the event and the arguments
        // (if any) in parentheses. Any such invocation
        // (even deeply nested) can be detected from
        // the JavaScript API by filtering for `Deposit`.
        emit Deposit(msg.sender, _id, msg.value);
    }
}