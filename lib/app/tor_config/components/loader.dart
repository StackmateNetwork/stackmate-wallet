import 'package:flutter/material.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';
import 'package:stackmate_wallet/app/common/components/loading.dart';
import 'package:stackmate_wallet/app/common/cubits/tor_cubit.dart';

class TorLoader extends StatelessWidget {
  const TorLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final tor = context.select((TorCubit hc) => hc.state);
    // final fees = context.select((FeesCubit hc) => hc.state);

    if (tor.isConnected) return Container();
    if (tor.isRunning)
      return Loading(
        text: tor.bootstapProgress,
      );
    else
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          tor.errConnection,
          style: context.fonts.bodySmall!.copyWith(
            color: context.colours.error,
          ),
          textAlign: TextAlign.center,
        ),
      );
    // else
    //   return Padding(
    //     padding: const EdgeInsets.only(top: 5),
    //     child: Text(
    //       tor.errConnection,
    //       style: context.fonts.caption!.copyWith(
    //         color: context.colours.error,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),
    //   );
  }
}