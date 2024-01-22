import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/step_line.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/xpub_import_wallet_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

class XPubImportStepper extends StatelessWidget {
  const XPubImportStepper({super.key});

  @override
  Widget build(BuildContext c) {
    final state = c.select((XpubImportWalletCubit x) => x.state);

    final steps = XpubImportWalletStep.values.length;
    final idx = state.currentStep.index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StepLine(length: steps, idx: idx),
        const SizedBox(height: 24),
      ],
    );
  }
}
