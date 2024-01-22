import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stackmate_wallet/api/interface/libbitcoin.dart';
import 'package:stackmate_wallet/app/common/cubits/chain_select_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/logger_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/master_key_cubit.dart';
import 'package:stackmate_wallet/app/new_wallet/components/seed_import.dart';
import 'package:stackmate_wallet/app/new_wallet/components/seed_import/label.dart';
import 'package:stackmate_wallet/app/new_wallet/components/seed_import/loader.dart';
import 'package:stackmate_wallet/app/new_wallet/components/seed_import/stepper.dart';
import 'package:stackmate_wallet/app/new_wallet/components/seed_import/warning.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/common/seed_import_cubit.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/seed_import_wallet_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/node_address_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/tor_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/wallets_cubit.dart';
import 'package:stackmate_wallet/pkg/_locator.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';
import 'package:stackmate_wallet/pkg/interface/storage.dart';


class _SeedImport extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final tor = c.select((TorCubit t) => t.state);
    return BlocConsumer<SeedImportWalletCubit, SeedImportWalletState>(
      listenWhen: (previous, current) =>
          previous.currentStep != current.currentStep ||
          previous.newWalletSaved != current.newWalletSaved,
      listener: (context, state) {
        if (state.newWalletSaved) {
          context.pop();
          context.push('/home');
        }
      },
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      builder: (context, state) {
        return PopScope(
          onPopInvoked: (_) async {
            if (!state.canGoBack()) {
              c.read<SeedImportWalletCubit>().backClicked();
              return;
            }
            return;
          },
          child: Scaffold(
            appBar: AppBar(
              actions: [
                if (tor.isConnected) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Tooltip(
                      preferBelow: false,
                      triggerMode: TooltipTriggerMode.tap,
                      message: (tor.isRunning)
                          ? 'Torified Natively.'
                          : 'Torified via External.',
                      textStyle: c.fonts.bodySmall!.copyWith(
                        color: c.colours.primary,
                      ),
                      decoration: BoxDecoration(
                        color: c.colours.surface,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Icon(
                        Icons.security_sharp,
                        color: c.colours.tertiaryContainer,
                      ),
                    ),
                  ),
                ] else ...[
                  IconButton(
                    color: c.colours.error,
                    onPressed: () {
                      c.push('/tor-config');
                    },
                    icon: Icon(
                      Icons.security_sharp,
                      color: c.colours.error,
                    ),
                  ),
                ],
              ],
              title: const Text('Import wallet'),
              leading: Builder(
                builder: (BuildContext context) {
                  return BackButton(
                    onPressed: () {
                      if (!state.canGoBack()) {
                        c.read<SeedImportWalletCubit>().backClicked();
                        return;
                      }
                      context.pop();
                    },
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Loader(),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: NewImportStepper(),
                  ),
                  FadeInLeft(
                    key: Key(state.currentStepLabel()),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      // padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: c.colours.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: () {
                        switch (state.currentStep) {
                          case SeedImportWalletSteps.warning:
                            return const SeedImportWarning();

                          case SeedImportWalletSteps.import:
                            return const SeedImportSteps();

                          case SeedImportWalletSteps.label:
                            return const SeedImportLabel();
                        }
                      }(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SeedImportPage extends StatelessWidget {
  const SeedImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = context.select((Logger c) => c);
    final wallets = context.select((WalletsCubit c) => c);
    final networkSelect = context.select((ChainSelectCubit c) => c);
    final nodeSelect = context.select((NodeAddressCubit c) => c);
    final tor = context.select((TorCubit c) => c);
    final masterKey = context.select((MasterKeyCubit c) => c);
    final importCubit = SeedImportCubit(
      logger,
      masterKey,
      networkSelect,
      locator<IStackMateBitcoin>(),
    );

    final seedImportCubit = SeedImportWalletCubit(
      locator<IStackMateBitcoin>(),
      logger,
      locator<IStorage>(),
      wallets,
      networkSelect,
      nodeSelect,
      tor,
      importCubit,
      masterKey,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: importCubit),
        BlocProvider.value(value: seedImportCubit),
      ],
      child: _SeedImport(),
    );
  }
}
