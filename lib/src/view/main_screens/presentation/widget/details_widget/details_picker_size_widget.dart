import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project3/src/view/main_screens/domain/entities/products_entity.dart';

import '../../../../../config/theme/theme.dart';
import '../../../../../core/common/constans/size.dart';

class DetailsPickerSizesWidget extends StatefulWidget {
  ProductsEntity data;
  DetailsPickerSizesWidget({super.key, required this.data});

  @override
  State<DetailsPickerSizesWidget> createState() =>
      _DetailsPickerSizesWidgetState();
}

class _DetailsPickerSizesWidgetState extends State<DetailsPickerSizesWidget> {
  List<bool> isChoese = [];
  bool isChoeseForContinue = false;
  late var choeseSize;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Size'.tr(),
          style: theme(context).textTheme.titleMedium!.copyWith(fontSize: 16)),
      SizedBox(
        width: sizeW(context) * 0.44,
        height: sizeH(context) * 0.06,
        child: GridView.builder(
          itemCount: widget.data.size!.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            isChoese.add(false);
            return GestureDetector(
              onTap: () {
                isChoese.replaceRange(0, isChoese.length,
                    [for (int i = 0; i < isChoese.length; i++) false]);
                isChoese[index] = true;
                isChoeseForContinue = true;
                choeseSize = widget.data.size![index];
                setState(() {});
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                shadowColor: theme(context).primaryColorLight.withOpacity(0.3),
                elevation: 4,
                color: isChoese[index]
                    ? theme(context).primaryColorLight
                    : theme(context).primaryColorDark,
                child: Center(
                  child: Text(widget.data.size![index].toString(),
                      style: theme(context).textTheme.titleMedium!.copyWith(
                          color: isChoese[index]
                              ? theme(context).primaryColor
                              : theme(context).primaryColorLight)),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
