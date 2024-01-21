import 'package:get_it/get_it.dart';
import 'package:stackmate_wallet/api/cpsocket.dart';
import 'package:stackmate_wallet/api/interface/cpsocket.dart';
import 'package:stackmate_wallet/api/interface/libbitcoin.dart';
import 'package:stackmate_wallet/api/interface/logger.dart';
import 'package:stackmate_wallet/api/libbitcoin.dart';
import 'package:stackmate_wallet/api/logger.dart';
import 'package:stackmate_wallet/app/common/cubits/logger_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/new_wallet/common/words_cubit.dart';
import 'package:stackmate_wallet/pkg/clipboard.dart';
import 'package:stackmate_wallet/pkg/interface/clipboard.dart';
import 'package:stackmate_wallet/pkg/interface/launcher.dart';
import 'package:stackmate_wallet/pkg/interface/share.dart';
import 'package:stackmate_wallet/pkg/interface/storage.dart';
import 'package:stackmate_wallet/pkg/interface/vibrate.dart';
import 'package:stackmate_wallet/pkg/launcher.dart';
import 'package:stackmate_wallet/pkg/mnemonic_word.dart';
import 'package:stackmate_wallet/pkg/secure_storage.dart';
import 'package:stackmate_wallet/pkg/share.dart';
import 'package:stackmate_wallet/pkg/storage.dart';
import 'package:stackmate_wallet/pkg/vibrate.dart';

GetIt locator = GetIt.instance;

void setupDependencies({required bool useDummies}) {
  if (useDummies) {
    locator.registerSingleton<WordsCubit>(
      WordsCubit(
        mnemonicWords: MnemonicWords(),
      ),
    );
    locator.registerLazySingleton<SStorage>(() => SecureStorage());
    locator.registerLazySingleton<IStorage>(() => HiveStore());
    locator.registerLazySingleton<IClipBoard>(() => ClipBoard());
    locator.registerLazySingleton<IShare>(() => Sharer());
    locator.registerSingleton<ILauncher>(Launcher());
    locator.registerLazySingleton<IVibrate>(() => Vibrate());
    locator.registerLazySingleton<IStackMateBitcoin>(() => LibBitcoin());
    locator.registerLazySingleton<ILogAPI>(() => DummyLogAPI());
    locator.registerLazySingleton<ICPSocket>(() => CypherpostStream());
  } else {
    locator.registerSingleton<WordsCubit>(
      WordsCubit(
        mnemonicWords: MnemonicWords(),
      ),
    );
    locator.registerLazySingleton<SStorage>(() => SecureStorage());
    locator.registerLazySingleton<IShare>(() => Sharer());
    locator.registerLazySingleton<ILauncher>(() => Launcher());
    locator.registerLazySingleton<IClipBoard>(() => ClipBoard());
    locator.registerLazySingleton<IStorage>(() => HiveStore());
    locator.registerLazySingleton<IStackMateBitcoin>(() => LibBitcoin());
    locator.registerLazySingleton<IVibrate>(() => Vibrate());
    locator.registerLazySingleton<ILogAPI>(() => SentryLogger());
    locator.registerLazySingleton<ICPSocket>(() => CypherpostStream());
  }

  final loggerCubit = Logger(
    locator<IClipBoard>(),
    locator<ILogAPI>(),
  );

  locator.registerLazySingleton<Logger>(() => loggerCubit);
}
