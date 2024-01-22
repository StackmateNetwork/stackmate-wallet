import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/wallet/tx_item.dart';
import 'package:stackmate_wallet/app/common/cubits/wallet/wallet_info_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';


class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final transactions = c.select((InfoCubit w) => w.state.transactions);
    if (transactions.isEmpty)
      return Padding(
        padding: const EdgeInsets.only(left: 32, top: 32, bottom: 24),
        child: Text(
          'No transactions',
          style: c.fonts.labelSmall!.copyWith(
            color: c.colours.onBackground,
          ),
        ),
      );

    return FadeIn(
      delay: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 32, bottom: 24),
            child: Text(
              'HISTORY',
              style: c.fonts.labelSmall!.copyWith(
                color: c.colours.onBackground,
              ),
            ),
          ),
          for (final transaction in transactions)
            TransactionItem(transaction: transaction),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}