import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.isPassword = false,
  });
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextEditingController controller ;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool isObscure = widget.isPassword? true : false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:widget.controller ,
      validator: widget.validator,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword == true
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )
            : null,

        hintStyle: AppStyle.hintStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppFontSize.f8),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppFontSize.f8),
          borderSide: BorderSide(color: AppColors.grey),
        ),
      ),
    );
  }
}
