// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

contract ArrayExample {

    // dynamic length array
    bytes32[] public names;
    
    // fixed length array
    bytes[4] public fNames;
    
    function arrTest() public returns(uint) {
        // assign inline
        string[4] memory _inlineArray = ["sam","mike","peter","mckay"];
        
        // multi dimensional array
        uint[3][] memory multiArray;
        
        fNames[0] = "Matt";
        
        names.push("JON");
        names.push("PURDY");
        
        // initializing multi dimensional array
        multiArray = new uint[3][](2); // number of rows = 2
        
        multiArray[0][1] = 20;
        
        return multiArray[0][1];
    }
    
    function getFNamesLength() public view returns(uint256){
        return fNames.length;
    }
    
    function getNamesLength() public view returns(uint256){
        return names.length;
    }
}