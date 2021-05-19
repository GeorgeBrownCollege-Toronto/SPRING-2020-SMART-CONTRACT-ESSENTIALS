// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract User {
    receive () external payable {
        revert();
    }

    // function getBalance() public view returns(uint256) {
    //     return address(this).balance;
    // }
    
    // function killCaller(Caller _caller) external {
    //     _caller.kill(payable(address(this)));
    // }
}

contract Caller {
  constructor() payable {}
  function doTransfer(address payable user) public {
    user.transfer(1 ether);
  }
 
  function doSend(address payable user) public returns(bool){
    (bool success) = user.send(1 ether);
    return success;
  }
 
  function kill(address payable target) public {
    selfdestruct(target);
  }
}