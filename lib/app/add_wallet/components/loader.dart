// import 'package:flutter/material.dart';
// import 'package:sats/cubit/new-wallet/from-old-seed.dart';
// import 'package:stackmate_wallet/pkg/extensions.dart';
// import 'package:stackmate_wallet/ui/component/common/loading.dart';

// class Loader extends StatelessWidget {
//   const Loader({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext c) {
//     final loading = c.select((SeedImportWalletCubit h) => h.state.savingWallet);

//     if (!loading) return Container();
//     return const Loading(text: 'Importing new wallet...');
//   }
// }