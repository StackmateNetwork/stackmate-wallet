import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackmate_wallet/api/interface/libbitcoin.dart';
import 'package:stackmate_wallet/app/common/components/words_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/broadcast_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/chain_select_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/fees_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/logger_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/master_key_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/node_address_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/preferences_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/tor_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/wallets_cubit.dart';
import 'package:stackmate_wallet/app/landing/cubits/pin_cubit.dart';
import 'package:stackmate_wallet/pkg/_locator.dart';
import 'package:stackmate_wallet/pkg/interface/clipboard.dart';
import 'package:stackmate_wallet/pkg/interface/storage.dart';
import 'package:stackmate_wallet/pkg/mnemonic_word.dart';
import 'package:stackmate_wallet/pkg/secure_storage.dart';
// import 'package:stackmate_wallet/pkg/vibrate.dart';

class Cubits extends StatefulWidget {
  const Cubits({super.key, required this.child});
  final Widget child;

  @override
  State<Cubits> createState() => _CubitsState();
}

class _CubitsState extends State<Cubits> {
  @override
  Widget build(BuildContext context) {
    final logger = locator<Logger>();
    final storage = locator<IStorage>();
    final sstorage = locator<SStorage>();
    final networkSelectCubit = ChainSelectCubit(
      storage,
      logger,
    );
    networkSelectCubit.init();
    final torCubit = TorCubit(storage, logger);
    torCubit.start();

    final masterKeyCubit = MasterKeyCubit(sstorage, networkSelectCubit);
    masterKeyCubit.init();

    final preferencesCubit = PreferencesCubit(storage);
    preferencesCubit.init();

    final walletsCubit = WalletsCubit(
      storage,
      logger,
      networkSelectCubit,
      locator<IClipBoard>(),
    );

    final nodeAddressCubit = NodeAddressCubit(
      storage,
      networkSelectCubit,
    );
    nodeAddressCubit.init();

    final feesCubit = FeesCubit(
      storage,
      networkSelectCubit,
      nodeAddressCubit,
      torCubit,
      logger,
    );
    feesCubit.init();
    final broadcastHex = BroadcastCubit(
      logger,
      locator<IStackMateBitcoin>(),
      locator<IClipBoard>(),
      nodeAddressCubit,
      torCubit,
      networkSelectCubit,
    );

    final pinCubit = PinCubit(
      storage,
    );
    pinCubit.init();
    final wordCubit = WordsCubit(mnemonicWords: MnemonicWords());
    wordCubit.loadWords();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: networkSelectCubit),
        BlocProvider.value(value: logger),
        BlocProvider.value(value: walletsCubit),
        BlocProvider.value(value: feesCubit),
        BlocProvider.value(value: nodeAddressCubit),
        BlocProvider.value(value: preferencesCubit),
        BlocProvider.value(value: torCubit),
        BlocProvider.value(value: masterKeyCubit),
        BlocProvider.value(value: broadcastHex),
        BlocProvider.value(value: pinCubit),
        BlocProvider.value(value: wordCubit),
      ],
      child: BlocListener<ChainSelectCubit, BlockchainState>(
        listener: (context, state) {
          walletsCubit.refresh();
        },
        child: widget.child,
      ),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  void prettyPrint(String input) {
    String str = input.replaceAll(', ', ',\n    ');
    str = str.replaceAll('(', '(\n    ');
    str = str.replaceAll(')', '\n)');
    str = '\n' + str.replaceAll('),', '  ),') + '\n\n';

    print(str);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    try {
      super.onChange(bloc, change);
    } catch (e) {
      print('STATE ERROR: ' + e.toString());
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  // }
}
