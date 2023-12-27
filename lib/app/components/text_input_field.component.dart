import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.required,
    this.controller
  }) : super(key: key);

  final String label;
  final String hint;
  final bool required;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label, style: Theme.of(context).textTheme.bodyMedium,),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium
      ),
    );
  }
}
