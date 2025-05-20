// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";
import "src/RoninShard.sol";

contract SetRolesRoninShard is Script {
    function run() external {
        address shardAddress = 0xD6E9fce9fA9620A1Dc53f4d6Ff92686B916694DD;
        address targetMinter = 0x6b04e3C91B4A141B4F1123E71fDcf3BA7b5A088a;
        address targetBurner = 0x6b04e3C91B4A141B4F1123E71fDcf3BA7b5A088a;

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        RoninShard shard = RoninShard(shardAddress);

        shard.grantRole(shard.MINTER_ROLE(), targetMinter);
        shard.grantRole(shard.BURNER_ROLE(), targetBurner);

        vm.stopBroadcast();

        console2.log("Granted MINTER_ROLE to", targetMinter);
        console2.log("Granted BURNER_ROLE to", targetBurner);
    }
}
