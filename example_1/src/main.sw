contract;

dep utils;
dep ownable;

use utils::*;
use ownable::*;

use std::storage::*;

storage {
    owner: b256 = std::constants::ZERO_B256,
}

// Our main contract
abi MyContract : Ownable {
    fn test_function_1();
    fn test_function_2();
}

impl MyContract for Contract {
    // Need to set associated constants from Ownable
    const owner: StorageRef<b256> = storage.owner.as_ref();

    // Implement interface of Ownable
    // Nothing to do here

    // Implement the interface of MyContract 
    fn test_function_1() { }
    fn test_function_2() { }
}
