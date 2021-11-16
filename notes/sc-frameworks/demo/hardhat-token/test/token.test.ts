// import chai to use its assertion functions
import { expect } from "./chai-setup";
// import user utlities
import { setupUser, setupUsers } from "./utils";
// importing hre functions that will be used
import { ethers, deployments, getNamedAccounts, getUnnamedAccounts } from "hardhat";

// every test can call this function
async function setup() {
  // deployment is executed and reset (evm_snapshot is used for fast test)
  await deployments.fixture(["Token"]);

  const contracts = {
    Token: await ethers.getContract("Token"),
  };

  // get the token owner
  const { tokenOwner } = await getNamedAccounts();

  const users = await setupUsers(await getUnnamedAccounts(), contracts);

  return {
    ...contracts,
    users,
    tokenOwner: await setupUser(tokenOwner, contracts),
  };
}

describe("Token contract", () => {
  describe("Deployment", () => {
    it("should set the right owner", async () => {
      const { Token } = await setup();
      const { tokenOwner } = await getNamedAccounts();
      expect(await Token.owner()).to.equal(tokenOwner);
    });

    it("should assign the total supply of tokens to the owner", async () => {
      const { Token, tokenOwner } = await setup();
      const ownerBalance = await Token.balanceOf(tokenOwner.address);
      expect(await Token.totalSupply()).to.equal(ownerBalance);
    });
  });

  describe("Transactions", () => {
    it("Should transfer tokens between accounts", async () => {
      const { Token, users, tokenOwner } = await setup();

      // transfer 50 token from owner to users[0]
      await tokenOwner.Token.transfer(users[0].address, 50);
      const users0Balance = await Token.balanceOf(users[0].address);
      expect(users0Balance).to.equal(50);

      // transfer 50 tokens from users[0] to users[1]
      await users[0].Token.transfer(users[1].address, 50);
      const users1Balance = await Token.balanceOf(users[1].address);
      expect(users1Balance).to.equal(50);
      expect(await Token.balanceOf(users[0].address)).to.equal(0);
      expect(await Token.balanceOf(tokenOwner.address)).to.equal(999950);
      expect(await Token.totalSupply()).to.equal(1000000);
    });

    it("Should fail if send doesn't have enough tokens", async () => {
      const { Token, users, tokenOwner } = await setup();
      const initialOwnerbalance = await Token.balanceOf(tokenOwner.address);

      // send 1 toke from users[0] to owner
      await expect(users[0].Token.transfer(tokenOwner.address, 1)).to.be.revertedWith("");

      // the owner's balance shouldn't be changes
      expect(await Token.balanceOf(tokenOwner.address)).to.equal(initialOwnerbalance);
    });

    it("Should update balances after transfers", async () => {
      const { Token, users, tokenOwner } = await setup();
      const initialOwnerbalance = await Token.balanceOf(tokenOwner.address);

      // transfer 100 tokens from owner to users[0]
      await tokenOwner.Token.transfer(users[0].address, 100);

      // transfer 50 from owner to users[1]
      await tokenOwner.Token.transfer(users[1].address, 50);

      // check balances
      // owner
      expect(await Token.balanceOf(tokenOwner.address)).to.equal(initialOwnerbalance - 150);

      // users[0]
      expect(await Token.balanceOf(users[0].address)).to.equal(100);

      // users[1]
      expect(await Token.balanceOf(users[1].address)).to.equal(50);
    });
  });
});
