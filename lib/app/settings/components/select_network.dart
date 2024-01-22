import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/common/components/success_handler.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';
import 'package:stackmate_wallet/app/common/cubits/chain_select_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/node_address_cubit.dart';
import 'package:stackmate_wallet/app/common/models/blockchain_model.dart';

class SelectNetwork extends StatelessWidget {
  const SelectNetwork({super.key});

  @override
  Widget build(BuildContext c) {
    final blockchain = c.select((ChainSelectCubit b) => b.state.blockchain);
    final nodeState = c.select((NodeAddressCubit nac) => nac.state);
    return ElevatedButton(
      onPressed: () {
        if (blockchain == Blockchain.main) {
          c.read<ChainSelectCubit>().changeBlockchain(Blockchain.test);
          handleHelp(c, 'Modify full node uri or click on reset to default');
          if (nodeState.name == 'Blockstream') {
            c.read<NodeAddressCubit>().revertToDefault();
          }
        } else {
          c.read<ChainSelectCubit>().changeBlockchain(Blockchain.main);
          handleHelp(c, 'Modify full node uri or click on reset to default');
          if (nodeState.name == 'Blockstream') {
            c.read<NodeAddressCubit>().revertToDefault();
          }
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: c.colours.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      child: Container(
        height: 80,
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Network'.toUpperCase(),
                  style: c.fonts.labelLarge!.copyWith(
                    color: c.colours.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  blockchain.displayName,
                  maxLines: 3,
                  style: c.fonts.bodySmall!.copyWith(
                    color: c.colours.primary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.public_rounded,
              size: 24,
              color: c.colours.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
