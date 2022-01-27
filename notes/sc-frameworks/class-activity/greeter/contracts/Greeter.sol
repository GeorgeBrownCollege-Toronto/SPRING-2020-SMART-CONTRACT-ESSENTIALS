// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

/** @title Greeter */
contract Greeter {
    /* Global variable that our greeter will output when poked */
    string greeting;

    /** @dev Contract constructor that sets the global `greeting` variable
     * @param _greeting A STRING value to set the global `greeting` to
     */
    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    /** Greet function
     * @return greeting The STRING value stored in the global `greeting` variable
     */
    function greet() external view returns (string memory) {
        return greeting;
    }
}
