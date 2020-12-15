import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mimos/helper/tf_currency_formatter.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function validator;
  final Function onSaved;
  dynamic dataSaved;
  final List inputFormatters;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;
  final String labelText;
  final String suffixText;
  final TextStyle suffixStyle;
  final String prefixText;
  final TextStyle prefixStyle;
  final bool emptyValidator;
  final bool readOnly;
  final bool filled;
  final Function onTap;

  TextInputField({
    this.controller,
    this.keyboardType,
    this.validator,
    this.dataSaved,
    this.onSaved,
    this.inputFormatters = null,
    this.textInputAction,
    this.onFieldSubmitted,
    this.labelText,
    this.suffixText,
    this.suffixStyle,
    this.prefixText,
    this.prefixStyle,
    this.emptyValidator = true,
    this.readOnly = false,
    this.filled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      onSaved: onSaved,
      textInputAction: textInputAction ?? TextInputAction.next,
      onFieldSubmitted:
          onFieldSubmitted ?? (_) => FocusScope.of(context).nextFocus(),
      inputFormatters: keyboardType == TextInputType.number
          ? [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              TextFieldCurrencyFormatter()
            ]
          : inputFormatters,
      decoration: InputDecoration(
          filled: filled,
          labelText: labelText,
          prefixText: prefixText,
          prefixStyle: prefixStyle ?? TextStyle(color: Colors.black),
          suffixText: suffixText,
          suffixStyle: suffixStyle ??
              TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      validator: validator != null
          ? validator
          : emptyValidator
              ? (val) {
                  if (val.length < 1 || val.toString() == "0")
                    return 'Filed is required';
                  else
                    return null;
                }
              : null,
      onTap: onTap,
    );
  }
}
