// // ignore_for_file: must_be_immutable

// import 'dart:io';
// import 'dart:typed_data';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:project3/src/config/theme/theme.dart';
// import 'package:project3/src/core/common/constans/images.dart';

// import '../../../../../core/common/constans/size.dart';
// import '../../../../../core/widget/loading.dart';
// import '../../blocs/backend_db_bloc/backend_db_bloc.dart';

// class ProfileImageWidget extends StatelessWidget {
//   ImagePicker? picker;
//   Future<Uint8List> image;
//   Map<String,dynamic> userInfoData;
//   bool isDrawer;
//   double height;
//   Color color;
  
//    ProfileImageWidget({
//     super.key,
//     this.picker,
//     required this.image,
//     required this.userInfoData,
//     required this.isDrawer,
//     required this.height,
//     required this.color,
//   });


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//             width: sizeW(context)*0.29,
//             height: height,
//             child: Stack(
//               children: [
//                 FutureBuilder<Uint8List>(
//                   future: image,
//                   builder: (context, snapshot) {
//                     switch(snapshot.connectionState){
//                       case ConnectionState.none:
//                       case ConnectionState.waiting:return loading(context);
//                       default:
//                        return snapshot.data != null && snapshot.data!.isNotEmpty
//                             ? Container(decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               boxShadow: [BoxShadow(blurRadius: 8,color: Colors.black26,offset: Offset(0, 3))]
//                             ),child: CircleAvatar(backgroundImage: MemoryImage(snapshot.data!),radius:70,),)
//                             :const CircleAvatar(backgroundImage: AssetImage(kNoProfileImage),radius: 70);
//                     }
//                   },),
//                 isDrawer
//                 ? Container()
//                 : Align(
//                   alignment: Alignment.bottomRight,
//                   child: CircleAvatar(
//                     backgroundColor: theme(context).primaryColor,
//                     radius: 18,
//                     child: IconButton(
//                       icon:FittedBox(child: Icon(Icons.image_search_sharp,color: theme(context).backgroundColor,)),
//                       onPressed: () async{
//                         final image = await picker!.pickImage(source: ImageSource.gallery);

//                         if(image != null){


//                          await showDialog(
//                             context: context, 
//                             builder: (context) => AlertDialog(
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//                               actions: [
//                                 Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Text('Is this your picture?'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(
//                                         color: theme(context).focusColor,
//                                         fontSize: sizeW(context)*0.04,
//                                         fontWeight: FontWeight.bold
//                                       ),),
//                                       Padding(
//                                         padding:  EdgeInsets.symmetric(horizontal: sizeW(context)*0.1,vertical: sizeH(context)*0.07),
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.circular(10),
//                                           child: Image.file(File(image.path),width: sizeW(context)*0.6,height: sizeH(context)*0.3,)),
//                                       ),
//                                       sizeBoxH(sizeH(context)*0.04),
//                                       ElevatedButton(
//                                         onPressed: ()=> BlocProvider.of<BackendDbBloc>(context).add(CreateUserPictureBackendDBEvent(context, image.path)), 
//                                         style: ElevatedButton.styleFrom(
//                                           minimumSize: Size(sizeW(context)*0.4 ,sizeH(context)*0.05),
//                                           backgroundColor: theme(context).primaryColor,
//                                         ),
//                                         child: Text('Uplado'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(
//                                           color: theme(context).backgroundColor,
//                                           fontSize: sizeW(context)*0.03
//                                           ),))
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),);
//                             // BlocProvider.of<BackendDbBloc>(context).add(InitialBackendDBEvent());
//                           }
//                           else print('------>OOOOOOOOH');
//                       },
//                     ),
//                     )),
//               ],
//             ),
//           ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Text(userInfoData['name'] ?? '',style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: 22,color: color),),
//                 ),
//       ],
//     );
//   }
// }

// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/images.dart';

import '../../../../../core/common/constans/size.dart';
import '../../../../../core/widget/loading.dart';
import '../../blocs/backend_db_bloc/backend_db_bloc.dart';

class ProfileImageWidget extends StatelessWidget {
  ImagePicker? picker;
  Uint8List? image;
  String? name;
  bool isDrawer;
  double height;
  Color color;
  double fontSize;
  
   ProfileImageWidget({
    super.key,
    this.picker,
    required this.image,
    required this.name,
    required this.isDrawer,
    required this.height,
    required this.color,
    required this.fontSize
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: sizeW(context)*0.29,
            height: height,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 8,color: Colors.black26,offset: Offset(0, 3))]),
                    child: image != null && image!.isNotEmpty

                      ? CircleAvatar(backgroundImage: MemoryImage(image!),radius:70,)
                      : const CircleAvatar(backgroundImage: AssetImage(kNoProfileImage),radius: 70)),
                
                isDrawer
                  ? Container()
                  : Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: theme(context).primaryColor,
                      radius: 18,
                      child: IconButton(
                        icon:FittedBox(child: Icon(Icons.image_search_sharp,color: theme(context).backgroundColor,)),
                        onPressed: () async{
                          final image = await picker!.pickImage(source: ImageSource.gallery);

                          if(image != null){


                          await showDialog(
                              context: context, 
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                actions: [
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Is this your picture?'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(
                                          color: theme(context).focusColor,
                                          fontSize: sizeW(context)*0.04,
                                          fontWeight: FontWeight.bold
                                        ),),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: sizeW(context)*0.1,vertical: sizeH(context)*0.07),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.file(File(image.path),width: sizeW(context)*0.6,height: sizeH(context)*0.3,)),
                                        ),
                                        sizeBoxH(sizeH(context)*0.04),
                                        ElevatedButton(
                                          onPressed: ()=> BlocProvider.of<BackendDbBloc>(context).add(CreateUserPictureBackendDBEvent(context, image.path)), 
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(sizeW(context)*0.4 ,sizeH(context)*0.05),
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
                            else print('------>OOOOOOOOH');
                        },
                      ),
                      )),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(name ?? 'No Name',style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: fontSize,color: color),),
        ),
      ],
    );
  }
}

