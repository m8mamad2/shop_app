import 'package:appwrite/appwrite.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/top_snack_bar.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/presentation/screen/check_out_screen.dart';

import '../../../../../core/widget/bottom_navigatebar_widget.dart';
import '../../../../authenticaton_screen/data/repo/auth_repo_body.dart';
import '../../../data/data_source/remote/backend_initial.dart';
import '../../../data/repo/backend/backend_db_repo_body.dart';
import '../../blocs/backend_db_bloc/backend_db_bloc.dart';
import '../../screen/user_info_screen.dart';
import '../user_info_widget/map.dart';

Widget checkoutOneInfoItem(BuildContext context, double width,String value,String title,TextEditingController controller,String updateKey,bool isMap,num total) {
    bool isDark = BlocProvider.of<ThemeCubit>(context).isDark;

    map()async{

        Storage storage = Storage(BackendInitial.instance.client);
        Databases databases = Databases(BackendInitial.instance.client);
        Account account = Account(BackendInitial.instance.client);
        AuthRepoBody repoBody = AuthRepoBody();
        BackendDBRepoBody repo = BackendDBRepoBody(repoBody,storage,databases,account);

        String data = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MapWidget(),));
        print('--------> second time$data');
        repo.updateUserInfoData('address', data)
          .then((value)async =>await context.navigation(context, CheckOutScreen(total: total)))
          .catchError((err)=>print(err));


      }
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr(),
          style: theme(context).textTheme.titleSmall!.copyWith(fontSize: 13,color: theme(context).focusColor),
        ),
        sizeBoxH(5),
        InkWell(
          onTap: () =>isMap
            ? map()
            : showModalBottomSheet(
                    context: context, 
                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:  Radius.circular(25))),
                    backgroundColor: theme(context).canvasColor,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          sizeBoxH(10),
                          Center(child: Text('Enter your $title'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeW(context)*0.06,color: theme(context).focusColor),),),
                          sizeBoxH(8),
                          Center(
                            child: SizedBox(
                              width: sizeW(context)*0.85,
                              height: sizeH(context)*0.06,
                              child: TextField(
                                autofocus: true,
                                controller: controller,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:BorderSide(color: theme(context).focusColor.withOpacity(0.3),width: 1)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:  BorderSide(color: theme(context).focusColor.withOpacity(0.3),width: 1)
                                  )
                                ),
                              ),
                            ),
                          ),
                          sizeBoxH(sizeH(context)*0.04),
                          Center(
                            child: ElevatedButton(
                              onPressed: (){
                                controller.text.isEmpty
                                  ? showSnackBarOnTop(context, 'Please enter something...'.tr())
                                  : BlocProvider.of<BackendDbBloc>(context).add(UpdateUserInfoDataBackendDBEvent(context,updateKey, controller.text.trim()));
                                controller.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                minimumSize: Size(sizeW(context)*0.86, sizeH(context)*0.06),
                              ), 
                              child: Text('ok'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).backgroundColor,fontSize: sizeW(context)*0.04),),
                              ),
                          ),
                          sizeBoxH(sizeH(context)*0.03)
                        ],
                      ),
                      ),),
          
          child: Container(
            height: sizeH(context) * 0.055,
            width: width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 7,
                    color:isDark ? theme(context).backgroundColor : theme(context).focusColor.withOpacity(0.3),
                    offset:const Offset(1, 2))
              ],
              color: theme(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(value,style: theme(context).textTheme.titleSmall!.copyWith(fontSize: sizeW(context)*0.03,color: theme(context).focusColor),)),
          ),
        ),
      ],
    );


    
  }
