// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "src/BRon.sol";

contract BRonTest is Test {
    BRon token;
    address admin;
    address minter;
    address burner;
    address user;

    function setUp() public {
        admin = address(this);
        minter = address(0x1);
        burner = address(0x2);
        user = address(0x3);

        token = new BRon("testName","test");

        token.grantRole(token.MINTER_ROLE(), minter);
        token.grantRole(token.BURNER_ROLE(), burner);
    }

    function testInitialRolesAssigned() public {
        assertTrue(token.hasRole(token.DEFAULT_ADMIN_ROLE(), admin));
        assertTrue(token.hasRole(token.MINTER_ROLE(), admin));
        assertTrue(token.hasRole(token.BURNER_ROLE(), admin));
    }

    function testMintByAuthorizedMinter() public {
        vm.prank(minter);
        token.mint(user, 100 ether);
        assertEq(token.balanceOf(user), 100 ether);
    }

    function testMintByUnauthorizedUserShouldRevert() public {
        vm.expectRevert("Revert: must have minter role to mint");
        vm.prank(user);
        token.mint(user, 100 ether);
    }

    function testBurnByAuthorizedBurner() public {
        // First mint tokens to user
        vm.prank(minter);
        token.mint(user, 200 ether);

        // Burn some tokens
        vm.prank(burner);
        token.burn(user, 100 ether);
        assertEq(token.balanceOf(user), 100 ether);
    }

    function testBurnByUnauthorizedUserShouldRevert() public {
        vm.expectRevert("Revert: must have burner role to burn");
        vm.prank(user);
        token.burn(user, 100 ether);
    }
}