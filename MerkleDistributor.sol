// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleDistributor is ERC721 {
    bytes32 public immutable merkleRoot;
    uint256 public nextTokenId;

    // Track claimed allocations using address mapping
    mapping(address => bool) public hasClaimed;

    event Claimed(address indexed claimant, uint256 tokenId);

    constructor(
        string memory _name,
        string memory _symbol,
        bytes32 _merkleRoot
    ) ERC721(_name, _symbol) {
        require(_merkleRoot != bytes32(0), "Invalid merkle root");
        merkleRoot = _merkleRoot;
    }

    function claim(bytes32[] calldata merkleProof) external {
        require(!hasClaimed[msg.sender], "Drop already claimed by address");

        // Verify leaf component using keccak256 hash formatting
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(msg.sender))));
        require(MerkleProof.verify(merkleProof, merkleRoot, leaf), "Invalid cryptographic proof");

        hasClaimed[msg.sender] = true;
        
        uint256 currentId = nextTokenId;
        nextTokenId++;
        
        _safeMint(msg.sender, currentId);

        emit Claimed(msg.sender, currentId);
    }
}
