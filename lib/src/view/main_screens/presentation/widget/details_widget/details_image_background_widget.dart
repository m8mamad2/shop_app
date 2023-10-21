import 'package:flutter/material.dart';
import 'package:project3/src/config/localization/is_english.dart';

import '../../../../../core/common/constans/size.dart';
import '../../../../../core/widget/cached_image.dart';
import '../../../domain/entities/products_entity.dart';
import 'details_colorfull_widget.dart';
import 'detials_colorless_widget.dart';

class DetialsImageAndBackgroudWidget extends StatelessWidget {
  const DetialsImageAndBackgroudWidget({
    super.key,
    required this.data,
    required this.dataColor,
  });

  final ProductsEntity data;
  final Color dataColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeH(context) / 2,
      child: Stack(children: [
        Row(
          children: [
            DetailsColorLessWidget(context, data, dataColor),
            DetailsColorFullWidget(dataColor: dataColor, data: data, context: context)
          ],
        ),
        //! image
        Align(
          alignment:isEnglish(context) ? Alignment.bottomRight : Alignment.bottomLeft,
          child: cachedImageWidget(context, data.image!, sizeW(context) * 0.61,sizeH(context) * 0.297),
        )
      ]),
    );
  }
}
