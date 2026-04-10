# KratosBuild ($KRTB)

> **"kratos doesnt just destroy , he builds"**

A community-driven, fixed-supply memecoin native to the Sui blockchain. 

## Tokenomics Details

- **Ticker:** $KRTB
- **Total Fixed Supply:** 211,000,000
- **Decimals:** 9
- **Contract Type:** `sui::coin::Coin`
- **Ownership/Minting:** Renounced

## Security & Trust

The smart contract for `$KRTB` is built for maximum trust:
1. All `211,000,000` tokens are minted atomically in a single initial transaction during deployment. 
2. Immediately afterward, the `TreasuryCap` (the authority to mint or burn tokens) is permanently transferred to an unrecoverable address. This mathematical guarantee ensures the exact maximum supply is locked forever, making rug pulls via infinite mints impossible.

## Building / Publishing (Sui CLI)

To deploy KratosBuild to the Sui blockchain, install the **Sui CLI** and run the following in this directory:

```bash
sui client publish --gas-budget 100000000
```
This will process the `Move.toml` dependencies, compile `krtb.move`, and dispatch the transaction to create the coin.
