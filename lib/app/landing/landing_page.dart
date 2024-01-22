import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stackmate_wallet/app/common/components/error_handler.dart';
import 'package:stackmate_wallet/app/common/cubits/master_key_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/tor_cubit.dart';
import 'package:stackmate_wallet/app/landing/cubits/pin_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';
import 'package:stackmate_wallet/app/landing/components/keypad.dart';
import 'package:stackmate_wallet/app/landing/components/logo.dart';
import 'package:stackmate_wallet/app/landing/components/pin_button.dart';
import 'package:stackmate_wallet/app/landing/components/pin_prompt.dart';
import 'package:stackmate_wallet/app/landing/components/pin_value.dart';

class _Landing extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final masterKey = c.select((MasterKeyCubit mc) => mc.state.key);

    return BlocListener<PinCubit, PinState>(
      listener: (context, state) => {
        if (state.isVerified)
          {
            if (masterKey != null)
              {
                c.read<TorCubit>().start(),
                c.push('/home'),
              }
            else
              {
                c.read<TorCubit>().start(),
                c.push('/add-wallet'),
              },
          }
        else if (state.error != null)
          {
            handleError(
              context,
              state.error!,
            ),
          },
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: c.height / 1.2,
                automaticallyImplyLeading: false,
                backgroundColor: c.colours.background,
                flexibleSpace: const FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 36),
                      LandingLogo(),
                      SizedBox(height: 12),
                      PinPrompt(),
                      SizedBox(height: 12),
                      PinValue(),
                      SizedBox(height: 55),
                      PinKeypad(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const PinButton(),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Landing();
  }
}
