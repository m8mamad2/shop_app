import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';

import '../../../../../config/theme/theme.dart';
import '../../../../../core/common/constans/size.dart';

class DetailsPickerColorsWidget extends StatefulWidget {
  ProductsEntity data;
  DetailsPickerColorsWidget({super.key, required this.data});

  @override
  State<DetailsPickerColorsWidget> createState() =>
      _DetailsPickerColorsWidgetState();
}

class _DetailsPickerColorsWidgetState extends State<DetailsPickerColorsWidget> {
  List<bool> isChoeseColor = [];
  bool isChoeseForContinueColor = false;
  late var choeseColor;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Color'.tr(),
          style: theme(context).textTheme.titleMedium!.copyWith(fontSize: 16)),
      SizedBox(
        width: sizeW(context) * 0.44,
        height: sizeH(context) * 0.054,
        child: GridView.builder(
          itemCount: widget.data.colors!.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            isChoeseColor.add(false);

            return GestureDetector(
              onTap: () {
                setState(() {
                  isChoeseColor.replaceRange(0, isChoeseColor.length,
                      [for (int i = 0; i < isChoeseColor.length; i++) false]);
                  isChoeseColor[index] = true;
                  isChoeseForContinueColor = true;
                  choeseColor = widget.data.colors![index];
                });
              },
              child: CircleAvatar(
                maxRadius: 19.5,
                backgroundColor: isChoeseColor[index]
                    ? Color(int.parse(widget.data.colors![index]))
                    : theme(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  // backgroundColor:Colors.black,
                  backgroundColor: theme(context).primaryColorDark,
                  radius: 19,
                  child: CircleAvatar(
                    backgroundColor:
                        Color(int.parse(widget.data.colors![index])),
                    radius: 15,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
