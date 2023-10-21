import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project3/src/config/theme/theme.dart';

import '../../../../core/common/constans/size.dart';

Padding authTextFormWidget(
    BuildContext context,
    TextEditingController controller,
    String lableText,
    IconData? unVisibleIcon,
    IconData? visibleIcon,
    bool isVisible,
    bool isPassField,
    void Function()? onPress,
    // String? Function(String?) validate
    ) {
  OutlineInputBorder border  =OutlineInputBorder( borderRadius: BorderRadius.circular(10), borderSide:BorderSide(color: Colors.grey.shade400, width: 0.4));
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: SizedBox(
      width: sizeW(context) * 0.89,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if(!isPassField) {
                if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)){return null;}
                else {return 'Please Enter Valid Email'.tr();}}
          // if(isPassField){
          //   if(value!.length < 8){ return 'Password must be more than 8 characters'.tr();}
          //   else { return null; }
          // }
        },
        style: theme(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
        obscureText: isPassField ? isVisible : false,
        decoration: InputDecoration(
            errorStyle: theme(context).textTheme.titleSmall!.copyWith(fontSize: sizeW(context)*0.025,color: theme(context).primaryColor),
            contentPadding: EdgeInsets.symmetric(horizontal: sizeH(context) * 0.02,vertical: sizeH(context) * 0.022),
            labelText: lableText,
            labelStyle:theme(context).textTheme.bodyMedium!.copyWith(fontSize: sizeW(context)*0.03, color: Colors.grey),
            suffixIcon: IconButton(
                onPressed: onPress,
                icon: Icon(
                  isVisible == true ? visibleIcon : unVisibleIcon,
                  color: Theme.of(context).primaryColor,
                )),
            border: InputBorder.none,
            errorBorder: border,
            focusedErrorBorder: border,
            focusedBorder: border,
            enabledBorder: border),

      ),
    ),
  );
}
