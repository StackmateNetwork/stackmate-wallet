import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackmate_wallet/app/landing/cubits/pin_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';

class PinValue extends StatelessWidget {
  const PinValue({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCubit, PinState>(
      buildWhen: (previous, current) =>
          previous.setValue != current.setValue ||
          previous.enteredValue != current.enteredValue ||
          previous.hiddenValue != current.hiddenValue ||
          previous.confirmedValue != current.confirmedValue,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.hiddenValue,
              style: context.fonts.displaySmall!.copyWith(
                color: context.colours.onPrimary,
              ),
            ),
          ],
        );
      },
    );
  }
}
