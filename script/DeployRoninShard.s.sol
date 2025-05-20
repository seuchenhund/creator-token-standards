// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";
import "src/RoninShard.sol";

contract DeployRoninShard is Script {
    function run() external {
        //string memory name = "RoninShard";
        //string memory symbol = "SHRD";

        string memory name = "RSTest";
        string memory symbol = "RST";

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        RoninShard shard = new RoninShard(name, symbol);

        vm.stopBroadcast();

        console2.log("RoninShard deployed at:", address(shard));
    }
}
