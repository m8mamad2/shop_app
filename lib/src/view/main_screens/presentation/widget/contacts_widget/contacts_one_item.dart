

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/images.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/contact_db_bloc/contact_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/contact/contact_details.dart';

import '../../../../../config/localization/is_english.dart';
import '../../../../../core/common/constans/size.dart';




class ContactsOneItem extends StatefulWidget {
  final ContactDBEntity data;
  final int index;
  const ContactsOneItem({super.key,required this.data,required this.index});

  @override
  State<ContactsOneItem> createState() => _ContactsOneItemState();
}
class _ContactsOneItemState extends State<ContactsOneItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
    startActionPane: ActionPane(
      motion: const DrawerMotion(), 
      children: [
        SlidableAction(
          autoClose: true,
          flex: 2,
          borderRadius: BorderRadius.circular(5),
          backgroundColor: theme(context).primaryColor,
          foregroundColor: theme(context).backgroundColor,
          icon: Icons.delete,
          label: 'Delete'.tr(),
          onPressed:(context) => showDialog(
            context: context, 
            builder:(context) => AlertDialog(
              backgroundColor: theme(context).backgroundColor,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              title: Padding(
                padding: EdgeInsets.only(bottom: sizeH(context)*0.03,top: sizeH(context)*0.01),
                child: Center(child: Text('Are you sure about removing this?'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(color: theme(context).focusColor,fontWeight: FontWeight.bold,fontSize: sizeW(context)*0.04),)),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(top: sizeH(context)*0.03,bottom: sizeH(context)*0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      deleteDialogButton(false,widget.index,() => context.navigationBack(context)),
                      deleteDialogButton(true, widget.index,() => BlocProvider.of<ContactDbBloc>(context).add(DeleteFromCotactsBoxEvent(widget.index,context))),
                    ],
                  ),
                )
              ],
            )), )
      ]),
    
    child: Center(
      child: InkWell(
        onTap: ()=>context.navigation(context, ContactsDetails(data: widget.data)),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: sizeH(context)*0.001),
          width: double.infinity,
          color: theme(context).backgroundColor,
          child: ListTile(
            title: Text(widget.data.name ?? '',style: theme(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,color: theme(context).focusColor),),
            leading:
              widget.data.image == null || widget.data.image!.isEmpty 
                ? const CircleAvatar(backgroundImage:AssetImage(kNoProfileImage),radius: 40,) 
                : CircleAvatar(backgroundImage:MemoryImage(widget.data.image!),radius: 40,),
            subtitle: Text(widget.data.email ?? '',style: theme(context).textTheme.titleSmall!.copyWith(fontSize: 13,color: theme(context).focusColor.withOpacity(0.6)),),
            trailing: Icon(isEnglish(context)? Icons.keyboard_arrow_right_rounded : Icons.arrow_forward_ios_sharp,color: theme(context).primaryColor,size: sizeW(context)*0.04,),
          ),
        ),
      ),
    ),
  );
  }

  Widget deleteDialogButton(bool isDelete,int index,VoidCallback onPress)=>ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:isDelete ? theme(context).primaryColor : theme(context).backgroundColor,
        minimumSize: Size(sizeW(context)*0.25, sizeH(context)*0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: theme(context).primaryColor,width:isDelete ? 0 : 1)
        )
      ),
      onPressed: onPress,
      child: Text(isDelete ? 'Yes'.tr() : 'NO'.tr(),style: theme(context).textTheme.titleSmall!.copyWith(
        color: isDelete ? theme(context).backgroundColor : theme(context).primaryColor
      ),),

      // onPressed: () async {
      //   if(widget.isDelete) {
      //     print(widget.index);
      //     BlocProvider.of<ContactDbBloc>(context).add(DeleteFromCotactsBoxEvent(widget.index));
      //     setState(() {});
      //     // await boxList[2].deleteAt(index).then((value) => print('Success'));
      //     // ignore: use_build_context_synchronously
      //     }
      //   else{context.navigationBack(context);}
      // }, 
      );
}

