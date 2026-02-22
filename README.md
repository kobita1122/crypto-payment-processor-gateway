# Crypto Payment Processor Gateway

This repository provides an expert-level solution for merchants looking to accept cryptocurrency payments directly on-chain. It bridges the gap between smart contract events and backend fulfillment logic.

### Technical Architecture
* **Non-Custodial:** Payments go directly to the merchant's smart contract or wallet.
* **Event-Driven:** Uses Ethers.js to listen for real-time `PaymentSent` events on the blockchain.
* **Scalable:** Designed to handle multiple concurrent transactions with unique `PaymentID` tracking.
* **Multi-Asset:** Compatible with ETH, BNB, MATIC, and any ERC-20 stablecoins like USDT/USDC.

### Workflow
1. **Frontend:** User clicks "Pay" and triggers a transaction with a unique Reference ID.
2. **On-Chain:** The Payment Gateway contract emits an event containing the ID and Amount.
3. **Backend:** This Node.js service detects the event, validates the amount, and updates the database.

### Setup
1. Deploy `PaymentGateway.sol` to your preferred network.
2. Update `config.js` with your RPC provider and contract address.
3. Run `node processor.js` to start the listener.
