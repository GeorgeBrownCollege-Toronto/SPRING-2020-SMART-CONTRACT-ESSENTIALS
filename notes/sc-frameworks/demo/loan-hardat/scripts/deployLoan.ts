import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import hre from "hardhat";
import { Loan, Loan__factory as LoanFactory } from "../typechain";

async function main() {
  const Loan: LoanFactory = <LoanFactory>(
    await hre.ethers.getContractFactory("Loan")
  );
  const loanDuration: number = Math.floor(Math.random() * 100);
  const payOffAmount: number = Math.floor(Math.random() * 100);
  const signers: SignerWithAddress[] = await hre.ethers.getSigners();
  const lender: string = signers[0].address;
  const borrower: string = signers[1].address;
  const loan: Loan = <Loan>(
    await Loan.deploy(lender, borrower, payOffAmount, loanDuration)
  );
  await loan.deployed();
  console.log("Loan is deployed to:", loan.address);
}

main()
  .then(() => {})
  .catch((error) => {
    console.error(error);
    throw error;
  });
