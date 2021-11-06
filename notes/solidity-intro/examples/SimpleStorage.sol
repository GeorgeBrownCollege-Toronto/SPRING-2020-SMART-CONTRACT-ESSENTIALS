// SPDX-License-Identifier: UNLICENSED
 
pragma solidity 0.8.9;
 
error Unauthorized(); 
error UnauthorizedSet(uint256);
error UnauthorizedIncrement();
error UnauthorizedIncrementWithNumber(uint256);
error UnauthorizedDecrement();
error UnauthorizedDecrementWithNumber(uint256);
 
contract SimpleStorage {
     uint8 storedData;  // 0 to (2^256 -1) - uin8 ,uint16 to uint256
     address owner; // Ethereum address is 20 bytes
     
     event Set(address indexed caller, uint8 indexed storedData);
     event Increment(address indexed caller, uint8 indexed storedData, uint8 indexed incrementalValue);
     event Decrement(address indexed caller, uint8 indexed storedData,uint8 indexed decrementalValue);
     
     struct Member {
         string name;
         bool isWhiteListed;
     }
     
    //  mapping(address => bool) whiteListed;
    mapping(address => Member) whiteListed;
     
     constructor(uint8 $x, string memory $name) {
         assert($x > 0);
         storedData = $x;
         owner = msg.sender; // contract's deployer
         whiteListed[msg.sender].isWhiteListed = true;
         whiteListed[msg.sender].name = $name;
     }
     
     function getWhitelisted(address $account) public view returns(Member memory) {
         return whiteListed[$account];
     }
     
     function setWhitelisted(address $account, string memory $name) public {
         if(owner != msg.sender) {
             revert Unauthorized();
         }
         whiteListed[$account].name = $name;
         whiteListed[$account].isWhiteListed = true;
     }
     
     function setWhitelisted(address $account, Member memory $member) public {
         if(owner != msg.sender) {
             revert Unauthorized();
         }
        //  whiteListed[$account].name = $name;
        //  whiteListed[$account].isWhiteListed = true;
        require($member.isWhiteListed,"cannot unset");
        whiteListed[$account] = $member;
     }
     
     function unsetWhitelisted(address $account) public {
         if(owner != msg.sender) {
             revert Unauthorized();
         }
        require(owner != $account, "you cannot blacklist owner");
        whiteListed[$account].isWhiteListed = false;
     }
     
     function set(uint8 $x) public {
         if(owner != msg.sender) {
             revert UnauthorizedSet($x);
         }
         storedData = $x;
         emit Set(msg.sender,storedData);
     }
     
     function get() public view returns(uint8) {
         return storedData;
     }
     
     function add(uint256 $a , uint256 $b) public pure returns(uint256) {
         return $a + $b;
     }
     
     modifier onlyOwner() {
        //  if(owner != msg.sender) {
        //      revert("unauthorized");
        //  }
        //  require(<true-condition>,<optional-error-string>)
        require(owner == msg.sender,"unauthorized");
         _;
     }
     
     modifier greaterThanZero(uint8 $x) {
         require($x > 0,"number should be greater than zero");
         _;
     }
     
     
     modifier onlyWhitelisted() {
        //  require(whiteListed[msg.sender] == true,"you are not whitelisted");
        // or
        require(whiteListed[msg.sender].isWhiteListed,"you are not whitelisted");
         _;
     }
     
     function _onlyOwner() private view {
         require(owner == msg.sender,"unauthorized");
     }
     
     function increment(uint8 $x) public greaterThanZero($x) onlyWhitelisted() { // "increment(uint8)"
        //  if(owner != msg.sender) {
        //      revert UnauthorizedIncrementWithNumber($x);
        //  }
         storedData += $x; // storedData = storedData + $x
         emit Increment(msg.sender, storedData, $x);
     }
     
     function increment() public onlyWhitelisted() { // "increment()"
    //  if(owner != msg.sender) {
    //          revert UnauthorizedIncrement();
    //      }
         storedData++; // storedData = storedData + 1
         emit Increment(msg.sender, storedData, 1);
     }
     
     function decrement(uint8 $x) public greaterThanZero($x) onlyWhitelisted() { // "decrement(uint8)"
        //  if(owner != msg.sender) {
        //      revert UnauthorizedDecrementWithNumber($x);
        //  }
         storedData -= $x; // storedData = storedData + $x
         emit Decrement(msg.sender, storedData, $x);
     }
     
     function incrementWithAssert(uint8 $x) public onlyWhitelisted() {
         assert($x > 0);
        //  if(owner != msg.sender) {
        //      revert UnauthorizedDecrementWithNumber($x);
        //  }
         storedData -= $x; // storedData = storedData + $x
         emit Increment(msg.sender, storedData, $x);
     }
     
     function decrement() public onlyWhitelisted() { // "decrement()"
    //  if(owner != msg.sender) {
    //          revert UnauthorizedDecrement();
    //      }
        unchecked {
         storedData--; // storedData = storedData - 1 
        }
        emit Decrement(msg.sender, storedData, 1);
     }
     
     function getOwner() public view returns(address) {
         return owner;
     }
 }
 