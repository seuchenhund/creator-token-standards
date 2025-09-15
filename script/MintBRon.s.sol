// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";
import "src/BRon.sol";

contract MintBRon is Script {
    function run() external {
        address tokenAddress = 0xD6E9fce9fA9620A1Dc53f4d6Ff92686B916694DD;
        address recipient = 0x7d1Ab76DFd343cA0354b6bdbe9E38871BcbDFab3;

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        BRon token = BRon(tokenAddress);

        token.mint(recipient, 100000 * 1e18);

        vm.stopBroadcast();

        console2.log("BRon minted to:", recipient);
    }
}
