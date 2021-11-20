import hre, { artifacts } from "hardhat";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signer-with-address";
import { expect } from "chai";
import { Artifact } from "hardhat/types";
import type { GBCToken } from "../typechain";
import { Signers } from "./types";

export async function getBlockTimestamp(): Promise<number> {
  const blockNumber = await hre.ethers.provider.getBlockNumber();
  const block = await hre.ethers.provider.getBlock(blockNumber);
  const timestamp = block.timestamp;
  return timestamp;
}

describe("GBC Token", function () {
  before(async function () {
    this.signers = {} as Signers;
    const signers: SignerWithAddress[] = await hre.ethers.getSigners();
    this.signers.admin = signers[0];
    this.signers.alice = signers[1];
    this.signers.bob = signers[2];
    const GBCTokenArtifact: Artifact = await artifacts.readArtifact("GBCToken");
    this.startTime = (await getBlockTimestamp()) + 1;
    this.endTime = this.startTime + 2000000;
    this.totalSupply = "100000000000000000000";
    this.symbol = "GBC";
    this.name = "GBC Token";
    this.gbcToken = <GBCToken>(
      await hre.waffle.deployContract(this.signers.admin, GBCTokenArtifact, [
        this.startTime,
        this.endTime,
        this.name,
        this.symbol,
        this.totalSupply,
      ])
    );
  });

  describe("Should pass", function () {
    it("sets starttime", async function () {
      expect(await this.gbcToken.startTime()).to.equal(this.startTime);
    });
    it("sets endtime", async function () {
      expect(await this.gbcToken.endTime()).to.equal(this.endTime);
    });
    it("sets totalsupply", async function () {
      expect(await this.gbcToken.totalSupply()).to.equal(this.totalSupply);
    });
    it("sets name", async function () {
      expect(await this.gbcToken.name()).to.equal(this.name);
    });
    it("sets symbol", async function () {
      expect(await this.gbcToken.symbol()).to.equal(this.symbol);
    });
    it("sets balanceOf", async function () {
      expect(
        await this.gbcToken.balanceOf(this.signers.admin.address)
      ).to.equal(this.totalSupply);
    });
    it("restricts transfer", async function () {
      await hre.network.provider.request({
        method: "evm_increaseTime",
        params: [(await getBlockTimestamp()) - 3000],
      });
      await expect(
        this.gbcToken.transfer(
          this.signers.alice.address,
          "10000000000000000000"
        )
      ).to.be.revertedWith("Token sale has ended");
    });
  });
});
