// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/ClaimRedeemNFT.sol";
import "../src/BRon.sol";

contract DeployClaimRedeemNFT is Script {
    function run() external {
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        ClaimRedeemNFT nft = new ClaimRedeemNFT(tokenAddress);

        BRon token = BRon(tokenAddress);

        token.grantRole(token.MINTER_ROLE(), address(nft));
        token.grantRole(token.BURNER_ROLE(), address(nft));

        vm.stopBroadcast();

        console2.log("ClaimRedeemNFT deployed at:", address(nft));
    }
}
