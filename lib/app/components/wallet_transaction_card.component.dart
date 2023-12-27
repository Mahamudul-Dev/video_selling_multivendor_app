import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../data/utils/asset_maneger.dart';
import '../data/utils/enums.dart';

class WalletTransactionCard extends StatelessWidget {
  const WalletTransactionCard({
    Key? key,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.amount,
    required this.type,
  }) : super(key: key);

  final String title;
  final String content;
  final DateTime timestamp;
  final double amount;
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: type == TransactionType.TOPUP ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.errorContainer,
      margin: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 200,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(timestamp),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: type == TransactionType.TOPUP ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: SvgPicture.asset(
                  type == TransactionType.TOPUP
                      ? WALLET_TOPUP_ICON
                      : WALLET_WITHDRAW_ICON,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
                child: Text(
              '\$$amount',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
            )),
            Expanded(
                child: Text(
              content,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
            ))
          ],
        ),
      ),
    );
  }
}
