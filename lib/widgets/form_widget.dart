 import 'package:flutter/material.dart';
import 'package:shope_ease/theme/theme.dart';

class FormFieldWidget extends StatelessWidget {
  final bool passwordObscure;
  final String? hintText;
  final bool isIconVisible;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final void Function(String?)? onSave;
  final void Function()? onTap;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Color? iconColor;
  final Widget child;
  final int? maxLine;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool? enabled;
  final TextStyle? hintStyle;
  final String? prefixText;
  final InputBorder errorBorder;
  final double? prefixSpacing;

  const FormFieldWidget(
      {super.key,
      required this.passwordObscure,
      this.hintText,
      required this.isIconVisible,
      this.validator,
      this.onChange,
      this.onSave,
      required this.focusedBorder,
      required this.enabledBorder,
      required this.labelStyle,
      required this.contentPadding,
      this.iconColor = Colors.transparent,
      required this.child,
      this.maxLine = 1,
      this.initialValue,
      this.keyboardType,
      this.controller,
      this.onTap,
      this.prefixIcon,
      this.maxLength,
      this.hintStyle,
      this.enabled,
      required this.errorBorder,
      this.prefixText,
      this.prefixSpacing = 0.0});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        child: TextFormField(
          enabled: enabled,
          maxLength: maxLength,
          controller: controller,
          initialValue: initialValue,
          maxLines: maxLine,
          style: Theme.of(context).inputDecorationTheme.hintStyle,
          obscureText: passwordObscure,
          decoration: InputDecoration(
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            disabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: secondaryColor, width: 1),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            hintText: hintText,
            hintStyle: hintStyle,
            labelStyle: labelStyle,
            contentPadding: contentPadding,
            prefix: SizedBox(
              width: prefixSpacing,
            ),

            prefixIcon: prefixIcon,
            prefixText: prefixText,
            prefixStyle: const TextStyle(color: Colors.black),
            suffixIcon: Visibility(visible: isIconVisible, child: child),
          ),
          validator: validator,
          onChanged: onChange,
          onSaved: onSave,
          keyboardType: keyboardType,
          onTap: onTap,
        ));
  }
}
