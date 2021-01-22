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
  final Widget prefix;
  final Widget prefixIcon;
  final bool enabled;
  final Function onChanged;

  TextInputField({
    this.controller,
    this.keyboardType,
    this.validator,
    this.dataSaved,
    this.onSaved,
    this.inputFormatters,
    this.textInputAction,
    this.onFieldSubmitted,
    this.labelText,
    this.suffixText,
    this.suffixStyle,
    this.prefixText,
    this.prefixStyle,
    this.emptyValidator = false,
    this.readOnly = false,
    this.filled = false,
    this.onTap,
    this.prefix,
    this.prefixIcon,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      enabled: enabled,
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
          prefix: prefix,
          prefixIcon: prefixIcon,
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
                  if (val.length < 1)
                    return 'Filed is required';
                  else
                    return null;
                }
              : (String val) {
                  return null;
                },
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
