use fuels::{prelude::*, tx::ContractId};

// Load abi from json
abigen!(MyContract, "out/debug/test1-abi.json");

async fn get_contract_instance() -> (MyContract, ContractId) {
    // Launch a local network and deploy the contract
    let mut wallets = launch_custom_provider_and_get_wallets(
        WalletsConfig::new(
            Some(1),             /* Single wallet */
            Some(1),             /* Single coin (UTXO) */
            Some(1_000_000_000), /* Amount per coin */
        ),
        None,
    )
    .await;
    let wallet = wallets.pop().unwrap();

    let id = Contract::deploy(
        "./out/debug/test1.bin",
        &wallet,
        TxParameters::default(),
        StorageConfiguration::with_storage_path(Some(
            "./out/debug/test1-storage_slots.json".to_string(),
        )),
    )
    .await
    .unwrap();

    let instance = MyContract::new(id.to_string(), wallet);

    (instance, id.into())
}

#[tokio::test]
async fn can_get_contract_id() {
    let (_instance, _id) = get_contract_instance().await;
}
