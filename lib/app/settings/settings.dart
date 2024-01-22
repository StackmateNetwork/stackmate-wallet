import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

import 'package:stackmate_wallet/app/common/cubits/master_key_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/wallets_cubit.dart';
import 'package:stackmate_wallet/app/settings/components/bitcoin_unit.dart';
import 'package:stackmate_wallet/app/settings/components/incognito.dart';
import 'package:stackmate_wallet/app/settings/components/select_network.dart';
import 'package:stackmate_wallet/app/settings/components/select_node.dart';
import 'package:stackmate_wallet/app/settings/components/tor.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings').animate(delay: 200.ms).fadeIn().slideX(),
        leading: Builder(
          builder: (BuildContext context) {
            return BackButton(
              onPressed: () {
                context.pop();
              },
            ).animate(delay: 200.ms).fadeIn().slideX();
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 24,
              ),
              const SelectNode(),
              const SizedBox(height: 8),
              const SelectNetwork(),
              const SizedBox(height: 8),
              const SetBitcoinUnit(),
              const SizedBox(height: 8),
              const SetIncognito(),
              const SizedBox(height: 8),
              const TorSettings(),
              const SizedBox(height: 18),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: c.colours.background,
                    backgroundColor: c.colours.primary,
                  ),
                  onPressed: () {
                    c.read<MasterKeyCubit>().init();
                    c.read<WalletsCubit>().refresh();
                    Navigator.of(c).pop();
                  },
                  child: const Text('SAVE'),
                ),
              ),
            ],
          ),
        ).animate(delay: 200.ms).fadeIn(),
      ),
    );
  }
}
