// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";

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
}

contract CreateAndApplyRuleset is Script {
    function run() external {
        address validator = 0x721C008fdff27BF06E7E123956E2Fe03B63342e3;
        address shardAddress = 0xD6E9fce9fA9620A1Dc53f4d6Ff92686B916694DD;

        uint8 rulesetId = 4;
        address customRuleset = address(0);
        uint8 globalOptions = 0;
        uint16 rulesetOptions = 0;

        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        ICreatorTokenTransferValidator validatorContract = ICreatorTokenTransferValidator(validator);

        // Step 1: Create whitelist list
        uint48 listId = validatorContract.createList("RoninShard List");
        console2.log("Created whitelist with ID:", listId);

        // Step 2: Apply list to collection
        validatorContract.applyListToCollection(shardAddress, listId);
        console2.log("Applied list to collection:", shardAddress);

        // Step 3: Set ruleset
        validatorContract.setRulesetOfCollection(
            shardAddress,
            rulesetId,
            customRuleset,
            globalOptions,
            rulesetOptions
        );
        console2.log("Applied ruleset to collection:", shardAddress);

        vm.stopBroadcast();
    }
}
