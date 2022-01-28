import { expect } from "chai";
import { ethers, deployments, getNamedAccounts } from 'hardhat';
import { Greeter } from "../typechain";


describe("Greeter", function () {
  it("(New deployment) Should return the new greeting once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("Greeter");
    const greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();

    expect(await greeter.readGreet()).to.equal("Hello, world!");

    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.readGreet()).to.equal("Hola, mundo!");
  });

  it("(Existing deployment) Should return the new greeting once it's changed", async function () {
    await deployments.fixture("Greeter");
    const greeterInstance = <Greeter>await ethers.getContract('Greeter');
    expect(await greeterInstance.readGreet()).to.eq("Hello, world!")
    await greeterInstance.setGreeting("Hello GBC")
    expect(await greeterInstance.readGreet()).to.eq("Hello GBC")
  })
});
