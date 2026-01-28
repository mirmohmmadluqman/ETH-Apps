// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract EtherWallet {
    address payable public owner;
    mapping(address => uint256) private attempts;
    mapping(address => bool) public blacklisted;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    // function withdraw() external {
    //     require(!blacklist[msg.sender], "Bro, You are blacklisted. Don't try to call it.");

    //     if (msg.sender != owner) {
    //         attempts[msg.sender]++;

    //         if (attempts[msg.sender] >= 2) {
    //             blacklist[msg.sender] = true;
    //         }

    //         revert("C'mon man you are not owner");
    //     }

    //     payable(owner).transfer(address(this).balance);
    // }

    function withdraw() external {
        if (msg.sender != owner) {
            attempts[msg.sender]++;
            
            if (attempts[msg.sender] >= 2) {
                blacklisted[msg.sender] = true;
                revert("Bro, You are blacklisted. Don't try to call it.");
            }
            
            revert("Cmon man you are not owner");
        }
        
        payable(owner).transfer(address(this).balance);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
