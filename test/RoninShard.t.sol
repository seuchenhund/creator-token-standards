// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "src/RoninShard.sol";

contract RoninShardTest is Test {
    RoninShard shard;
    address admin;
    address minter;
    address burner;
    address user;

    function setUp() public {
        admin = address(this);
        minter = address(0x1);
        burner = address(0x2);
        user = address(0x3);

        shard = new RoninShard("testName","test");

        shard.grantRole(shard.MINTER_ROLE(), minter);
        shard.grantRole(shard.BURNER_ROLE(), burner);
    }

    function testInitialRolesAssigned() public {
        assertTrue(shard.hasRole(shard.DEFAULT_ADMIN_ROLE(), admin));
        assertTrue(shard.hasRole(shard.MINTER_ROLE(), admin));
        assertTrue(shard.hasRole(shard.BURNER_ROLE(), admin));
    }

    function testMintByAuthorizedMinter() public {
        vm.prank(minter);
        shard.mint(user, 100 ether);
        assertEq(shard.balanceOf(user), 100 ether);
    }

    function testMintByUnauthorizedUserShouldRevert() public {
        vm.expectRevert("RoninShard: must have minter role to mint");
        vm.prank(user);
        shard.mint(user, 100 ether);
    }

    function testBurnByAuthorizedBurner() public {
        // First mint tokens to user
        vm.prank(minter);
        shard.mint(user, 200 ether);

        // Burn some tokens
        vm.prank(burner);
        shard.burn(user, 100 ether);
        assertEq(shard.balanceOf(user), 100 ether);
    }

    function testBurnByUnauthorizedUserShouldRevert() public {
        vm.expectRevert("RoninShard: must have burner role to burn");
        vm.prank(user);
        shard.burn(user, 100 ether);
    }
}