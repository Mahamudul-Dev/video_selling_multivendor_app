import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../module/buyer_dashboard/controllers/buyer_search_controller.dart';

class SearchFilterDialog extends StatelessWidget {
  const SearchFilterDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final BuyerSearchController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Result'),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: const Text('Set Price Renge'),
                titleTextStyle: Theme.of(context).textTheme.titleSmall,
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: controller.filterMinPrice,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: SECONDARY_APP_COLOR)),
                                  focusColor: SECONDARY_APP_COLOR,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: SECONDARY_APP_COLOR))),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'To',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 45,
                            child: TextField(
                              controller: controller.filterMaxPrice,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: SECONDARY_APP_COLOR)),
                                  focusColor: SECONDARY_APP_COLOR,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: SECONDARY_APP_COLOR))),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'From',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Obx(() => Checkbox(
                    value: controller.filterPriceLowToHigh.value,
                    focusColor: SECONDARY_APP_COLOR,
                    activeColor: SECONDARY_APP_COLOR,
                    onChanged: (value) {
                      controller.filterPriceLowToHigh.value = value ?? false;
                    })),
                title: Text(
                  'Price Low to High',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              ListTile(
                title: Text(
                  'Ratings',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                subtitle: RatingBar.builder(
                    unratedColor: Colors.grey,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (value) {
                      controller.filterRating.value = value;
                    }),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () => controller.clearFilter(),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red)),
            child: Text(
              'Clear',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white),
            )),
        const Spacer(),
        ElevatedButton(
            onPressed: () => controller.filterSearchList(),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(SECONDARY_APP_COLOR)),
            child: Text(
              'Filter',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white),
            ))
      ],
      contentPadding: const EdgeInsets.all(20),
    );
  }
}
