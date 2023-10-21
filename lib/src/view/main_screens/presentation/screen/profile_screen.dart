
// ignore_for_file: use_build_context_synchronously



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/icons.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/core/common/global_state/bloc/global_bloc.dart';
import 'package:project3/src/core/common/global_state/model/model.dart';
import 'package:project3/src/view/main_screens/presentation/widget/profile_widget/profile_on_taps.dart';

import '../widget/profile_widget/profile_image_widget.dart';
import '../widget/profile_widget/profile_one_item_widget.dart';
 

class ProfileLoggedScreen extends StatefulWidget {
  const ProfileLoggedScreen({super.key});

  @override
  State<ProfileLoggedScreen> createState() => _ProfileLoggedScreenState();
}
class _ProfileLoggedScreenState extends State<ProfileLoggedScreen> {
  ImagePicker picker = ImagePicker();
  XFile? imageFile;
  bool isSwitched = false;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme(context).backgroundColor,
      body: BlocBuilder<GlobalBloc,GlobalModel>(
      builder: (context, state) {
          return Column(
            children: [
              sizeBoxH(sizeH(context)*0.1),
              ProfileImageWidget(
                picker: picker,
                image: state.image,
                name: state.name,
                isDrawer: true,
                height: sizeH(context)*0.155,
                color: theme(context).focusColor,
                fontSize: 22,),
              sizeBoxH(sizeH(context)*0.07),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  VoidCallback onTaps = ProfileScreenOnTaps.onTaps(context, index,state.name??'',);
                  return ProfileOneItemWidet(context: context, title: kProfileTitle[index], icon: kProfileIcons[index], onTap: onTaps);
                },),
              ProfileOneItemWidet(context: context, title: 'Dark Mode', icon: Icons.nightlight_round, onTap: () => changeThemeBottomShet(),)
            ],
          );
        }
      )
    );
  }
       changeThemeBottomShet(){
        ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context,listen: false);
        return showModalBottomSheet(
              shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20),)),
              context: context,
              enableDrag: false,
              builder: (context) => Container(
                decoration: BoxDecoration(
                  color: theme(context).canvasColor,
                  borderRadius:const BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20),)
                ),
                height: sizeH(context) * 0.14,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical:sizeH(context)*0.04,horizontal: sizeW(context)*0.07),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Dark Mode'.tr(),
                              style: theme(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 17,color:theme(context).focusColor ),
                            ),
                          ),
                          // ElevatedButton(onPressed: (){}, child: const Text('Change'))
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                              isSwitched = value;
                              themeCubit.changeTheme();
                              });
                              // setState(() {
                              //   isSwitched = value;
                              //   BlocProvider.of<ThemeCubit>(context).changeTheme();
                              // });
                              Navigator.of(context).pop();
                            },
                            activeTrackColor: theme(context).primaryColor,
                            activeColor: theme(context).primaryColorDark,
                          ),
                        ]),
                  ),
                ),
              ),
            ); 
}
 
}