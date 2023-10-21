import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/view/main_screens/presentation/widget/check_out_widgets/checkout_theme_picker.dart';

import '../../../../../config/theme/cubit_changer/theme_cubit.dart';

class CheckoutOneDateItem extends StatefulWidget {
  final String title;
  final double width;
  final bool isHour;
  const CheckoutOneDateItem({super.key,required this.title,required this.width,required this.isHour});

  @override
  State<CheckoutOneDateItem> createState() => _CheckoutOneDateItemState();
}

class _CheckoutOneDateItemState extends State<CheckoutOneDateItem> {
    DateTime _usDateTime = DateTime.now();
    TimeOfDay _usHourTime = TimeOfDay.now();

    Jalali _persianDateTiem = Jalali.now();
    TimeOfDay _persianHour = TimeOfDay.now();

  _showUsDatePicker(bool isdark) {
    showDatePicker(
            builder: (context, child) => CheckoutPickerTheme(isDark: isdark,child: child,),
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        if(value != null) {_usDateTime = value;}
        else {DateTime.now();}
      });
    });
  }

  _showPersianTimePicker(bool isdark) async{
    await showPersianTimePicker(
      builder: (context, child) => CheckoutPickerTheme(isDark: isdark,child: child,),
      context: context, 
      initialTime: TimeOfDay.now())
        .then((value){
          setState(() {
            if(value != null){_persianHour = value;}
            else {_persianHour = TimeOfDay.now();}
          });
        });
  }


  _showPersianDatePicker(bool isDark)async{
    showPersianDatePicker(
      builder: (context, child) => CheckoutPickerTheme(isDark: isDark,child: child,),
      context: context, 
      initialDate: Jalali.now(), 
      firstDate: Jalali(1401), 
      lastDate: Jalali(1410))
        .then((value) {
          setState(() {
            if(value != null){_persianDateTiem = value;}
            else {Jalali.now();}
          });
        })
      ;
  }
  
  _showUSTimePicker(bool isdark) {
    showTimePicker(
      context: context,
      builder: (context, child) => CheckoutPickerTheme(isDark: isdark,child: child,),
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    ).then((value) { 
      setState(() {
        if(value != null) {_usHourTime = value;}
        else {TimeOfDay.now();}
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: false);
      return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title.tr(),
          style: theme(context).textTheme.titleSmall!.copyWith(fontSize: 13,color: theme(context).focusColor),
        ),
        sizeBoxH(5),
        InkWell(
          onTap: () {
            widget.isHour 
              ? isEnglish(context) ? _showUSTimePicker(themeCubit.isDark) : _showPersianTimePicker(themeCubit.isDark)
              : isEnglish(context) ? _showUsDatePicker(themeCubit.isDark) : _showPersianDatePicker(themeCubit.isDark);},
          child: Container(
            height: sizeH(context) * 0.055,
            width: widget.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 7,
                    color:themeCubit.isDark ? theme(context).backgroundColor : theme(context).focusColor.withOpacity(0.3),
                    offset:const Offset(1, 2))
              ],
              color: theme(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: widget.isHour
                  ? Text(
                    isEnglish(context)
                    ? '${_usHourTime.hour.toString()}:${_usHourTime.minute.toString()}'
                    :  '${_persianHour.hour.toString()}:${_persianHour.minute.toString()}',
                    style: theme(context).textTheme.titleSmall!.copyWith(fontSize: sizeW(context)*0.03,color: theme(context).focusColor),

                    )
                  : Text(
                    isEnglish(context) 
                    ? '${_usDateTime.year.toString()}/${_usDateTime.month.toString()}/${_usDateTime.day.toString()}'
                    : '${_persianDateTiem.year.toString()}/${_persianDateTiem.month.toString()}/${_persianDateTiem.day.toString()}',
                    style: theme(context).textTheme.titleSmall!.copyWith(fontSize: sizeW(context)*0.03,color: theme(context).focusColor),
                    )
                  
            ),
          ),
        ),
      ],
    );
  }
}

