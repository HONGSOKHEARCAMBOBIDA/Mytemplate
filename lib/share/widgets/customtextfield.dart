import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
   final ValueChanged<String>? onSubmitted; 
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    this.readOnly = false,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyles.siemreap(context, fontSize: 11),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.get('text', context),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
      ),
      style: TextStyles.siemreap(context, fontSize: 12),
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'សូមបំពេញ';
            }
            return null;
          },
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}
