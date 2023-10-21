import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/bloc/auth_bloc.dart';
import 'package:project3/src/core/common/global_state/bloc/global_bloc.dart';
import 'package:project3/src/core/common/global_state/model/model.dart';
import 'package:project3/src/view/main_screens/presentation/widget/drawer_widget/drawer_logged_user.dart';
import 'package:project3/src/view/main_screens/presentation/widget/drawer_widget/drawer_login_in_app.dart';
class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW(context)*0.6,
      color: theme(context).backgroundColor,
      child: BlocBuilder<GlobalBloc,GlobalModel>(
          key: const ValueKey('drawer_key'),
          builder: (context, state) {
            print('-======== Drawer Check $state ========');
              return state.isLoggin == true
                  ?const DrawerLoggedUser()
                  :const DrawerLoginInApp();
          },),
    );
  }
}