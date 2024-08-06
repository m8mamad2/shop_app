// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/icons.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/src/core/common/constans/widgets.dart';
import 'package:project3/src/core/common/top_snack_bar.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/contact_db_bloc/contact_db_bloc.dart';

import '../../../../../core/common/constans/texts.dart';


class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}
class _AddContactScreenState extends State<AddContactScreen> {
  ImagePicker picker = ImagePicker();
  XFile? file;
  bool? isOld;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme(context).backgroundColor,
        leading: IconButton(onPressed: ()=> {context.navigationBack(context),for (var controller in contactsControllers) controller.clear()}, 
        icon: Icon(Icons.arrow_back,color: theme(context).primaryColor,)),
        ),
      body: BlocListener<ContactDbBloc,ContactDbState>(
        listener: (context, state) => state is LoadingContactDBState ? LoadingDialogs.show(context) : LoadingDialogs.hide(context),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizeBoxH(sizeH(context)*0.02),
          
                //! image
                SizedBox(
                  width: sizeW(context)*0.3,
                  height: sizeH(context)*0.14,
                  child: Stack(
                    children: [
                      file != null 
                        ? CircleAvatar(
                          backgroundColor: theme(context).dialogBackgroundColor,
                          backgroundImage: FileImage(File(file!.path)),
                          radius: sizeW(context)*0.15,)
                        : CircleAvatar(
                          backgroundColor: theme(context).dialogBackgroundColor,
                          radius: sizeW(context)*0.15,
                          child: const Icon(Icons.question_mark),),
          
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: sizeW(context)*0.04,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: FittedBox(
                            child: IconButton(
                              icon:Icon(Icons.edit,color: Theme.of(context).canvasColor,),
                              onPressed: ()async{
                                showModalBottomSheet(
                                  shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                                  context: context, 
                                  builder:(context) => Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: theme(context).dialogBackgroundColor,
                                      borderRadius:const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )

                                    ),
                                    height: sizeH(context)*0.18,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              choeseImage(Icons.camera, 'Camera',true),
                                              choeseImage(Icons.image, 'Galley',false),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                ), );
                                
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  ),
          
          
                sizeBoxH(sizeH(context)*0.05),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: contactsTitle.length,
                  itemBuilder: (context, index) {

                    return oneItem(contactsControllers[index], contactsTitle[index],kContactsInputType[index],kValidatorType[index],kAddContactsIcon[index]);
                  },),
          
                isOld == null 
                  ? const SizedBox.shrink()
                  : isOld == true 
                    ? oneItem(collegeEducation,   'College Education',TextInputType.text,'name',Icons.cast_for_education)
                    : oneItem(highSchoolEducation,'High School Education',TextInputType.text,'name',Icons.cast_for_education),
          
          
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.03),
                    child: ElevatedButton(
                      onPressed: ()async{
                        if(formKey.currentState!.validate()){

                        Uint8List? imageByte = await file?.readAsBytes(); 
                        ContactDBEntity data = ContactDBEntity.fromControllers(contactsControllers,collegeEducation,highSchoolEducation,imageByte,null);
                                
                        BlocProvider.of<ContactDbBloc>(context).add(AddToCotactsBoxEvent(data,context));
                        for (var controller in contactsControllers) controller.clear();
                        
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(sizeW(context)*0.9, sizeH(context)*0.07),
                        backgroundColor: theme(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      child: Text('Create'.tr(),style: TextStyle(color: Theme.of(context).canvasColor),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget oneItem (TextEditingController controller,String title,TextInputType type,String validatorType,IconData icon){ 

    OutlineInputBorder border =OutlineInputBorder( borderSide: BorderSide(color: theme(context).backgroundColor, width: 0.6), borderRadius: BorderRadius.circular(15),);
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: sizeH(context)*0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding:EdgeInsets.symmetric(horizontal: sizeW(context)*0.09) ,
            child: Text(title.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: sizeW(context)*0.03),)),
          
          Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeW(context)*0.06,vertical: sizeH(context)*0.005),
          child: TextFormField(
            onChanged: (value) {
              int? x = int.tryParse(value);
              
              if (x != null){
    
                if(x >= 18) {setState(() {isOld = true;});}
                
                else {setState(() {isOld = false;});}
              }
    
            },
            style: theme(context).textTheme.bodyMedium!.copyWith(fontSize: 13, color: theme(context).focusColor.withOpacity(0.8)),
            controller: controller,
            textInputAction: TextInputAction.next,
            keyboardType: type,
            maxLines: 1,
            validator: (value) {
    
              if(validatorType == 'name')  if(value!.isEmpty)return 'Please Enter Someting'.tr();
              
              if(validatorType == 'email') {
                if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)){return null;}
                else {return 'Please Enter Valid Email'.tr();}}

              if(validatorType == 'age') {
                int age = int.tryParse(value!) ?? 0;
                if(age > 100){return 'age shoud bee less then 100'.tr();}
                else if(age < 5){return 'age should be bigger than 5'.tr();}}
                
              if(validatorType == 'number')if(value!.isEmpty || RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value) || value.length > 12)return 'Please Enter Valid Number'.tr();
            
            },
            decoration: InputDecoration(
              fillColor: theme(context).dialogBackgroundColor,
              errorStyle: theme(context).textTheme.titleSmall!.copyWith(fontSize: sizeW(context)*0.03,color: theme(context).primaryColor),
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: sizeH(context) * 0.02,vertical: sizeH(context) * 0.02),
              hintStyle: theme(context).textTheme.bodyMedium!.copyWith(fontSize: 13, color: theme(context).focusColor.withOpacity(0.8)),
              hintText: title.tr(),
              prefixIcon: Icon(icon),
              border: InputBorder.none,
              focusedBorder: border,
              enabledBorder: border,
              errorBorder: border,
              focusedErrorBorder: border
              ),
          ),
      ),
        ],
      ),
    );
    }


  Widget choeseImage(IconData icon,String title,bool isCamera){
    return InkWell(
      onTap: ()async{
          XFile? image = await picker.pickImage(source:isCamera ?  ImageSource.camera : ImageSource.gallery);
          setState(() {
            if(image != null) {file = image;}
            else {showSnackBarOnTop(context, 'Choese Image one again ...'.tr());}
          });
          context.navigationBack(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,size: sizeH(context)*0.045,),
          sizeBoxH(8),
          Text(title.tr(),style: theme(context).textTheme.titleMedium,)
        ],
      ),
    );
  }

}
