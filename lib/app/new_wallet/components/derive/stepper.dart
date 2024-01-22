import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/step_line.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/derive_wallet_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

class DeriveStepper extends StatelessWidget {
  const DeriveStepper({super.key});

  @override
  Widget build(BuildContext c) {
    final state = c.select((DeriveWalletCubit d) => d.state);

    final steps = DeriveWalletStep.values.length;
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
