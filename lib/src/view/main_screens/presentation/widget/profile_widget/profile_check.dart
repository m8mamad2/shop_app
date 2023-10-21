import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/widget/auth_in_app.dart';
import 'package:project3/src/core/common/global_state/bloc/global_bloc.dart';
import 'package:project3/src/core/common/global_state/model/model.dart';
import 'package:project3/src/view/main_screens/presentation/screen/profile_screen.dart';


class ProfileCheckIsLogged extends StatefulWidget {
  const ProfileCheckIsLogged({super.key});

  @override
  State<ProfileCheckIsLogged> createState() => _ProfileCheckIsLoggedState();
}

class _ProfileCheckIsLoggedState extends State<ProfileCheckIsLogged> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW(context),
      height: sizeH(context),
      color: theme(context).backgroundColor,
      child: BlocBuilder<GlobalBloc,GlobalModel>(
        builder: (context,state){
            
            return state.isLoggin == true 
              ?const ProfileLoggedScreen()
              :const AuthInApp();
        },

        key: const ValueKey('profile_key'),
      ),
    );
  }
}