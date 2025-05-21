// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/ClaimRedeemNFT.sol";
import "../src/RoninShard.sol";

contract DeployClaimRedeemNFT is Script {
    function run() external {
        address shardAddress = 0xD6E9fce9fA9620A1Dc53f4d6Ff92686B916694DD;
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        ClaimRedeemNFT nft = new ClaimRedeemNFT(shardAddress);

        RoninShard shard = RoninShard(shardAddress);

        shard.grantRole(shard.MINTER_ROLE(), address(nft));
        shard.grantRole(shard.BURNER_ROLE(), address(nft));

        vm.stopBroadcast();

        console2.log("ClaimRedeemNFT deployed at:", address(nft));
    }
}
