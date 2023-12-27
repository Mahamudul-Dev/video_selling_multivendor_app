import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/components/text_input_field.component.dart';

class UsernameChangeSheet extends StatelessWidget {
  const UsernameChangeSheet(
      {Key? key,
      this.onCheck,
      this.onUpdate,
      required this.controller,
      required this.updateButtonEnabled})
      : super(key: key);

  final void Function()? onCheck;
  final void Function()? onUpdate;
  final RxBool updateButtonEnabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.onSurface),
                )
              ],
            ),
            TextInputField(
                controller: controller,
                label: 'Username',
                hint: 'Type your username',
                required: true),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: onCheck,
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(!updateButtonEnabled.value ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceVariant)),
                    child: Text(
                      'Check',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: !updateButtonEnabled.value ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant),
                    )),
                Obx(() => ElevatedButton(
                    onPressed: onUpdate,
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(updateButtonEnabled.value ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceVariant)),
                    child: Text(
                      'Change',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: updateButtonEnabled.value ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant),
                    ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
