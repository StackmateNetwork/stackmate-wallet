import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/loading.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/derive_wallet_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

class DeriveLoader extends StatelessWidget {
  const DeriveLoader({
    super.key,
  });

  @override
  Widget build(BuildContext c) {
    final deriving = c.select((DeriveWalletCubit mc) => mc.state.savingWallet);

    if (!deriving) return Container();
    return const Loading(text: 'Deriving wallet...');
  }
}
