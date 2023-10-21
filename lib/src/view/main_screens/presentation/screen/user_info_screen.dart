
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/constans/widgets.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/core/common/global_state/repo/repo.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/backend_db_bloc/backend_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/widget/profile_widget/profile_image_widget.dart';
import 'package:project3/src/view/main_screens/presentation/widget/user_info_widget/map.dart';

import '../../../../core/common/constans/images.dart';
import '../../../../core/common/constans/texts.dart';
import '../../../../core/widget/error_bloc.dart';
import '../widget/user_info_widget/user_info_one_item.dart';

class UserInfoScreen extends StatefulWidget {
  final Widget onPress;
  const UserInfoScreen({super.key,required this.onPress});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}
class _UserInfoScreenState extends State<UserInfoScreen> {

  TextEditingController controller = TextEditingController();
  bool willPop = false;

  ImagePicker picker = ImagePicker();
  XFile? imageFile;
  late bool disable;

  // late BackendDbBloc myBloc;
  // late StreamSubscription stream;
  bool isLoading = false;
  

  @override
  void initState() {
    super.initState();
    disable = false;
    BlocProvider.of<BackendDbBloc>(context).add(InitialBackendDBEvent());
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
    return WillPopScope(
      onWillPop: ()async{
        if(willPop){ return true; }
        else {
            GlobalRepo repo = GlobalRepo(context: context);
            await repo.save();
            
            setState(() {
              disable = true;
              willPop = true;
              });
            print('$disable ,, $willPop');
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavigateWidget(selected: 4,),));
            return false;
      
        // return (await showDialog(
        //     context: context, 
        //     builder:(context)=> AlertDialog(
        //       backgroundColor: theme(context).backgroundColor,
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //       title: Center(child: Text('Are you sure you want to leave the page?'.tr(),textAlign: TextAlign.center,style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor),)),
        //       alignment: Alignment.center,
        //       content: StatefulBuilder(
        //         builder: (context, setState) {
        //           return SizedBox(
        //             height: sizeH(context)*0.15,
        //             child: Column(
        //               children: [
        //                 const Spacer(),
        //                 Center(
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       ElevatedButton(
        //                         style: ElevatedButton.styleFrom(
        //                           minimumSize: Size(sizeW(context)*0.3, sizeH(context)*0.05),
        //                           backgroundColor:disable ? theme(context).focusColor.withOpacity(0.4) : theme(context).primaryColor
        //                         ),
        //                         onPressed:disable ? null : ()=> Navigator.of(context).pop(), 
        //                         child:Text('NO'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: disable ? theme(context).focusColor : theme(context).backgroundColor),)),
        //                       sizeBoxW(sizeW(context)*0.06),
        //                       ElevatedButton(
        //                         style: ElevatedButton.styleFrom(
        //                           minimumSize: Size(sizeW(context)*0.3, sizeH(context)*0.05),
        //                           backgroundColor: disable ? theme(context).focusColor.withOpacity(0.4) : theme(context).primaryColor
        //                         ),
        //                         onPressed: disable ? null : ()async{
        //                           setState(() {
        //                             disable = true;
        //                             willPop = true;
        //                             });
        //                           print('$disable ,, $willPop');
        //                           // await Future.delayed(const Duration(seconds: 5));
        //                           GlobalRepo repo = GlobalRepo(context: context);
        //                           await repo.save();
        //                           // Navigator.of(context).pop(true);
        //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavigateWidget(selected: 4,),));
        //                         }, 
        //                         child:Text('Yes'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: disable ? theme(context).focusColor : theme(context).backgroundColor))),
        //                     ],
        //                   ),
        //                 )
        //               ],
        //             ),
        //           );
        //         },
        //       )
        //     ))) 
        //     ?? false;
        }
      },
       
      child: SafeArea(
        child: Scaffold(
          backgroundColor:themeCubit.isDark ? theme(context).backgroundColor : theme(context).backgroundColor,
          body: BlocConsumer<BackendDbBloc,BackendDbState>(
            listener: (context, state) {
              print('+++++++++++++++++++++++++++ User Info $state');
                state is LoadingBackendDBState 
                  ? LoadingDialogs.show(context)
                  : LoadingDialogs.hide(context);
            },
            builder: (context, state) {
              if(state is LoadingBackendDBState)return loading(context);
              if(state is SuccessBackendDBState){
    
                User? curretnUser = state.currentUser;
                Map<String,dynamic> data = state.userInfoData;
                Uint8List? image = state.image;

                print('------------------------------${state.userInfoData}');
                print('____________________________________--${state.currentUser!.email}');

                
                return SingleChildScrollView(
                  physics:const ScrollPhysics(),
                  child: Stack(
                    children: [
                      Container(
                        width: sizeW(context),
                        height: sizeH(context)*0.2,
                        decoration: BoxDecoration(
                          color: theme(context).primaryColor,
                          borderRadius:const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )
    
                        ),
                        
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! title
                          sizeBoxH(sizeH(context)*0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.03),
                            child: Row(
                              children: [
                                Text('Your Information'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: 25,color: theme(context).backgroundColor),),
                                sizeBoxW(sizeW(context)*0.03),
                                Tooltip(
                                  message:'for change any information please click on field'.tr(),
                                  textStyle: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.03),
                                  decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(15),
                                      color: theme(context).backgroundColor,
                                      ),
                                  child:Icon(Icons.info_outline,color: theme(context).focusColor,),
                                  ),
                              ],
                            )),
                          
                          //! image
                          sizeBoxH(sizeH(context)*0.01),
                          Center(
                            child: SizedBox(
                              width: sizeW(context)*0.36,
                              height: sizeH(context)*0.17,
                              child: InkWell(
                               onTap: () async{
                                final image = await picker.pickImage(source: ImageSource.gallery);
                            
                                if(image != null){
                            
                            
                                await showDialog(
                                    context: context, 
                                    builder: (context) => AlertDialog(
                                      backgroundColor: theme(context).backgroundColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                      actions: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              sizeBoxH(sizeH(context)*0.03),
                                              Text('Is this your picture?'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(
                                                color: theme(context).focusColor,
                                                fontSize: sizeW(context)*0.04,
                                                fontWeight: FontWeight.bold
                                              ),),
                                              Padding(
                                                padding:  EdgeInsets.symmetric(horizontal: sizeW(context)*0.1,vertical: sizeH(context)*0.07),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.file(
                                                    io.File(image.path),
                                                    width: sizeW(context)*0.5,
                                                    height: sizeH(context)*0.2,
                                                    fit: BoxFit.cover,
                                                    )),
                                              ),
                                              ElevatedButton(
                                                onPressed: ()=>BlocProvider.of<BackendDbBloc>(context).add(CreateUserPictureBackendDBEvent(context, image.path)),
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(sizeW(context)*0.5,sizeH(context)*0.05),
                                                  backgroundColor: theme(context).primaryColor,
                                                ),
                                                child: Text('Uplado'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(
                                                  color: theme(context).backgroundColor,
                                                  fontSize: sizeW(context)*0.03
                                                  ),))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),);
                                    // BlocProvider.of<BackendDbBloc>(context).add(InitialBackendDBEvent());
                                }
                              },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(blurRadius: 8,color: Colors.black26,offset: Offset(0, 3))]),
                                        child: image != null && image.isNotEmpty
                              
                                          ? CircleAvatar(backgroundImage: MemoryImage(image),radius:sizeW(context)*0.18,)
                                          : CircleAvatar(backgroundImage:const AssetImage(kNoProfileImage),radius: sizeW(context)*0.18)
                                            ),
                                    
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child:CircleAvatar(backgroundColor: theme(context).primaryColor,radius: 18,child: Icon(Icons.image,color: theme(context).backgroundColor,),)
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
    
                         
                          //! items
                          sizeBoxH(sizeH(context)*0.04),
                          ListView.builder(
                            itemCount:5 ,
                            physics:const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              
                              bool isDataNull = data[kUserInfoGetValue[index]] == null ? true : false;
                              bool isExist = data.values.first == 0 ? false : true;
                              
                              return Padding(
                                padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.02,horizontal: sizeW(context)*0.01),
                                
                                child: UserInfoOneItemWidget(
                                  title:kUserInfoTitle[index],
                                  value: isDataNull ? 'nothing...😐'.tr() : data[kUserInfoGetValue[index]],
                                  key0: kUserUpdateValue[index],
                                  isDataNull: isDataNull,
                                  controller: controller,
                                  isExist: isExist,
                                  curretnUser : curretnUser,
                                  isMap: index == 2,
                                  inputType: kUserInfoInputType[index],
                                  
                                  ),
                              );
                            }
                          ),
    
                          //! button
                          Padding(
                            padding: EdgeInsets.only(bottom: sizeH(context)*0.024,top: sizeH(context)*0.035),
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(sizeW(context)*0.97, sizeH(context)*0.06),
                                  backgroundColor: theme(context).primaryColor
                                ),
                                onPressed: ()async{
                                  context.navigation(context,widget.onPress);
    
                                  GlobalRepo repo = GlobalRepo(context: context);
                                  await repo.save().then((value) => print('After ++++++++++++++++++++++++++===='));
                                  
                                  },
    
                                child: Text('it is Ok'.tr(),style: theme(context).textTheme.titleLarge!.copyWith(fontSize: 16,color:theme(context).backgroundColor)
                                       ), 
                                ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
              if(state is FailBackendDBState)return const ErrorBlocWidget();
              return Container(width: 100,height: 100,color: Colors.amber,);
            
            }
          ),
        ),
      ),
    );
  }



// Future<bool> _onWillPop()async{
//   return (
//     await showDialog(
//       context: context, 
//       builder:(context)=> AlertDialog(
//         backgroundColor: theme(context).backgroundColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         title: Center(child: Text('Are you sure you want to leave the page?'.tr(),textAlign: TextAlign.center,style: theme(context).textTheme.titleSmall!.copyWith(),)),
//         alignment: Alignment.center,
//         content: StatefulBuilder(
//           builder: (context, setState) {
//             return SizedBox(
//               height: sizeH(context)*0.15,
//               child: Column(
//                 children: [
//                   const Spacer(),
//                   Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
            
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(sizeW(context)*0.3, sizeH(context)*0.05),
//                             backgroundColor:disable ? theme(context).focusColor.withOpacity(0.4) : theme(context).primaryColor
//                           ),
//                           onPressed:disable ? null : ()=> Navigator.of(context).pop(false), 
//                           child:Text('NO'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: disable ? theme(context).focusColor : theme(context).backgroundColor),)),
            
//                         sizeBoxW(sizeW(context)*0.06),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(sizeW(context)*0.3, sizeH(context)*0.05),
//                             backgroundColor: disable ? theme(context).focusColor.withOpacity(0.4) : theme(context).primaryColor
//                           ),
//                           onPressed:disable ? null : ()async{
//                             setState(() => disable = true);
//                             print(disable);

//                             await Future.delayed(Duration(seconds: 5));
//                             // GlobalRepo repo = GlobalRepo(context: context);
//                             // await repo.save();
                    
//                             // Navigator.of(context).pop(true);
                            
//                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavigateWidget(selected: 4,),));
            
//                           }, 
//                           child:Text('Yes'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: disable ? theme(context).focusColor : theme(context).backgroundColor))),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         )
//       ))
//   ) ?? false;
// }

}
