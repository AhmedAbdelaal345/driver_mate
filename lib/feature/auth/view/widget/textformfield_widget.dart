import 'package:driver_mate/core/utils/app_constants.dart';
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
  bool isObscure = false;
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
                  color: AppConstants.grey,
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
          borderRadius: BorderRadius.circular(AppConstants.f8),
          borderSide: BorderSide(color: AppConstants.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.f8),
          borderSide: BorderSide(color: AppConstants.grey),
        ),
      ),
    );
  }
}
