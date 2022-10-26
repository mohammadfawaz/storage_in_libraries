library ownable;

dep utils;

use utils::*;

pub struct OwnershipTransferred {
    previous_owner: b256, 
    new_owner: b256, 
}

// Implementing this ABI for a contract requires you to set `owner` below
abi Ownable { 
    // Associated constants
    const owner: StorageRef<b256>, // to be set in the contract

    // Interface
    // Nothing here. No need to implement anything in the contract
} {
    // Associated methods. These are default-implemented
    #[storage(read)]
    fn owner() -> b256 {
        Self::owner.read()
    }

    #[storage(read)]
    fn only_owner() {
        assert(std::chain::auth::msg_sender().unwrap() == Identity::Address(~Address::from(Self::owner.read())));
    }

    #[storage(write)]
    fn renounce_ownership() {
        Self::owner.write(std::constants::ZERO_B256);
    }

    #[storage(read, write)]
    fn transfer_ownership(new_owner: b256) {
        assert(new_owner != std::constants::ZERO_B256);
        let old_owner = Self::owner.read();
        Self::owner.write(new_owner);
        std::logging::log(OwnershipTransferred {
            previous_owner: old_owner,
            new_owner: new_owner,
        });
    }
}
