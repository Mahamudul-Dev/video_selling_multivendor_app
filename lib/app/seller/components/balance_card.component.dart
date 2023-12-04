import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/app_colors.dart';
import '../../data/utils/asset_maneger.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    Key? key,
    required this.balance,
    this.onTopupTap,
    this.onWithdrawTap,
    this.onTransferTap,
  }) : super(key: key);

  final double balance;
  final void Function()? onTopupTap;
  final void Function()? onWithdrawTap;
  final void Function()? onTransferTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: DARK_ASH,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Main Balance',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.grey.shade400),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              '\$$balance',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            _buildActionButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: onTopupTap,
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                elevation: MaterialStatePropertyAll(0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  WALLET_TOPUP_ICON,
                  semanticsLabel: 'Topup',
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Topup',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                )
              ],
            )),
        ElevatedButton(
            onPressed: onWithdrawTap,
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                elevation: MaterialStatePropertyAll(0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  WALLET_WITHDRAW_ICON,
                  semanticsLabel: 'Withdraw',
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Withdraw',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                )
              ],
            )),
        ElevatedButton(
            onPressed: onTransferTap,
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                elevation: MaterialStatePropertyAll(0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  WALLET_TRANSFER_ICON,
                  semanticsLabel: 'Transfer',
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Transfer',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                )
              ],
            ))
      ],
    );
  }
}
