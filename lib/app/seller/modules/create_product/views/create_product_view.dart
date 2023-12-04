import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
import '../controllers/create_product_controller.dart';

class CreateProductView extends GetView<CreateProductController> {
  const CreateProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DARK_ASH,
        appBar: AppBar(
          title: const Text('Publish Studio'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // trailer upload card
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: SECONDARY_APP_COLOR,
                      margin: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(LIGHT_ASH)),
                                icon: const Icon(
                                  Icons.upload,
                                  color: Colors.white70,
                                )),
                            Text(
                              'Upload your trailer \n(max: 2 min)',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white70),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // main content upload card
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: SECONDARY_APP_COLOR,
                      margin: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(LIGHT_ASH)),
                                icon: const Icon(
                                  Icons.upload,
                                  color: Colors.white70,
                                )),
                            Text(
                              'Upload your main content \n(max: 500 mb)',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white70),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
