
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/icons.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/core/widget/dialogs.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/main_screens/data/data_source/local/init_hive_db.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/contact_db_bloc/contact_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/contact/contact_details.dart';

import '../../../../../config/localization/is_english.dart';
import '../../../../../core/common/constans/lottie.dart';
import '../../../../../core/common/constans/size.dart';
import '../../widget/contacts_widget/contacts_one_item.dart';
import 'add_concats_screen.dart';


GlobalKey conteactsKey = GlobalKey();
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}
class _ContactsScreenState extends State<ContactsScreen> {

  List<ContactDBEntity>? list = [];
  TextEditingController controller = TextEditingController();



  @override
  void initState() {
    BlocProvider.of<ContactDbBloc>(context).add(InitialContactDBEvent());
    super.initState();
  }


  getSuggestion(String query) async {
    List<String> strings = list!.map((e) => e.name!).toList();
    List<String> matches = []; //! seggestion
    matches.addAll(strings);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme(context).backgroundColor,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: theme(context).primaryColor,),onPressed: ()=>context.navigation(context,const BottomNavigateWidget()),),
      ),
      body: BlocConsumer<ContactDbBloc,ContactDbState>(
        listener: (context, state) {
          state is LoadingContactDBState 
            ? LoadingDialogs.show(context)
            : LoadingDialogs.hide(context);
        },
        builder: (context, state) {
          if(state is LoadingContactDBState)return loading(context);
          if(state is SuccessContactDBState){
           List<ContactDBEntity> data = state.data;
           list = data;
           return data.isEmpty 
           
            ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: sizeW(context)*0.9,child: BlocProvider.of<ThemeCubit>(context).isDark ? kDarkEmptyLottie : kLightEmptyLottie),
                      sizeBoxH(sizeH(context)*0.03),
                      Text('Your Contacts is Empty'.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.05),)
                    ],
                  ))

            : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //? title
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: sizeW(context)*0.05,vertical: sizeH(context)*0.01),
                    child: Text('Contacts'.tr(),style: theme(context).textTheme.displayMedium!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.06),),
                  ),
                  
                  //? search 
                  Center(
                    child: Container(
                              decoration: BoxDecoration(
                                  color: theme(context).dialogBackgroundColor,
                                  borderRadius: BorderRadius.circular(20)),
                              width: sizeW(context) * 0.9,
                              height: sizeH(context) * 0.06,
                              child: TypeAheadField<String>(
                                // noItemsFoundBuilder: (context) => Text('sorry... not Found!',style: theme(context).textTheme.titleMedium,),
                                loadingBuilder: (context) => loading(context),
                                builder:(context, controller, focusNode) =>  TextField(
                                    controller: controller,
                                    style: theme(context).textTheme.titleMedium,
                                    decoration: InputDecoration(
                                        iconColor:theme(context).primaryColor,
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.all(2),
                                        hintStyle: theme(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(fontSize: 15,color: theme(context).focusColor),
                                        hintText: 'Search'.tr(),
                                        icon:  Padding(
                                          padding:isEnglish(context) ? EdgeInsets.only(left: sizeW(context)*0.04) : EdgeInsets.only(right: sizeW(context)*0.04),
                                          child: const Icon(Icons.search),
                                        ))),
                                suggestionsCallback: (pattern) async => await getSuggestion(pattern),
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 35),
                                      child: Text(suggestion,style:theme(context).textTheme.titleMedium!.copyWith(color: theme(context).focusColor),
                                      ),
                                    ),
                                  );
                                },
                                onSelected: (suggestion) {
                                  controller.text = suggestion;
                                  ContactDBEntity data = list!.firstWhere((element) => element.name == suggestion);
                                  context.navigation(context,ContactsDetails(data: data,) );
                                  
                                },
                                // suggestionsBoxDecoration:SuggestionsBoxDecoration(borderRadius: BorderRadius.circular(25)),
                              )),
                  ),
                  sizeBoxH(sizeH(context)*0.02),
            
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) => ContactsOneItem(data:data[index],index:index),),
                ],
              ),
            );
          }
          if(state is FailContactDBState)return Text(state.error);
          return Container();
        },
        
      ),
      floatingActionButton: ElevatedButton(
        onPressed: ()=>context.navigation(context, const AddContactScreen()),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme(context).primaryColor,
          shape:const CircleBorder(),
          minimumSize: Size(sizeW(context)*0.15, sizeH(context)*0.08)
        ),
        child: Icon(Icons.add,color: Theme.of(context).canvasColor,),
        ),
    );
  }
}

//! Delete button STF
// class DeleteDialogButton extends StatefulWidget {
//   final bool isDelete;
//   final int index;
//   final VoidCallback onPress;
//   const DeleteDialogButton({super.key,required this.isDelete,required this.index,required this.onPress});
//   @override
//   State<DeleteDialogButton> createState() => _DeleteDialogButtonState();
// }
// class _DeleteDialogButtonState extends State<DeleteDialogButton> {
//   @override
//   Widget build(BuildContext context) {
    // return ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     elevation: 0,
    //     backgroundColor:widget.isDelete ? theme(context).primaryColor : theme(context).backgroundColor,
    //     minimumSize: Size(sizeW(context)*0.25, sizeH(context)*0.06),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(14),
    //       side: BorderSide(color: theme(context).primaryColor,width:widget.isDelete ? 0 : 1)
    //     )
    //   ),
    //   child: Text(widget.isDelete ? 'Yes'.tr() : 'NO'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(
    //     color: widget.isDelete ? theme(context).backgroundColor : theme(context).primaryColor
    //   ),),
    //   onPressed: widget.onPress,
    //   // onPressed: () async {
    //   //   if(widget.isDelete) {
    //   //     print(widget.index);
    //   //     BlocProvider.of<ContactDbBloc>(context).add(DeleteFromCotactsBoxEvent(widget.index));
    //   //     setState(() {});
    //   //     // await boxList[2].deleteAt(index).then((value) => print('Success'));
    //   //     // ignore: use_build_context_synchronously
    //   //     }
    //   //   else{context.navigationBack(context);}
    //   // }, 
    //   );
//   }
// }
