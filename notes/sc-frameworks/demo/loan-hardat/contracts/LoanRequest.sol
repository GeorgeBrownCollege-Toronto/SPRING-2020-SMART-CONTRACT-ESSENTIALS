//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Loan} from "./Loan.sol";

contract LoanRequest {
    address public borrower;
    string public loanPurpose;
    uint256 public loanAmount;
    uint256 public payOffAmount;
    uint256 public loanDuration; // In hours

    Loan public loan;

    event LoanRequestAccepted(address loan);

    constructor(
        string memory $loanPurpose,
        uint256 $loanAmount,
        uint256 $payOffAmount,
        uint256 $loanDuration
    ) {
        loanPurpose = $loanPurpose;
        loanAmount = $loanAmount;
        payOffAmount = $payOffAmount;
        loanDuration = $loanDuration;
        borrower = msg.sender;
    }

    function lendEth() external payable {
        require(msg.value == loanAmount);
        loan = new Loan(msg.sender, borrower, payOffAmount, loanDuration);
        payable(borrower).transfer(loanAmount);
        emit LoanRequestAccepted(address(loan));
    }
}
