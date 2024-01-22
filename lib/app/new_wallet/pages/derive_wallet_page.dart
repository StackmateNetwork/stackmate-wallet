import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stackmate_wallet/api/interface/libbitcoin.dart';
import 'package:stackmate_wallet/app/common/cubits/chain_select_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/logger_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/master_key_cubit.dart';
import 'package:stackmate_wallet/app/new_wallet/components/derive.dart';
import 'package:stackmate_wallet/app/new_wallet/components/derive/label.dart';
import 'package:stackmate_wallet/app/new_wallet/components/derive/loader.dart';
import 'package:stackmate_wallet/app/new_wallet/components/derive/passphrase.dart';
import 'package:stackmate_wallet/app/new_wallet/components/derive/stepper.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/derive_wallet_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/node_address_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/tor_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/wallets_cubit.dart';
import 'package:stackmate_wallet/pkg/_locator.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';
import 'package:stackmate_wallet/pkg/interface/storage.dart';

class _Derive extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final tor = c.select((TorCubit t) => t.state);
    return BlocConsumer<DeriveWalletCubit, DeriveWalletState>(
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
              title: const Text('Derive wallet'),
              leading: Builder(
                builder: (BuildContext context) {
                  return BackButton(
                    onPressed: () {
                      context.pop();
                    },
                  );
                },
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const DeriveLoader(),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: DeriveStepper(),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: c.colours.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: () {
                        switch (state.currentStep) {
                          case DeriveWalletStep.purpose:
                            return const DeriveSteps();
                          case DeriveWalletStep.passphrase:
                            return DerivePassphrase();
                          case DeriveWalletStep.label:
                            return const DeriveLabel();
                        }
                      }(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DeriveWalletPage extends StatelessWidget {
  const DeriveWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final networkSelect = context.select((ChainSelectCubit c) => c);
    final nodeSelect = context.select((NodeAddressCubit c) => c);
    final tor = context.select((TorCubit c) => c);

    final logger = context.select((Logger c) => c);
    final wallets = context.select((WalletsCubit c) => c);
    final masterKey = context.select((MasterKeyCubit c) => c);

    final deriveMasterCubit = DeriveWalletCubit(
      locator<IStackMateBitcoin>(),
      logger,
      locator<IStorage>(),
      wallets,
      networkSelect,
      nodeSelect,
      tor,
      masterKey,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: deriveMasterCubit),
      ],
      child: _Derive(),
    );
  }
}