// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project3/src/config/localization/is_english.dart';
// import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
// import 'package:project3/src/config/theme/theme.dart';

// import '../../../../../core/common/constans/size.dart';
// import '../../blocs/chat_bloc/chat_bloc.dart';
// import '../../screen/chat_screen.dart';

// class ChatSenderWidget extends StatelessWidget {
//   const ChatSenderWidget({
//     super.key,
//     required this.controller,
//     required this.widget,
//   });

//   final TextEditingController controller;
//   final ChatScreen widget;

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//           alignment: Alignment.bottomCenter,
//           child: SizedBox(
//             height: sizeH(context) * 0.13,
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width:MediaQuery.of(context).size.width - 60,
//                         height: sizeH(context) * 0.095,
//                         child: Card(
//                           elevation: 9,
//                           shadowColor: BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor : theme(context).focusColor,
//                           margin: const EdgeInsets.only(left: 2, right: 2, bottom: 15),
//                           color:BlocProvider.of<ThemeCubit>(context).isDark ? theme(context).backgroundColor : theme(context).canvasColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: TextFormField(
//                             controller: controller,
//                             textAlignVertical:TextAlignVertical.center,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: 5,
//                             minLines: 1,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "type something".tr(),
//                               hintStyle:isEnglish(context)
//                                 ? theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeW(context)*0.034,color: theme(context).focusColor)
//                                 : theme(context).textTheme.titleSmall!.copyWith(fontSize: sizeW(context)*0.034,color: theme(context).focusColor),

//                               suffixIcon: InkWell(
//                                 onTap: () {
//                                   BlocProvider.of<ChatBloc>(context).add(EmitToChatEvent(controller.text.trim(), widget.name));
//                                   controller.clear();
//                                 },
//                                 child: Container(
//                                   margin:const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
//                                   width: sizeW(context) * 0.15,
//                                   height: MediaQuery.of(context).size.height,
//                                   decoration: BoxDecoration(
//                                     color: theme(context).primaryColor,
//                                     borderRadius: BorderRadius.circular(10)
//                                   ),
//                                   child:  Icon(Icons.send,color: theme(context).backgroundColor,size: 25,),
//                                 ),
//                               ),
//                               contentPadding:const EdgeInsets.symmetric(horizontal: 20),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ]),
//           ),
//         );
//   }
// }
