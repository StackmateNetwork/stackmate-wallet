# stackmate_wallet

Refactor of the_stackmate with a new modular project dir structure

# Working Docs:
Trying to classify the common modules from the specific ones:
## Cubits appearing more than once across files:
tor_cubit
master_key_cubit
fees_cubit
chain_select_cubit
logger_cubit
node_address_cubit
wallets_cubit

## Models appearing more than once across files:
transaction_model
result_model
blockchain_model
wallets_model


## Restructuring:
/app/common/cubits/new_wallet:
Child cubits can be taken out of dir common and moved into new dirs alongside/nested with their parent (wallet) cubits 

