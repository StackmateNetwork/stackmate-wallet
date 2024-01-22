import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/loading.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/xpub_import_wallet_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';


class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext c) {
    final loading = c.select((XpubImportWalletCubit h) => h.state.savingWallet);

    if (!loading) return Container();

    return const Loading(text: 'Importing watcher wallet...');
  }
}
