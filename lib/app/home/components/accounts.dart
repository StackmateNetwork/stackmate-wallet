import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/cubits/chain_select_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/logger_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/node_address_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/tor_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/wallet/wallet_info_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/wallets_cubit.dart';
import 'package:stackmate_wallet/pkg/_locator.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';
import 'package:stackmate_wallet/pkg/interface/launcher.dart';
import 'package:stackmate_wallet/pkg/interface/share.dart';
import 'package:stackmate_wallet/pkg/interface/storage.dart';
import 'package:stackmate_wallet/pkg/interface/vibrate.dart';
import 'package:stackmate_wallet/app/home/components/wallet_card.dart';

class Accounts extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final wallets = c.select((WalletsCubit w) => w.state.wallets);

    if (wallets.isEmpty)
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Text(
              'No\nwallets\nadded',
              style: c.fonts.bodySmall!.copyWith(
                color: c.colours.onBackground,
              ),
            ),
          ),
        ],
      );
    else
      return Container(
        width: c.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (final w in wallets) ...[
                const SizedBox(height: 5),
                BlocProvider.value(
                  value: InfoCubit(
                    c.read<WalletsCubit>(),
                    locator<IStorage>(),
                    c.read<Logger>(),
                    locator<ILauncher>(),
                    locator<IShare>(),
                    locator<IVibrate>(),
                    c.read<NodeAddressCubit>(),
                    c.read<TorCubit>(),
                    c.read<ChainSelectCubit>(),
                    w,
                  ),
                  child: WalletCard(wallet: w),
                ),
                const SizedBox(height: 5),
              ],
            ],
          ),
        ),
      );
  }
}
