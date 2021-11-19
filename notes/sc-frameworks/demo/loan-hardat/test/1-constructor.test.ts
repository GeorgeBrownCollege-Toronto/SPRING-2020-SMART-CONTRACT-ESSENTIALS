import hre, { artifacts } from "hardhat";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signer-with-address";
import type { Loan } from "../typechain";
import { expect } from "chai";
import { Artifact } from "hardhat/types";
import { Signers } from "./types";

let mutex: boolean = true;
let loanDuration: number;
let payOffAmount: number;
describe("Loan constructor test", () => {
  before(async function () {
    this.signers = {} as Signers;
    const signers: SignerWithAddress[] = await hre.ethers.getSigners();
    this.signers.borrower = signers[0];
    this.signers.lender = signers[1];
  });

  beforeEach(async function () {
    if (mutex) {
      loanDuration = Math.floor(Math.random() * 1000);
      payOffAmount = Math.floor(Math.random() * 1000);
      mutex = false;
    }
    const loanArtifact: Artifact = await artifacts.readArtifact("Loan");
    this.loan = <Loan>(
      await hre.waffle.deployContract(this.signers.borrower, loanArtifact, [
        this.signers.lender.address,
        this.signers.borrower.address,
        payOffAmount,
        loanDuration,
      ])
    );
  });

  describe("constructor works and state field are set", () => {
    it("sets lender", async function () {
      expect(await this.loan.lender()).to.equal(this.signers.lender.address);
    });
    it("sets borrower", async function () {
      expect(await this.loan.borrower()).to.equal(
        this.signers.borrower.address
      );
    });
    it("sets payOffAmount", async function () {
      expect(await this.loan.payOffAmount()).to.equal(payOffAmount);
    });
    it("sets loanDuration", async function () {
      expect(await this.loan.loanDuration()).to.equal(loanDuration);
    });
    it("sets updatedDate", async function () {
      const tx = await this.loan.deployed();
      const txBlock = await tx.provider.getBlockNumber();
      const { timestamp } = await this.loan.provider.getBlock(txBlock);
      expect(await this.loan.updatedDate()).to.at.least(timestamp);
    });
    it("sets dueDate", async function () {
      const tx = await this.loan.deployed();
      const txBlock = await tx.provider.getBlockNumber();
      const { timestamp } = await this.loan.provider.getBlock(txBlock);
      expect(await this.loan.dueDate()).to.at.least(timestamp + loanDuration);
    });
  });
});
