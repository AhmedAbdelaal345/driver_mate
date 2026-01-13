import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class CheckTextfieldWidget extends StatelessWidget {
  const CheckTextfieldWidget({super.key,required this.validator});
final String ?Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.068 * SizeConfig.width(context),
      height: 013 * SizeConfig.height(context),
      child: TextFormField(
        validator:validator ,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.f8),
            borderSide: BorderSide(color: AppConstants.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.f8),
            borderSide: BorderSide(color: AppConstants.grey),
          ),
        ),
      ),
    );
    ;
  }
}
