// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportErrorScreen extends StatefulWidget {
  const ReportErrorScreen({super.key});

  @override
  State<ReportErrorScreen> createState() => _ReportErrorScreenState();
}

class _ReportErrorScreenState extends State<ReportErrorScreen> {

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    name.dispose();
    email.dispose();
    super.dispose();
  }

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme(context).canvasColor,
      appBar: AppBar(
        backgroundColor: theme(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: theme(context).primaryColor,),
          onPressed: () => context.navigationBack(context)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
          key: _forKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    sizeBoxH(sizeH(context)*0.01),
                    Text(
                      'Report Error'.tr(),
                      style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: 22,color: theme(context).primaryColor),
                    ),
                    Text(
                      'Please complete the form below'.tr(),
                      style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor),
                    ),
                    ],
                  ),
                  SizedBox(     
                    width: sizeW(context)*0.35,height: sizeH(context)*0.2,
                    child: kReportErrorLottie
                  ),
                ],
              ),
              errorTextField(title,'Title','enter your caption',1),
              errorTextField(description,'Description', 'enter your descripton',15),
              sizeBoxH (20),
              Center(child:  ElevatedButton(
                onPressed: ()async{
                    
                  final Uri url = Uri(
                    scheme: 'mailto',
                    path: 'm8mamad2@gmail.com',
                    queryParameters: {
                      'subject':'${title.text}',
                      'body':'${description.text}'
                    }
                    );
                  
                  
                  print(url.query);


                  if(_forKey.currentState!.validate()) {

                    if(await canLaunchUrl(url)){
                      await launchUrl(url);
                      return await showDialog(context: context, builder: (context) => inUIDialogs(context, 'success','Sending Email was Successfully',true,() => context.navigationBack(context)),);
                    }else{
                      return await showDialog(context: context, builder: (context) => inUIDialogs(context, 'fail', 'Sending Email was Failed' ,false,() => context.navigationBack(context)),);
                    }


                    }
                },


                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    backgroundColor: theme(context).primaryColor,
                    shadowColor:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor :theme(context).focusColor,
                    elevation: 15,
                    minimumSize:  Size(sizeW(context)* 0.61, 50 /*160, 47*/)),
                child: Text('Send'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).focusColor : theme(context).backgroundColor)
                    ),
              )),
              sizeBoxH(sizeH(context)*0.048,)
            ],
          ),
            ),
        ),
      ),
    );
  }

  Column errorTextField(TextEditingController controller,String title,String hintText,int maxLines) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor),),
        ),
        
        TextFormField(
                maxLines: maxLines,
                controller: controller,
                validator: (value) {if(value == null &&  value!.isEmpty)return 'Enter Something ... ';} ,
                style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor),
                decoration: InputDecoration(
                  errorStyle: theme(context).textTheme.bodyMedium!.copyWith(fontSize: sizeW(context)*0.015,color: Colors.red),
                  contentPadding: EdgeInsets.symmetric(vertical: sizeH(context)*0.01,horizontal: sizeW(context)*0.04),
                    hintText: hintText.tr(),
                    hintStyle: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.03),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: theme(context).primaryColor))),
              ),
        sizeBoxH(sizeH(context)*0.013,)
    ]);
  }
}
