import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stackmate_wallet/app/common/cubits/fees_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/master_key_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/tor_cubit.dart';
import 'package:stackmate_wallet/app/common/cubits/wallets_cubit.dart';
import 'package:stackmate_wallet/pkg/extensions.dart';
import 'package:stackmate_wallet/app/home/components/accounts.dart';
import 'package:stackmate_wallet/app/home/components/actions.dart';
import 'package:stackmate_wallet/app/home/components/backup_warning.dart';
import 'package:stackmate_wallet/app/home/components/loader.dart';
import 'package:stackmate_wallet/app/home/components/networth.dart';
import 'package:stackmate_wallet/app/home/components/tools.dart';
import 'package:stackmate_wallet/app/home/components/tor_header.dart';

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    final masterKey = c.select((MasterKeyCubit mc) => mc.state.key);
    //final networth = c.select((WalletsCubit w) => w.state.networth);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          displacement: 10.0,
          onRefresh: () async {
            // await c.read<TorCubit>().testConnection();
            await c.read<FeesCubit>().update();
            await c.read<WalletsCubit>().networth();
            return;
          },
          child: BlocBuilder<TorCubit, TorState>(
            buildWhen: (previous, current) =>
                previous.isConnected != current.isConnected,
            builder: (context, torState) {
              if (torState.isConnected) c.read<WalletsCubit>().networth();

              return CustomScrollView(
                slivers: [
                  if (masterKey != null)
                    SliverAppBar(
                      stretch: true,
                      pinned: true,
                      collapsedHeight: 256,
                      expandedHeight: 256,
                      automaticallyImplyLeading: false,
                      backgroundColor: c.colours.background,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const [
                          StretchMode.fadeTitle,
                        ],
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const HomeLoader(),
                            TorHeader(),
                            const SizedBox(
                              height: 8,
                            ),
                            Networth(),
                            WalletTools(),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverAppBar(
                      stretch: true,
                      pinned: true,
                      expandedHeight: c.height / 3,
                      automaticallyImplyLeading: false,
                      backgroundColor: c.colours.background,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const [
                          StretchMode.fadeTitle,
                        ],
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HomeLoader(),
                            TorHeader(),
                            WalletTools(),
                          ],
                        ),
                      ),
                    ),
                  if (masterKey != null)
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              bottom: 12,
                              left: 12,
                              right: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [BackupWarning(), Accounts()],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              // bottom: 12,
                              left: 12,
                              right: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 24,
                                  ),
                                  child: Text(
                                    'Click on + icon to Create wallet',
                                    style: c.fonts.bodySmall!.copyWith(
                                      color: c.colours.onBackground,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ).animate(delay: 200.ms).fadeIn();
            },
          ),
        ),
      ),
      bottomNavigationBar: HomeActions(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Home();
  }
}