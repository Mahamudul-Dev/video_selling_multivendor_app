import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:video_selling_multivendor_app/themes/app_colors.dart';

import '../../../../data/utils/asset_maneger.dart';
import '../controllers/wallet_history_controller.dart';

class WalletHistoryView extends GetView<WalletHistoryController> {
  WalletHistoryView({Key? key}) : super(key: key);
  final String type = Get.arguments['type'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DARK_ASH,
        appBar: AppBar(
          title: Text(
              type == 'transfer' ? 'Transfer History' : 'Transaction History'),
          centerTitle: true,
        ),
        body: type == 'transfer'
            ? _buildTransferHistory(context)
            : _buildTransactionHistory(context));
  }

  Widget _buildTransferHistory(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
            leading: const CircleAvatar(
              backgroundColor: DARK_ASH,
              backgroundImage: CachedNetworkImageProvider(DEMO_PROFILE_PHOTO),
            ),
            title: Text(
              'Alezabeth Midina',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(DateTime.now()),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade300),
            ),
            trailing: Expanded(
                child: Text(
              '-\$120',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.red),
            )));
      },
      itemCount: 1,
    );
  }

  Widget _buildTransactionHistory(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
            leading: CircleAvatar(
              backgroundColor: TEAL,
              child: Center(
                child: SvgPicture.asset(
                  WALLET_TOPUP_ICON,
                  semanticsLabel: 'Topup',
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            title: Text(
              'Topup',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(DateTime.now()),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade300),
            ),
            trailing: Expanded(
                child: Text(
              '+\$120',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.green),
            )));
      },
      itemCount: 1,
    );
  }
}
