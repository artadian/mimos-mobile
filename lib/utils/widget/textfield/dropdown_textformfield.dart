import 'package:flutter/material.dart';

class DropdownTextFormField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final String labelText;
  final Function onTap;
  final Function validator;
  final String valueId;
  final Function onSaved;

  DropdownTextFormField({
    this.enabled = true,
    this.controller,
    this.labelText,
    this.onTap,
    this.validator,
    this.valueId,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: true,
      controller: controller,
      onSaved: onSaved,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: labelText ?? "", suffixIcon: Icon(Icons.arrow_drop_down)),
      validator: validator,
      onTap: onTap,
    );
  }
}
