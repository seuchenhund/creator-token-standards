// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";
import "src/BRon.sol";

contract SetRolesBRon is Script {
    function run() external {
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");
        address targetMinter = 0x6b04e3C91B4A141B4F1123E71fDcf3BA7b5A088a;
        address targetBurner = 0x6b04e3C91B4A141B4F1123E71fDcf3BA7b5A088a;

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        BRon token = BRon(tokenAddress);

        token.grantRole(token.MINTER_ROLE(), targetMinter);
        token.grantRole(token.BURNER_ROLE(), targetBurner);

        vm.stopBroadcast();

        console2.log("Granted MINTER_ROLE to", targetMinter);
        console2.log("Granted BURNER_ROLE to", targetBurner);
    }
}
