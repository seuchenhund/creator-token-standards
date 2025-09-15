// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";
import "src/BRon.sol";

contract DeployBRon is Script {
    function run() external {
        string memory name = "Bonded Ron";
        string memory symbol = "BRON";

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        BRon token = new BRon(name, symbol);

        vm.stopBroadcast();

        console2.log("BRon deployed at:", address(token));
    }
}
