import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/cubits/preferences_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/wallet/info.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';


class Balance extends StatelessWidget {
  const Balance({
    super.key,
  });

  @override
  Widget build(BuildContext c) {
    final balance = c.select((InfoCubit hc) => hc.state.balance);
    final preferences = c.select((PreferencesCubit pc) => pc.state);
    final wallet = c.select((InfoCubit w) => w.state.wallet);

    return FadeIn(
      child: Padding(
        padding: const EdgeInsets.only(top: 52),
        child: Column(
          children: [
            if (preferences.incognito) ...[
              Text(
                wallet!.label,
                style: c.fonts.headlineMedium!.copyWith(
                  color: c.colours.onPrimary,
                ),
              ),
            ] else ...[
              GestureDetector(
                onTap: () {
                  c.read<PreferencesCubit>().preferredBitcoinUnitChanged();
                },
                child: BitcoinDisplayLarge(
                  satsAmount: balance.toString(),
                  bitcoinUnit: preferences.preferredBitcoinUnit,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
