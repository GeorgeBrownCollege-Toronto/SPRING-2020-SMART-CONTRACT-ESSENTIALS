import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signer-with-address";
import type { Fixture } from "ethereum-waffle";
import type { Loan, LoanRequest } from "../typechain";

export interface Signers {
  borrower: SignerWithAddress;
  lender: SignerWithAddress;
}

declare module "mocha" {
  export interface Context {
    loan: Loan;
    loanRequest: LoanRequest;
    signers: Signers;
    loadFixture: <T>(fixture: Fixture<T>) => Promise<T>;
  }
}
