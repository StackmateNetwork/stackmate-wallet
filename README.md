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

## Code:
const emptyString is defined in xpub_import_cubit and seed_generate_wallet_cubit. Move it outside of cubits into a consts file.


# Dev: Known Issues:
  These issues are during dev only, not with the app

  1. FFIs: 
  flutter run
  Error: 
  "Could not locate libstackmate.so" or similar @ libbitcoin.dart 

  Patch:
  libstackmate core-init.sh generated FFIs in new dir @ android/src/main/jniLibs. FFIs must be placed @ android/app/src/main/jniLibs in order to bind with Android.   

  2. Build runner: no pubspec.yaml found 
  
    dart run build_runner build --delete-conflicting-outputs
    
    Error: 
    Bad state: Unable to generate package graph, no `/home/anorak/Anorak/Stackmate/stackmate-wallet/stackmate_wallet/.dart_tool/flutter_gen/pubspec.yaml` found. 
  
    Patch:
    Setting 
    flutter:
        generate:true 
    in pubspec.yaml causes conflict with build runner. Set to false or comment out for build_runner.


## Restructuring:
/app/common/cubits/new_wallet:
Child cubits can be taken out of dir common and moved into new dirs alongside/nested with their parent (wallet) cubits 

