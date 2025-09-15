// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";
import "src/BRon.sol";

interface ICreatorTokenTransferValidator {
    function createList(string calldata name) external returns (uint48 id);
    function applyListToCollection(address collection, uint48 id) external;
    function setRulesetOfCollection(
        address collection,
        uint8 rulesetId,
        address customRuleset,
        uint8 globalOptions,
        uint16 rulesetOptions
    ) external;
    function addAccountsToList(uint48,uint8,address[] calldata) external;
}

contract CreateAndApplyRuleset is Script {
    function run() external {
        address validator = 0x721C008fdff27BF06E7E123956E2Fe03B63342e3;
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");

        uint8 rulesetId = 4;
        address customRuleset = address(0);
        uint8 globalOptions = 3;
        uint16 rulesetOptions = 1;

        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        BRon token = BRon(tokenAddress);
        token.setTransferValidator(validator);

        ICreatorTokenTransferValidator validatorContract = ICreatorTokenTransferValidator(validator);

        // Step 1: Create whitelist list
        uint48 listId = validatorContract.createList("BRon List");
        console2.log("Created whitelist with ID:", listId);

        address[] memory whitelist = new address[](1);
        whitelist[0] = 0xC583614De340462b9aC134d3d1eC06DFc4B6c6F6;
        validatorContract.addAccountsToList(listId, 1, whitelist);

        // Step 2: Apply list to collection
        validatorContract.applyListToCollection(tokenAddress, listId);
        console2.log("Applied list to collection:", tokenAddress);

        // Step 3: Set ruleset
        validatorContract.setRulesetOfCollection(
            tokenAddress,
            rulesetId,
            customRuleset,
            globalOptions,
            rulesetOptions
        );
        console2.log("Applied ruleset to collection:", tokenAddress);

        vm.stopBroadcast();
    }
}
