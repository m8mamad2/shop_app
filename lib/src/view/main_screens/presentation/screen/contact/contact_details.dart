// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/widgets.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/main_screens/data/repo/contact_db_repo_body.dart';
import 'package:project3/src/view/main_screens/data/repo/contacts_db_helper_repo_body.dart';
import 'package:project3/src/view/main_screens/domain/entities/concats_db_entity.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/contact_db_bloc/contact_db_bloc.dart';

import '../../../../../core/common/constans/images.dart';
import '../../../../../core/common/constans/size.dart';
import '../../../../../core/common/constans/texts.dart';
import '../../../../../core/common/top_snack_bar.dart';
import 'add_concats_screen.dart';

class ContactsDetails extends StatefulWidget {
  final ContactDBEntity data;
  const ContactsDetails({super.key,required this.data});

  @override
  State<ContactsDetails> createState() => _ContactsDetailsState();
}

class _ContactsDetailsState extends State<ContactsDetails> {
  ImagePicker picker =ImagePicker();
  XFile? file;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  late final String id;
  late final TextEditingController name ;
  late final TextEditingController email ;
  late final TextEditingController age ;
  late final TextEditingController number ;
  late final TextEditingController collegeEducation;
  late final TextEditingController highSchoolEducation;
  late final List<TextEditingController> controllers;
  bool? isOld;

  @override
  void initState() {

    super.initState();
    id = widget.data.id ?? '';
    name = TextEditingController(text: widget.data.name ?? '');
    email = TextEditingController(text: widget.data.email ?? '');
    age = TextEditingController(text: widget.data.age ?? '');
    number = TextEditingController(text: widget.data.number ?? '');
    collegeEducation =TextEditingController(text: widget.data.collegeEducation ?? '');
    highSchoolEducation =TextEditingController(text: widget.data.highSchoolEducation ?? '');
    controllers =[name,email,age,number,];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: theme(context).backgroundColor,
        elevation: 0,
        leading: IconButton(onPressed: ()=> context.navigationBack(context),icon: Icon(Icons.arrow_back,color: theme(context).primaryColor,)),

      ),
      body: BlocListener<ContactDbBloc,ContactDbState>(
        listener: (context, state) {
          state is LoadingContactDBState 
            ? LoadingDialogs.show(context)
            : LoadingDialogs.hide(context);
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                sizeBoxH(sizeH(context)*0.02),
                
                SizedBox(
                      width: sizeW(context)*0.3,
                      height: sizeH(context)*0.14,
                      child: Stack(
                        children: [
                          file == null 
                          ? widget.data.image == null || widget.data.image!.isEmpty 

                              ? CircleAvatar(backgroundImage:const AssetImage(kNoProfileImage),radius: sizeW(context)*0.14,) 
                              : CircleAvatar(backgroundImage:MemoryImage(widget.data.image!),radius: sizeW(context)*0.14,)
                              
                          : CircleAvatar(backgroundImage:FileImage(File(file!.path)),radius: sizeW(context)*0.14,),
                          
                            
                        Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: sizeW(context)*0.04,
                              child: FittedBox(
                                child: IconButton(
                                  icon:const Icon(Icons.edit),
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
                  
                Text(widget.data.name ?? 'No Name' , style: theme(context).textTheme.headlineLarge!.copyWith(fontSize: 22,color: theme(context).focusColor,),),
                sizeBoxH(sizeH(context)*0.01),
                ListView.builder(
                      shrinkWrap: true,
                      itemCount: contactsTitle.length,
                      itemBuilder: (context, index) {
                        return oneItem(controllers[index], contactsTitle[index],kContactsInputType[index],kValidatorType[index]);
                      },),
                
                widget.data.collegeEducation == null  || widget.data.collegeEducation == '' ? const SizedBox.shrink() : oneItem(collegeEducation, 'College Education',TextInputType.text,'name'),
                
                widget.data.highSchoolEducation == null || widget.data.highSchoolEducation == ''? const SizedBox.shrink() : oneItem(highSchoolEducation,'High School Education',TextInputType.text,'name'),
                
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: sizeH(context)*0.02),
                    child: ElevatedButton(
                      onPressed: ()async{
                        if(formKey.currentState!.validate()){
                          
                            String id = widget.data.id!;
                            
                            ByteData defaultImageAsset= await rootBundle.load(kNoProfileImage);
                            Uint8List defaultImage = defaultImageAsset.buffer.asUint8List();
                            Uint8List? imageByte = await file?.readAsBytes();
                            Uint8List image = imageByte ?? (widget.data.image ?? defaultImage);

                            ContactDBEntity data = ContactDBEntity.fromControllers(controllers,collegeEducation,highSchoolEducation,image,id);

                            //  ContactDBRepoBody repoBody = ContactDBRepoBody();
                            //  ContactsDBHelperRepoBody repo = ContactsDBHelperRepoBody(repoBody);

                            //  await repo.updateBoxHelper(context, id, data);


                            BlocProvider.of<ContactDbBloc>(context).add(UpdateCotactsBoxEvent(id,data,context));
                            }},

                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(sizeW(context)*0.9, sizeH(context)*0.066),
                          backgroundColor: theme(context).primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        ),
                      child: Text('update'.tr())),
                  ),
                )
                    
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget oneItem (TextEditingController controller,String title,TextInputType type,String validatorType)=> 
    Padding(
    padding: EdgeInsets.symmetric(vertical: sizeH(context)*0.01),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding:EdgeInsets.symmetric(horizontal: sizeW(context)*0.09) ,
            child: Text(title.tr(),style: theme(context).textTheme.headlineLarge!.copyWith(color: theme(context).focusColor,fontSize: sizeW(context)*0.03),)),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizeW(context)*0.06,
            vertical: sizeH(context)*0.005),
          child: TextFormField(
            style: theme(context).textTheme.bodyMedium!.copyWith(fontSize: 13, color: theme(context).focusColor.withOpacity(0.8)),
            onChanged: (value) {
              int? x = int.tryParse(value);
              
              if (x != null){
  
                if(x >= 18) {setState(() {isOld = true;});}
                
                else {setState(() {isOld = false;});}
              }
  
            },
            controller: controller,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if(validatorType == 'name')  if(value!.isEmpty)return 'Please Enter Someting'.tr();
              if(validatorType == 'email') {
                if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)){return null;}
                else {return 'Please Enter Valid Email'.tr();}}
              if(validatorType == 'age') {
                int age = int.tryParse(value!) ?? 0;
                if(age > 100){return 'age shoud bee less then 100'.tr();}
                else if(age < 5){return 'age should be bigger than 5'.tr();}}
              if(validatorType == 'number')if(value!.isEmpty || RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value))return 'Please Enter Valid Number'.tr();
            
            },
            keyboardType: type,
            decoration: InputDecoration(
              fillColor: theme(context).dialogBackgroundColor,
              filled: true,
              
              contentPadding: EdgeInsets.symmetric(
                      horizontal: sizeH(context) * 0.02,
                      vertical: sizeH(context) * 0.02),
              hintStyle: theme(context).textTheme.bodyMedium!.copyWith(fontSize: 13, color: theme(context).focusColor.withOpacity(0.8)),
              hintText: title.tr(),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme(context).backgroundColor, width: 0.6),
                  borderRadius: BorderRadius.circular(15),),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme(context).backgroundColor, width: 0.6),
                  borderRadius: BorderRadius.circular(15),),
              ),
          ),
        ),
      ],
    ),
  );


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






