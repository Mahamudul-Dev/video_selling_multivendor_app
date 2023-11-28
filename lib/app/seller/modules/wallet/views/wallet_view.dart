import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/enums.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/balance_card.component.dart';
import '../../../components/wallet_transaction_card.component.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DARK_ASH,
        appBar: AppBar(
          title: const Text('Wallet'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: SECONDARY_APP_COLOR,
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: DARK_ASH,
                      backgroundImage: CachedNetworkImageProvider(DEMO_PROFILE_PHOTO),
                    ),
                    title: Text('Alezabeth Midina', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),),
                    subtitle: Text('Instructor of Photography', style: Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.grey.shade300),),
                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade300, size: 20,)),
                  ),
                  const BalanceCard(
                    balance: 1200.87,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(padding: const EdgeInsets.all(10.0), child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transfer',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white),
                ),
                TextButton(
                    onPressed: () => Get.toNamed(Routes.WALLET_HISTORY, arguments: {'type':'transfer'}),
                    child: Text(
                      'View All',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            _buildRecentTransferRow(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transaction',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white),
                ),
                TextButton(
                    onPressed: () => Get.toNamed(Routes.WALLET_HISTORY, arguments: {'type':'transaction'}),
                    child: Text(
                      'View All',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ))
              ],
            ),
            _buildRecentTransactionList(context)
            ],),)
          ],
        ));
  }

  Widget _buildRecentTransferRow(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: SECONDARY_APP_COLOR,
                  radius: 26,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                    width: 60,
                    child: Text(
                      '',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: LIGHT_ASH,
                radius: 26,
                backgroundImage: CachedNetworkImageProvider(PLACEHOLDER_PHOTO),
              ),
              SizedBox(
                  width: 60,
                  child: Text(
                    'Demo User',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          );
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 8.0,
          );
        },
      ),
    );
  }

  Widget _buildRecentTransactionList(BuildContext context) {
    return SizedBox(
      height: 202,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return WalletTransactionCard(
              title: 'Topup',
              content: 'Topup for boosting sifjwoifjow iucheuchec ecyeuycge uygruewyrgcduwyg erfhi3eufh4 ve4hc ieufhiwuhdwiuhdwiudhwiduhw xwiuxhwiuxhw iruhwiuhw dewuhdwiudhh wu wuwuxhhwiudhwiqh jfoj',
              timestamp: DateTime.now(),
              amount: 1000.89,
              type: TransactionType.TOPUP);
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 8.0,
          );
        },
      ),
    );
  }
}
