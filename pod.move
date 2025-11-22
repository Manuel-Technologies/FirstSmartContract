module pod::pod {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url;

    /// The coin type: Proof of Determination
    struct POD has drop {}

    /// Called once on publish – creates the currency and gives you the TreasuryCap
    fun init(witness: POD, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency(
            witness,
            9,                                          // 9 decimals (standard)
            b"POD",                                     // symbol
            b"Proof of Determination",                 // name
            b"The first serious token launched entirely from a mobile phone using only determination and open-source tools.",
            option::some(url::new_unsafe_from_bytes(b"https://proof-of-determination.xyz/logo.png")), // change later
            ctx
        );

        // Lock metadata forever – critical for credibility
        transfer::public_freeze_object(metadata);

        // You receive full mint/burn control
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    /// Owner-only: mint new tokens
    public entry fun mint(
        cap: &mut TreasuryCap<POD>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(cap, amount, recipient, ctx);
    }

    /// Owner-only: burn tokens (deflationary mechanism)
    public entry fun burn(
        cap: &mut TreasuryCap<POD>,
        coin: Coin<POD>
    ) {
        coin::burn(cap, coin);
    }

    /// Optional: revoke your own minting rights forever (maximum trust)
    public entry fun renounce_mint_ability(cap: TreasuryCap<POD>) {
        transfer::public_transfer(cap, @0x0); // send to 0x0 = burn forever
    }
}
