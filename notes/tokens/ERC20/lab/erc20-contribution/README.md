## ERC20 contributions lab

ETH charity contract

### Lab instructions

- Copy and paste the following command in your terminal to clone the lab.

```
mkdir erc20-contribution && \
cd ./erc20-contribution && \
git init && \
git remote add origin -f https://github.com/GeorgeBrownCollege-Toronto/Smart-Contract-Essentials.git && \
git sparse-checkout init && \
git sparse-checkout set notes/tokens/erc20/lab/erc20-contribution && \
git pull origin master && \
mv notes/tokens/ERC20/lab/erc20-contribution/* . && \
rm -rf ./.git ./notes
```

- Installation

```
yarn install
```

- Make sure all the tests are failing when you run `yarn test`.

- Your task is to :

  - develop a token contract that inherits from OpenZeppelin's [ERC20 contract](https://github.com/OpenZeppelin/openzeppelin-contracts#installation) and extend its functionality so that tokens can be transferred after a particular `_startTime` and before a particular `_endTime` that are provided in the constructor.
  - Implement a `Contribution` contract that users can donate ETH to.
  - In return for their ETH-based contributions, your `Contribution` contract should issue them tokens from your token contract in return.
  - Your `Contribution` contract should store the addresses of users that donate as well as the amount of ETH they have donated.
  - Develop a function in your `Contribution` contract that will accept a wallet address and return the amount of ETH that a wallet address has contributed to the `Contribution` contract
  - Develop events that emit when functions in your token and `Contribution` contract executes.

- Run `yarn test` and all the tests shall pass if the solution is correct.

> **Do not modify other files except `Contribution.sol`**

### Submission

- Submit the contract file in the format `<STUDENT_ID>_<FIRST_NAME>_<LAST_NAME>_CONTRIBUTION.sol`
  > **Do not submit whole project otherwise you will receive zero, but you can re-submit :)**
