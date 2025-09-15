// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";
import "src/BRon.sol";

contract MintBRon is Script {
    function run() external {
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");
        address recipient = 0xC583614De340462b9aC134d3d1eC06DFc4B6c6F6;

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        BRon token = BRon(tokenAddress);

        token.mint(recipient, 100000 * 1e18);

        vm.stopBroadcast();

        console2.log("BRon minted to:", recipient);
    }
}
