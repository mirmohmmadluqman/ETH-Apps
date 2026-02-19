// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MultiSigWallet{
    event Deposit();
    event SubmitTransaction();
    event ConfirmTransaction();
    event RevokeConfirmation();
    event ExecuteTransaction();

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public numConfirmationsRequired;

    struct Transaction{
        address to;
        uint256 value;
        bytes data;
        bool executed;
        uint256 numConfirmations;
    }

    mapping(uint256 => mapping(address => bool)) public isConfirmed; // mapping from tx index => owner => bool
    Transaction[] public transactions;

    modifier onlyOwner(){
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier notExecuted(uint256 _txIndex) {
        require(!transactions[_txIndex].executed, "tx already executed");
        _;
    }
}

