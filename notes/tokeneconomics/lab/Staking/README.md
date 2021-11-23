## Decentralized staking application
Build a `Staker.sol` contract that collects **ETH** from numerous addresses using a payable `stake()` function and keeps track of `balances`. After some `deadline` if it has at least some `threshold` of ETH, it sends it to an `ExampleExternalContract` and triggers the `complete()` action sending the full balance. If not enough **ETH** is collected, allow users to `withdraw()`.
### Lab Instructions
* You can use any smart contract IDE of your choice - Remix, Truffle or Hardhat. Writing automation mocha test cases are not required for this lab.

* Everything starts by editing `Staker.sol`.

* You'll need to track individual `balances` using a mapping:
```solidity
mapping ( address => uint256 ) public balances;
```

* And also track a constant `threshold` at ```1 ether```
```solidity
uint256 public constant threshold = 1 ether;
```

* Write your `stake()` function

* Have `Stake(address,uint256)` event that gets emitted evertime **ETH** is staked.

#### Checklist

- [ ] Do you see the balance of the `Staker` contract go up when you `stake()`?
- [ ] Is your `balance` correctly tracked?
- [ ] Do you see the events logs in the transaction receipt?

### Manual testing 


* Set a `deadline` of ```block.timestamp + 30 seconds```
```solidity
uint256 public deadline = now + 30 seconds;
```

* Write your `execute()` function and test it

* If the `address(this).balance` of the contract is over the `threshold` by the `deadline`, you will want to call: ```exampleExternalContract.complete{value: address(this).balance}()```

* If the balance is less than the `threshold`, you want to set a `openForWithdraw` bool to `true` and allow users to `withdraw(address payable)` their funds.

(You'll have 30 seconds after deploying until the deadline is reached)

* Create a `timeLeft()` function including ```public view returns (uint256)``` that returns how much time is left.

* Be careful! if `block.timestamp >= deadline` you want to ```return 0;```

* If you testing the contracts on IDE's blockchain like Remix's inbuilt sandbox chain, ganache or hardhat node then the time will only update if a transaction occurs.

#### Checklist
- [ ] Can you query `timeLeft` while you trigger a transaction within dev IDE environment?
- [ ] If you `stake()` enough ETH before the `deadline`, does it call `complete()`?
- [ ] If you don't `stake()` enough can you `withdraw(address payable)` your funds?
- [ ] Make sure funds can't get trapped in the contract! Try sending funds after you have executed!
- [ ] Try to create a called `notCompleted`. It will check that `ExampleExternalContract` is not completed yet. Use it to protect your `execute` and `withdraw` functions.

#### Submit the answers for the following questions along the contract url link.
- [ ] Can execute get called more than once, and is that okay?
- [ ] Can you deposit and withdraw freely after the `deadline`, and is that okay?
- [ ] What are other implications of *anyone* being able to withdraw for someone?
- [ ] Can you implement your own that checks whether `deadline` was passed or not? Where can you use it?

### Submission Instructions
* The final **deliverable** is deploying a decentralized application to a public blockchain, verifying the smart contract on Etherscan, interacting with deployed smart contract and submitting the etherscan deployed contract url.
* Each `payable/non-payable` `public/external` function of the contract shall be tested and I will verify that from the etherscan's transaction lists. 