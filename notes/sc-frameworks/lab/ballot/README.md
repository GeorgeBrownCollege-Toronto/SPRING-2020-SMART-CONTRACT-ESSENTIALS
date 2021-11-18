## Ballot Lab
Unit testing for `Ballot.sol` using truffle

### Lab instructions
* Copy and paste the following command in your terminal to clone the lab.

```
mkdir ballot && \
cd ./ballot && \ 
git init && \ 
git remote add origin -f https://github.com/GeorgeBrownCollege-Toronto/Smart-Contract-Essentials.git && \
git sparse-checkout init && \
git sparse-checkout set notes/sc-frameworks/lab/ballot && \
git pull origin master && \ 
mv notes/sc-frameworks/lab/ballot/* . && \
rm -rf ./.git ./notes
```

* Installation

```
npm install
```

* Make sure the contract compiles when you run `npm run compile`.

* Your task is to write unit tests for `contracts/Ballot.sol`. Start modifying `ballot.test.js` to achieve ~100% test coverage.

* Run `npm run test` to run all the tests.

* Run `npm run coverage` to check the code coverage.

> Following is an example of code coverage output.
```console
-------------|----------|----------|----------|----------|----------------|
File         |  % Stmts | % Branch |  % Funcs |  % Lines |Uncovered Lines |
-------------|----------|----------|----------|----------|----------------|
 contracts/  |      100 |    92.86 |      100 |      100 |                |
  Ballot.sol |      100 |    92.86 |      100 |      100 |                |
-------------|----------|----------|----------|----------|----------------|
All files    |      100 |    92.86 |      100 |      100 |                |
-------------|----------|----------|----------|----------|----------------|
```

> **Do not modify other files except `ballot.test.js`**

### Submission
* Submit the unit test file in the format `<STUDENT_ID>_<FIRST_NAME>_<LAST_NAME>_ballot.test.js`
* Submit the screenshot of the test coverage from the terminal
> **Do not submit whole project otherwise you will receive zero, but you can re-submit :)**