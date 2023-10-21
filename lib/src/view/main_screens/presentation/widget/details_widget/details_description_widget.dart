// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/config/theme/theme.dart';

import '../../../../../config/localization/is_english.dart';
import '../../../../../core/common/constans/size.dart';
import '../../../domain/entities/products_entity.dart';

Padding DetailsDescriptionWidget(BuildContext context, ProductsEntity data) {
  return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 8),
            child: Text('About'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: 17,fontWeight: FontWeight.bold)),
          ),
          SizedBox(
              width: sizeW(context) * 0.9,
              height: sizeH(context) * 0.14,
              child: SingleChildScrollView(
                  child: Text( '${isEnglish(context) ? data.description : data.IRdescription}',style: theme(context).textTheme.titleSmall!.copyWith(
                    color: theme(context).focusColor.withOpacity(0.6)
                  ),))),
          sizeBoxH(sizeH(context) * 0.005),
        ],
      ));
}
