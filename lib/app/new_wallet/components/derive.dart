import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/new_wallet/components/derive/label.dart';
import 'package:stackmate_wallet/app/new_wallet/components/derive/passphrase.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/derive_wallet_cubit.dart';
// import 'package:stackmate_wallet/cubit/wallets.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

class DeriveSteps extends StatelessWidget {
  const DeriveSteps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final step = context.select((DeriveWalletCubit sc) => sc.state.currentStep);
    switch (step) {
      case DeriveWalletStep.purpose:
        return const DerivePurpose();
      case DeriveWalletStep.passphrase:
        return DerivePassphrase();
      // case DeriveWalletStep.idx:
      //   return const DeriveIndex();
      case DeriveWalletStep.label:
        return const DeriveLabel();
    }
  }
}

class DerivePurpose extends StatelessWidget {
  const DerivePurpose();

  @override
  Widget build(BuildContext c) {
    // final wallets = c.select((WalletsCubit wc) => wc.state.wallets);

    final selectedPurpose =
        c.select((DeriveWalletCubit mdw) => mdw.state.purpose);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Choose Purpose:',
          style: c.fonts.headlineSmall!.copyWith(
            color: c.colours.onPrimary,
            // fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ListTile(
          title: Text(
            'Taproot',
            style: c.fonts.bodyMedium!.copyWith(
              color: c.colours.onPrimary,
              // fontWeight: FontWeight.bold,
            ),
          ),
          leading: Radio<DerivationPurpose>(
            activeColor: c.colours.primary,
            value: DerivationPurpose.taproot,
            groupValue: selectedPurpose,
            onChanged: (DerivationPurpose? value) {
              c
                  .read<DeriveWalletCubit>()
                  .purposeChanged(DerivationPurpose.taproot);
            },
          ),
        ),
        ListTile(
          selectedColor: c.colours.primary,
          selectedTileColor: c.colours.primary,
          title: Text(
            'Segwit',
            style: c.fonts.bodyMedium!.copyWith(
              color: c.colours.onPrimary,
              // fontWeight: FontWeight.bold,
            ),
          ),
          leading: Radio<DerivationPurpose>(
            activeColor: c.colours.primary,
            value: DerivationPurpose.segwit,
            groupValue: selectedPurpose,
            onChanged: (DerivationPurpose? value) {
              c
                  .read<DeriveWalletCubit>()
                  .purposeChanged(DerivationPurpose.segwit);
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: c.colours.background,
              backgroundColor: c.colours.primary,
            ),
            onPressed: () {
              c.read<DeriveWalletCubit>().nextClicked();
            },
            child: const Text('CONFIRM'),
          ),
        ),
      ],
    );
  }
}
