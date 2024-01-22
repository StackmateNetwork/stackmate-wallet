import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/loading.dart';
import 'package:stackmate_wallet/app/common/cubits/master_key_cubit.dart';
import 'package:stackmate_wallet/app/new_wallet/cubits/seed_import_wallet_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';


class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext c) {
    final loading = c.select((SeedImportWalletCubit h) => h.state.savingWallet);
    final mks = c.select((MasterKeyCubit mk) => mk.state);

    final text =
        (mks.key == null) ? 'Importing wallet...' : 'Recovering wallet...';
    if (!loading) return Container();

    return Loading(text: text);
  }
}
