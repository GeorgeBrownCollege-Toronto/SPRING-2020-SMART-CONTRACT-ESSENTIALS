Note: You'll be expected to set up your developer environment, if you haven't already. This includes installing npm, Truffle, and ganache.

# Developer Environment Setup
Your task is simply to output the following in your console via the tools/frameworks below:

    "Hello World"

To do so you must:
1. Download this repository
2. Download the required software dependencies
3. Compile the provided `Greeter.sol` "Hello World" smart contract
4. Deploy the smart contract to a test blockchain
5. Use `truffle console` then call the deployed contract's `greet()` function

**All work can be done by `cd`ing into ex1's root directory (this one).**

Note: `contract/Greeter.sol` is the same as *Homework 1*'s **ex1**. As such, it has been completed for you.

## First, a brief introduction on each of the tools we will be using and the versions that you will need to download:

1. [Node.js](https://nodejs.org/en/) (v8.4.0 or greater)— a Javascript runtime for easily building fast and scalable network applications
2. Npm (v5.0.3 or greater) — Node.js’ package ecosystem. If you already have Node.js you can simply type: `npm update` into your terminal.
3. [Truffle Framework](http://truffleframework.com/) (v3.4.9 or greater) — `npm install -g truffle` *note the -g tag installs truffle globally so don’t worry about being in any specific directory. ***if you get permission errors, run the above command as root/admin. Truffle is a development framework for Ethereum that has built in smart contract compilation, linking, and deployment. These are some of the hardest technical concepts for a Solidity developer.
4. [Ganache-cli](https://github.com/trufflesuite/ganache-cli) (v4.1.1 or greater) — `npm install -g ganache-cli` This will be our blockchain on which we will deploy and mine your contracts from truffle. Specifically ganache-cli is an Ethereum client for testing and developing. It comes with the ability to play with accounts pre-filled with millions of dollars worth of Ether (sorry you can’t keep it) and customize everything from hostnames to gasPrice.

## Instructions

1. In an empty terminal, run `ganache-cli` to initialize a default ganache-cli server. If you get errors, read the [Ganache documentation](https://github.com/trufflesuite/ganache-cli) 
2. In a separate terminal, compile your Greeter smart contract with `truffle compile`. [Truffle documentation](http://truffleframework.com/)

## Testing 

You can verify that your smart contract is implemented correctly with `truffle test`.
Be sure to have a ganache server running in a separate terminal.

## Truffle Console

Once your greeter passes the test:
1. Run `truffle migrate`.
2. Run `truffle console`. This will open up a Node JavaScript console that is connected to your ganache server. Find a way to reference the Greeter smart contract that you deployed and call both the **Constructor** and **`greet()`** functions. [Truffle console docs](http://truffleframework.com/docs/getting_started/console)

If your greeter returns "Hello World!" when prompted, then you have successfully completed the exercise. However, know that moving forward in the course, you will need to maximize your ability and knowledge of the tools and frameworks used in Ethereum Development.
