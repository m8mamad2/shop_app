// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_segment_title_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../core/common/constans/texts.dart';


class DiscountCodeWidget extends StatefulWidget {
  TextEditingController controller;
  num total;
  DiscountCodeWidget(
      {super.key,
      required this.controller,
      required this.total});

  @override
  State<DiscountCodeWidget> createState() => _DiscountCodeWidgetState();
}

class _DiscountCodeWidgetState extends State<DiscountCodeWidget> {

  late num total ;
  @override
  void initState() {
    super.initState();
    total = widget.total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckoutSegmentTitleWidget(null, Icons.discount, 'offer Code'.tr()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(FocusNode());
                print(total);
                if (widget.controller.text == offer) {
                  setState(() {
                    total = total - 5;
                    showSnackBar('Discount applied'.tr(),true);
                    print(total);
                  });
                } else {
                  showSnackBar('your code is wrong'.tr(),false);
                }
                widget.controller.clear();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: theme(context).primaryColor,
                  shadowColor:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor : theme(context).focusColor,
                  elevation: 7,
                  minimumSize: Size(
                    sizeW(context) * 0.07,
                    sizeH(context) * 0.06,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Icon(Icons.add),
            ),
            sizeBoxW(8),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        color:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor : theme(context).focusColor.withOpacity(0.4),
                        offset:const Offset(0, 4))
                  ]),
              width: sizeW(context) * 0.65,
              height: sizeH(context) * 0.06,
              child: Center(
                child: TextFormField(
                  style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: 13),
                  controller: widget.controller,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      fillColor: theme(context).dialogBackgroundColor,
                      filled: true,
                      hintText: 'your code...'.tr(),
                      hintStyle: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: 13)),
                ),
              ),
            ),
          ],
        ),
      
      ],
    );
  }

  showSnackBar(String title,bool isWrite){
    showTopSnackBar(
      Overlay.of(context)!,
      isWrite 
      ? CustomSnackBar.success(
        backgroundColor: Theme.of(context).primaryColorLight,
        textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).primaryColor,fontSize: 16),
        message: title)
      : CustomSnackBar.error(
        textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).primaryColor,fontSize: 16),
        backgroundColor: Theme.of(context).primaryColorLight,
        message: title)
      
);
  }
}
