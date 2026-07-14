# Merkle NFT Distributor

An expert-level, gas-efficient implementation for managing white-listed NFT public distribution events. Instead of saving thousands of individual white-listed user addresses directly inside the smart contract state storage (which consumes expensive on-chain gas deployment resources), this contract records a solitary 32-byte Merkle Root. Eligible claimants present a corresponding cryptographic Merkle Proof to mint their authorized assets.

## Features
- **Highly Scalable Whitelists:** Distribute to thousands of users with zero per-address storage cost overhead.
- **Strict One-Time Claims:** Implements bitmapping mechanics to track and secure redemption history.
- **Industry Standards Compliance:** Seamlessly imports OpenZeppelin ERC721 token definitions.

## Installation

1. Install project packages:
   ```bash
   npm install
