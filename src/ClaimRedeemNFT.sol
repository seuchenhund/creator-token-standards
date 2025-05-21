// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/utils/Context.sol";

interface IMyERC20 {
    function mint(address to, uint256 amount) external;
    function burn(address account, uint256 amount) external;
}

contract ClaimRedeemNFT is ERC721Enumerable, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;

    IMyERC20 public immutable erc20;
    uint256 public nextTokenId;
    uint256 public constant DAILY_CLAIM_AMOUNT = 10 * 1e18;
    uint256 public constant REDEEM_COST = 5 * 1e18;
    mapping(address => uint256) public lastClaimed;

    constructor(address _erc20) ERC721("TestNFT", "TNFT") {
        erc20 = IMyERC20(_erc20);
    }

    function hasClaimedToday(address user) public view returns (bool) {
        uint256 last = lastClaimed[user];
        return block.timestamp - last < 1 days;
    }

    /// @notice Claim 10 ERC20 tokens once per day
    function claim() external {
        require(!hasClaimedToday(msg.sender), "Already claimed today");
        lastClaimed[msg.sender] = block.timestamp;
        erc20.mint(msg.sender, DAILY_CLAIM_AMOUNT);
    }

    /// @notice Redeem 10 ERC20 tokens to mint one NFT
    function redeem() external {
        erc20.burn(msg.sender, REDEEM_COST);
        _safeMint(msg.sender, nextTokenId++);
    }

    /// @dev Admin can mint NFTs directly (optional)
    function adminMint(address to) external onlyOwner {
        _safeMint(to, nextTokenId++);
    }
}