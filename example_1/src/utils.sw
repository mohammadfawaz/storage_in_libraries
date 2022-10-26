library utils;

use std::storage::*;

pub struct StorageRef<T> {
    key: b256,
}

impl<T> StorageRef<T> {
    #[storage(read)]
    fn read(self) -> b256 {
        get(self.key)
    }

    #[storage(write)]
    fn write(self, other: b256) {
        store(self.key, other)
    }
}

// This should be a generic trait to avoid hardcoding `b256` here
pub trait Ref {
    fn as_ref(self) -> StorageRef<b256>;
}

impl<T> Ref for T {
    fn as_ref(self) -> StorageRef<b256> {
        StorageRef {
            key: __get_storage_key(),
        }
    }
}
