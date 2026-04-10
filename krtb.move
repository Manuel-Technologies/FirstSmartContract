module krtb::krtb {
    use std::option;
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// The coin type: KratosBuild
    struct KRTB has drop {}

    /// Called once on publish – creates the currency and mints the fixed supply
    fun init(witness: KRTB, ctx: &mut TxContext) {
        let (mut treasury_cap, metadata) = coin::create_currency(
            witness,
            9,                                          // decimals
            b"KRTB",                                     // symbol
            b"kratosBuild",                             // name
            b"kratos doesnt just destroy , he builds",  // description
            option::none(),                             // icon_url (none for now)
            ctx
        );

        // Lock metadata forever – critical for credibility
        transfer::public_freeze_object(metadata);

        // Calculate total supply: 211,000,000 * 10^9
        let total_supply = 211_000_000 * 1_000_000_000;
        
        // Mint the single fixed supply to the creator's address
        coin::mint_and_transfer(&mut treasury_cap, total_supply, tx_context::sender(ctx), ctx);

        // Revoke minting rights forever by sending TreasuryCap to the burn address directly
        transfer::public_transfer(treasury_cap, @0x0);
    }
}
