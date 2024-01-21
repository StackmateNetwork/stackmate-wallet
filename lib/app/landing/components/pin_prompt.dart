import 'package:flutter/material.dart';
import 'package:stackmate_wallet/app/landing/cubits/pin_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

class PinPrompt extends StatelessWidget {
  const PinPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCubit, PinState>(
      buildWhen: (previous, current) =>
          previous.hasChosenPin != current.hasChosenPin,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (state.hasChosenPin) ? 'ENTER PIN' : 'SET PIN',
              style: context.fonts.bodyMedium!.copyWith(
                color: context.colours.tertiary,
              ),
            ),
          ],
        );
      },
    );
  }
}