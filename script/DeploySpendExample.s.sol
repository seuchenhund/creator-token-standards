// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/SpendExample.sol";
import "../src/BRon.sol";

contract DeploySpendExample is Script {
    function run() external {
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        SpendExample nft = new SpendExample(tokenAddress);

        BRon token = BRon(tokenAddress);

        token.grantRole(token.MINTER_ROLE(), address(nft));
        token.grantRole(token.BURNER_ROLE(), address(nft));

        vm.stopBroadcast();

        console2.log("SpendExample deployed at:", address(nft));
    }
}
