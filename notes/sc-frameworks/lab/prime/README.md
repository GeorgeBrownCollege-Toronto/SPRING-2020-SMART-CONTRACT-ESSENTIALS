## Prime number lab
Check whether number is prime or not.

### Lab instructions
* Copy and paste the following command in your terminal to clone the lab.

```
mkdir prime && \
cd ./prime && \ 
git init && \ 
git remote add origin -f https://github.com/GeorgeBrownCollege-Toronto/Smart-Contract-Essentials.git && \
git sparse-checkout init && \
git sparse-checkout set notes/sc-frameworks/lab/prime && \
git pull origin master && \ 
mv notes/sc-frameworks/lab/prime/* . && \
rm -rf ./.git ./notes
```

* Installation

```
yarn install
```

* Make sure all the tests are failing when you run `yarn test`.

* Your task is to create a function called `isPrime` in `contracts/Prime.sol` that takes a `uint256` parameter and returns a bool indicating if the number is a prime number.

> A prime number is a number that is only evenly divisible by 1 and itself.

* Run `yarn test` and all the tests shall pass if the solution is correct.

> **Do not modify other files except `Prime.sol`**

### Submission
* Submit the contract file in the format `<STUDENT_ID>_<FIRST_NAME>_<LAST_NAME>_PRIME.sol`
> **Do not submit whole project otherwise you will receive zero, but you can re-submit :)**