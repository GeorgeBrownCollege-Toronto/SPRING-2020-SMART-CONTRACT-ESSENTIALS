import hre from "hardhat";
import {
  LoanRequest,
  LoanRequest__factory as LoanRequestFactory,
} from "../typechain";

async function main() {
  const LoanRequest: LoanRequestFactory = <LoanRequestFactory>(
    await hre.ethers.getContractFactory("LoanRequest")
  );
  const loanPurpose = Math.random().toString().substr(0, 4);
  const loanAmount: number = Math.floor(Math.random() * 100);
  const payOffAmount: number = Math.floor(Math.random() * 100);
  const loanDuration: number = Math.floor(Math.random() * 100);
  const loanRequest: LoanRequest = <LoanRequest>(
    await LoanRequest.deploy(
      loanPurpose,
      loanAmount,
      payOffAmount,
      loanDuration
    )
  );
  await loanRequest.deployed();
  console.log("LoanRequest is deployed to:", loanRequest.address);
}

main()
  .then(() => {})
  .catch((error) => {
    console.error(error);
    throw error;
  });
