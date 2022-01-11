# Shared Wallet with Allowance Function

## Real-World Use-Case for this Project
- Allowance for Children per day/week/month to be able to spend a certain amount of funds.
- Employers give employees an allowance for their travel expenses.
- Businesses give contractors an allowance to spend a certain budget.
Development-Goal
- Have an on-chain wallet smart contract.
- This wallet contract can store funds and let users withdraw again.
- You can also give “allowance” to other, specific user-addresses.
- Restrict the functions to specific user-roles (owner, user)
- Re-Use existing smart contracts which are already audited to the greatest extent

## Contents
- Step 1 – We Define the Basic Smart Contract
- Step 2 – Permissions: Allow only the Owner to Withdraw Ether
- Step 3 – Permissions: Use Re-Usable Smart Contracts from OpenZeppelin
- Step 4 – Permissions: Add Allowances for External Roles
- Step 5 – Improve/Fix Allowance to avoid Double-Spending 
- Step 6 – Improve Smart Contract Structure
- Step 7 – Add Events in the Allowances Smart Contract
- Step 8 – Add Events in the SharedWallet Smart Contract
- Step 9 – Add the SafeMath Library safeguard Mathematical Operations
- Step 10 – Remove the Renounce Ownership functionality
- Step 11 – Move the Smart Contracts into separate Files

## The Final Smart Contract(s)
- File: `Allowance.sol`
- File: `SmartContract.sol`

### Step 1 – We Define the Basic Smart Contract

This is the very basic smart contract. It can receive Ether and it’s possible to withdraw Ether, but all in all, not very useful quite yet. 

Let’s see if we can improve this a bit in the next step.

```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract SharedWallet {

    function withdrawMoney(address payable _to, uint _amount) public {
        _to.transfer(_amount);
    }

    //prior sol0.6 the receive function is the function() external payable
    receive() external payable {
    }
}
```

### Step 2 – Permissions: Allow only the Owner to Withdraw Ether

In this step we restrict withdrawal to the owner of the wallet. How can we determine the owner? It’s the user who deployed the smart contract.

```js 
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract SharedWallet {
    address owner;
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, &quot;You are not allowed&quot;);
        _;
    }

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    receive() external payable {
    }
}
```

### Step 3 – Permissions: Use Re-Usable Smart Contracts from OpenZeppelin

Having the owner-logic directly in one smart contract isn’t very easy to audit. Let’s break it down into smaller parts and re-use existing audited smart contracts from OpenZeppelin for that. 

>The latest OpenZeppelin contract does not have an `isOwner()` function anymore, so we have to create our own. Note that the owner() is a function from the `Ownable.sol` contract.

```js
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }
    receive() external payable {
    }
}
```

### Step 4 – Permissions: Add Allowances for External Roles
In this step we are adding a mapping so we can store `address` > `uint` amounts. This will be like an array that stores `[0x123546…]` an address, to a specific number. So, we always know how much someone can withdraw. We also add a new modifier that checks: Is it the owner itself or just someone with allowance?

```js
// SPDX-License-Identifier:MIT

pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
  
    mapping(address =&gt; uint) public allowance;

    function addAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
    
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount >;= address(this).balance, "Contract doesn't own enough money");
        _to.transfer(_amount);
    }

    receive() external payable {
    }
}
```

### Step 5 – Improve/Fix Allowance to avoid Double-Spending
Without reducing the allowance on withdrawal, someone can continuously withdraw the same amount over and over again. We have to reduce the allowance for everyone other than the owner.

```js
    function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount)
    {   
        allowance[_who] -= _amount;
    }

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amoun t) {
        require(_amount >= address(this).balance, "Contract doesn't own enough money"); 
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }
```

### Step 6 – Improve Smart Contract Structure
Now we know our basic functionality, we can structure the smart contract differently. To make it easier to read, we can break the functionality down into two distinct smart contracts. Note that since Allowance is `Ownable`, and the `SharedWallet` is Allowance, therefore by commutative property, `SharedWallet` is also `Ownable`.

```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    function isOwner() internal view returns(bool) { 
        return owner() == msg.sender;
    }

    mapping(address =&gt; uint) public allowance;

    function setAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!"); 
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount)
    {
        allowance[_who] -= _amount;
    }
}

contract SharedWallet is Allowance {
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount >= address(this).balance, "Contract doesn't own enough money"); 
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }
    receive() external payable {
    }
}
```

### Step 7 – Add Events in the Allowances Smart Contract
One thing that’s missing is events.

```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {

event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);

mapping(address =&gt; uint) public allowance;

    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    function setAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }
}

contract SharedWallet is Ownable, Allowance {
        //…
}
```

### Add Events in the SharedWallet Smart
```js
contract SharedWallet is Ownable, Allowance {
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount >= address(this).balance, "Contract doesn't own enough money");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}
```

### Step 9 – Add the SafeMath Library safeguard Mathematical Operations
```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol"; 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint;
    event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);
    mapping(address =&gt; uint) public allowance;

    function isOwner() internal view returns(bool) { 
        return owner() == msg.sender;
    }

    function setAllowance(address _who, uint _amount) public onlyOwner {
        //...
    }

    modifier ownerOrAllowed(uint _amount) {
        //...
    }

    function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
     }
}

contract SharedWallet is Allowance {
    //...
}
```

### Step 10 – Remove the Renounce Ownership

```js
contract SharedWallet is Allowance {
    //...

    function renounceOwnership() public onlyOwner {
        revert("can't renounceOwnership here"); 
        //not possible with this smart contract
    }
    //...
}
```

### Step 11 – Move the Smart Contracts into separate Files
`Allowance.sol:`
```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol"; 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract Allowance is Ownable {
    //...
}
```

`SharedWallet.sol:`
```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol"; 
import "./Allowance.sol";

contract SharedWallet is Allowance {
    //...
}
```

## The Final Smart Contract(s)
### File: `Allowance.sol`
```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract Allowance is Ownable {
    using SafeMath for uint;
    event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);
    mapping(address => uint) public allowance;

    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    function setAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] &gt;= _amount, &quot;You are not allowed!&quot;);
        _;
    }
    function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }

    function renounceOwnership() public onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }
}
```

### File: `SharedWallet.sol`

```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol"; 
import "./Allowance.sol";

contract SharedWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount >= address(this).balance, "Contract doesn&#39;t own enough money");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}
```

