//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Loan {
    address public lender;
    address public borrower;
    uint256 public payOffAmount;
    uint256 public loanDuration;
    uint256 public updatedDate;
    uint256 public dueDate;

    event LoanPaid(
        uint256 indexed payOffAmount,
        uint256 indexed loanDuration,
        uint256 indexed timeStamp
    );

    constructor(
        address $lender,
        address $borrower,
        uint256 $payOffAmount,
        uint256 $loanDuration
    ) {
        lender = $lender;
        borrower = $borrower;
        payOffAmount = $payOffAmount;
        loanDuration = $loanDuration;
        updatedDate = block.timestamp;
        dueDate = block.timestamp + loanDuration;
    }

    function updateLoan(uint256 $payOffAmount, uint256 $loanDuration) private {
        payOffAmount = $payOffAmount;
        loanDuration = $loanDuration;
        updatedDate = block.timestamp;
        emit LoanPaid($payOffAmount, $loanDuration, block.timestamp);
    }

    function partPayment(uint256 $payOffAmount, uint256 $loanDuration)
        external
        payable
    {
        require(block.timestamp <= dueDate);
        payable(lender).transfer(msg.value);
        updateLoan($payOffAmount, $loanDuration);
    }

    function preClosure() external payable {
        require(
            msg.value == payOffAmount,
            "Pay off amount value is not correct"
        );
        payable(lender).transfer(payOffAmount);
        updateLoan(0, 0);
        selfdestruct(payable(lender));
    }
}
