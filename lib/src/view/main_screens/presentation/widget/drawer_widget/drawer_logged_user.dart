
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/check_connecition.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/authenticaton_screen/data/repo/auth_repo_body.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/bloc/auth_bloc.dart';
import 'package:project3/src/core/common/global_state/bloc/global_bloc.dart';
import 'package:project3/src/core/common/global_state/model/model.dart';
import 'package:project3/src/core/common/global_state/repo/repo.dart';
import 'package:project3/src/view/main_screens/presentation/widget/profile_widget/profile_image_widget.dart';

import '../../../../../core/animation/staggred_animation/list_view_animation.dart';
import '../../../../../core/common/constans/icons.dart';
import '../../../../../core/common/constans/size.dart';
import '../../../../../core/common/constans/texts.dart';
import '../../../../../core/common/constans/widgets.dart';
import '../../blocs/backend_db_bloc/backend_db_bloc.dart';
import 'drawer_one_item_widget.dart';

class DrawerLoggedUser extends StatefulWidget {
  const DrawerLoggedUser({super.key});

  @override
  State<DrawerLoggedUser> createState() => _DrawerLoggedUserState();
}
class _DrawerLoggedUserState extends State<DrawerLoggedUser> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: sizeW(context)*0.6,
        child: Container(
          height: double.infinity,
          width: sizeW(context)*0.6,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
                          theme(context).primaryColor,
                          theme(context).primaryColor,
                          theme(context).primaryColor.withOpacity(0.4),
                        ], 
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight
                        )
          ),
          child: Column(
            children: [ 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Align(alignment: isEnglish(context) ? Alignment.topRight:Alignment.topLeft,
                  //   child: IconButton(
                  //     onPressed:()=> Scaffold.of(context).openDrawer(), 
                  //     icon:Icon(Icons.close,color: theme(context).canvasColor,))),
                  sizeBoxH(sizeH(context)*0.04),
                  BlocBuilder<GlobalBloc,GlobalModel>( 
                    builder: (context, state) {
                        return ProfileImageWidget(
                          image: state.image,
                          name: state.name,
                          isDrawer: true,
                          height: sizeH(context)*0.13,
                          color: theme(context).backgroundColor,
                          fontSize: sizeW(context)*0.05,
                        );
                    },
                  ),
                  Divider(color: theme(context).backgroundColor,thickness: 0.5),
                  sizeBoxH(sizeH(context)*0.03)

                ],
              ),
              
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder:(context, index) { 
                      return ListViewAnimatinoWidget(
                      index: index,
                      child: drawerOneItmeWidget(
                        context,
                        kDrawerIcons[index],
                        kDrawerTitle[index],
                        kDrawerWidgets[index],
                        index
                      ),
                    );}),
                )),
              Divider(color: theme(context).backgroundColor,thickness: 0.5),
              Padding(
                padding: EdgeInsets.only(bottom: sizeH(context)*0.015,right: isEnglish(context) ? sizeW(context)*0.25:0, left: isEnglish(context) ?0:sizeW(context)*0.25),
                child: OutlinedButton.icon(
                  onPressed: ()async =>await logout(),
                    // BlocProvider.of<AuthBloc>(context).add(LogOutAuthEvent(context: context)),

                  style: ElevatedButton.styleFrom(
                      side:  BorderSide(color:theme(context).backgroundColor,width: 1.4),
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))),
                  icon: Icon(Icons.logout,color: theme(context).backgroundColor.withOpacity(0.5),), 
                  label: Text('log out'.tr(),style: theme(context).textTheme.titleMedium!.copyWith(color: theme(context).backgroundColor),)),
              )
            ],
          ),
        ),
      ),
    );
  }
 Future logout()async{
    AuthRepoBody repo = AuthRepoBody();
    try{
      await repo.logOut()
        .then((value) async {
          Scaffold.of(context).closeDrawer();
          GlobalRepo repo = GlobalRepo(context: context);
          await repo.delete();
          });
    }
    on AppwriteException catch(e){print(e);return Scaffold.of(context).closeDrawer();}
    catch(e){print(e); return Scaffold.of(context).closeDrawer();}
  }

}


