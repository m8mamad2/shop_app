// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/authenticaton_screen/data/repo/auth_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/backend/backend_db_repo_body.dart';
import 'package:project3/src/view/main_screens/presentation/screen/user_info_screen.dart';
import 'package:project3/src/view/main_screens/presentation/widget/user_info_widget/map.dart';

import '../../../../../config/localization/is_english.dart';
import '../../../../../config/theme/cubit_changer/theme_cubit.dart';
import '../../../../../config/theme/theme.dart';
import '../../../../../core/common/constans/size.dart';
import '../../../../../core/widget/bottom_navigatebar_widget.dart';
import '../../../data/data_source/remote/backend_initial.dart';
import '../../../domain/entities/backend_db_entity.dart';
import '../../blocs/backend_db_bloc/backend_db_bloc.dart';

class UserInfoOneItemWidget extends StatefulWidget {
  final String title; //! title
  final String value; //! req to backend for show
  final String key0; //!
  final bool isDataNull;
  final TextEditingController controller;
  final bool isExist;
  final User? curretnUser;
  final bool isMap;
  final TextInputType inputType;
  const UserInfoOneItemWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.key0,
    required this.isDataNull,
    required this.controller,
    required this.isExist,
    required this.curretnUser,
    required this.isMap,
    required this.inputType
  }) : super(key: key);

  @override
  State<UserInfoOneItemWidget> createState() => _UserInfoOneItemWidgetState();
}

class _UserInfoOneItemWidgetState extends State<UserInfoOneItemWidget> {
  

  @override
  Widget build(BuildContext context) {
    bool isDark = BlocProvider.of<ThemeCubit>(context).isDark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: sizeH(context)*0.04,
          width: sizeW(context)*0.4,
          margin:  EdgeInsets.symmetric(horizontal:sizeW(context)*0.03),
          decoration:BoxDecoration(
            color: theme(context).primaryColor,
            borderRadius:const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),
          child: Center(child: Text(widget.title.tr(),
            style:isEnglish(context)
             ? theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).canvasColor,fontSize:sizeW(context)*0.03)
             : theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).canvasColor,fontSize:sizeW(context)*0.03)
             )),
          
        ),
        Container(
          height: sizeH(context)*0.07,
          decoration: BoxDecoration(
            color: isDark ? theme(context).canvasColor : theme(context).backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme(context).primaryColor,width: 0.3)
          ),
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ()async => widget.isMap 
                    ? map()
                    : showModalBottomSheet(
                    context: context, 
                    shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:  Radius.circular(25))),
                    backgroundColor: isDark ? theme(context).canvasColor : theme(context).backgroundColor,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.02),
                                child: Text('Enter your ${widget.title}'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeW(context)*0.06,color: theme(context).focusColor),),
                              ),
                            ),
                            sizeBoxH(8),
                            Center(
                              child: SizedBox(
                                width: sizeW(context)*0.85,
                                height: sizeH(context)*0.06,
                                child: TextFormField(
                                  keyboardType: widget.inputType,
                                  autofocus: true,
                                  style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor),
                                  controller: widget.controller,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Write here'.tr(),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: theme(context).focusColor,width: 0.4)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: theme(context).focusColor,width: 0.4)
                                    )
                                  ),
                      
                                ),
                              ),
                            ),
                            sizeBoxH(sizeH(context)*0.04),
                            Center(
                              child: ElevatedButton(
                                onPressed: ()async{
                                  // print('_________${widget.isExist}');
                                  // AuthRepoBody repo = AuthRepoBody();
                                  // Storage storage = Storage(BackendInitial.instance.client);
                                  // Databases databases = Databases(BackendInitial.instance.client);
                                  // Account account = Account(BackendInitial.instance.client);
                                  // BackendDBRepoBody backendDBRepoBody = BackendDBRepoBody(repo, storage, databases, account);
                                  // BackendDBEntity data = BackendDBEntity(
                                  //   id: widget.curretnUser!.$id,
                                  //   email: widget.curretnUser!.email,
                                  //   address: widget.key0 == 'address' ? widget.controller.text : null,
                                  //   family: widget.key0 == 'family' ? widget.controller.text : null,
                                  //   homeNumber: widget.key0 == 'homeNumber' ? widget.controller.text : null,
                                  //   name: widget.key0 == 'name' ? widget.controller.text : null,
                                  //   phoneNumber: widget.key0 == 'phoneNumber' ? widget.controller.text : null,
                                  //   );
                      
                                  BlocProvider.of<BackendDbBloc>(context).add(UpdateUserInfoDataBackendDBEvent(context,widget.key0, widget.controller.text.trim()));
                                  
                                  // await backendDBRepoBody.createUserInfoData(data).then((value) => print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS+++++++++++++++++++++++++++++++'));
                                  widget.controller.clear();
                      
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme(context).primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  minimumSize: Size(sizeW(context)*0.9, sizeH(context)*0.06),
                                ), 
                                child: Text('Ok'.tr()),
                                ),
                            ),
                            sizeBoxH(sizeH(context)*0.03)
                          ],
                        ),
                    ),
                    ),

                  child: Text(widget.value,style: theme(context).textTheme.titleMedium!.copyWith(fontSize:widget.isMap? sizeW(context)*0.03 : sizeW(context)*0.04,color: theme(context).focusColor),)),

                widget.isDataNull 
                ? Icon(Icons.close,color: theme(context).primaryColor,size:sizeW(context)*0.05,)
                : Icon(Icons.check,color: theme(context).primaryColor,size:sizeW(context)*0.05,),
              ]),
          ),
        ),
      ],
    );
  }

map()async{

        Storage storage = Storage(BackendInitial.instance.client);
        Databases databases = Databases(BackendInitial.instance.client);
        Account account = Account(BackendInitial.instance.client);
        AuthRepoBody repoBody = AuthRepoBody();
        BackendDBRepoBody repo = BackendDBRepoBody(repoBody,storage,databases,account);

        String data = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MapWidget(),));
        print('--------> second time$data');
        repo.updateUserInfoData('address', data)
          .then((value)async =>await context.navigation(context, UserInfoScreen(onPress: BottomNavigateWidget(selected: 4,))))
          .catchError((err)=>print(err));

        // BlocProvider.of<BackendDbBloc>(context).add(UpdateUserInfoDataBackendDBEvent(context, 'address', data));
        

      }

    
}



