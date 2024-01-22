import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/step_line.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/seed_generate_wallet_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

class GenerateWalletStepper extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedGenerateWalletCubit, SeedGenerateWalletState>(
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      builder: (context, state) {
        final steps = SeedGenerateWalletSteps.values.length;
        final idx = state.currentStep.index;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StepLine(length: steps, idx: idx),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}
