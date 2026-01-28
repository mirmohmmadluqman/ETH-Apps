// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {EtherWallet} from "../src/EtherWallet.sol";

contract EtherWalletTest is Test {
    EtherWallet public wallet;
    address public attacker;

    function setUp() public {
        wallet = new EtherWallet();
        attacker = makeAddr("attacker");
        vm.deal(address(wallet), 1 ether);
    }

    function test_ShowsBlacklistMessage() public {
        vm.startPrank(attacker);

        // Attempt 1 & 2 - get blacklisted
        vm.expectRevert("Cmon man you are not owner");
        wallet.withdraw();
        
        vm.expectRevert("Cmon man you are not owner");
        wallet.withdraw();

        // Attempt 3 - should show blacklist message
        vm.expectRevert("Bro, You are blacklisted. Don't try to call it.");
        wallet.withdraw();

        vm.stopPrank();
    }
}
