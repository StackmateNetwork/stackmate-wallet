import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/step_line.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/seed_import_wallet_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

class NewImportStepper extends StatelessWidget {
  const NewImportStepper();
  @override
  Widget build(BuildContext c) {
    return BlocBuilder<SeedImportWalletCubit, SeedImportWalletState>(
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      builder: (context, state) {
        final steps = SeedImportWalletSteps.values.length;
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
