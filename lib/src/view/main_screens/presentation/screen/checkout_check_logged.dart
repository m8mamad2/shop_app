import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/locator.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/auth_in_app.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/bloc/auth_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/check_out_screen.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/common/constans/size.dart';
import '../../../../core/widget/loading.dart';
import '../../../../core/common/global_state/bloc/global_bloc.dart';
import '../../../../core/common/global_state/model/model.dart';

class CheckoutCheckLogged extends StatefulWidget {
  final num total;
  const CheckoutCheckLogged({super.key,required this.total});

  @override
  State<CheckoutCheckLogged> createState() => _CheckoutCheckLoggedState();
}

class _CheckoutCheckLoggedState extends State<CheckoutCheckLogged> {

  @override
  void initState() {
    print('______________In Initial');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW(context),
      height: sizeH(context),
      color: theme(context).backgroundColor,
      child: Container(
      width: sizeW(context)*0.6,
      color: theme(context).backgroundColor,
      child: BlocBuilder<GlobalBloc,GlobalModel>(
          key: const ValueKey('checkout_key'),
          builder: (context, state) {
            print('-======== Drawer Check $state ========');
              return state.isLoggin == true
                  ? CheckOutScreen(total: widget.total,)
                  :const AuthInApp();
          },),
    )
      // BlocConsumer<AuthBloc,AuthState>(
      //   listener: (context, state) {
      //     print('__________??????$state');
      //     // state is LoadingAuthState ? LoadingDialogs.show(context):LoadingDialogs.hide(context);
      //   },
      //   builder: (context,state){
      //     print('_______++++++++$state');
      //     if(state is LoadingAuthState || state is InitialAuthState)return Center(child: loading(context),);
      //     if(state is SuccessAuthState){
      //       return state.isUserLoggedIn == true 
      //         ? CheckOutScreen(total: widget.total,)
      //         :const AuthInApp();
      //     }
      //     if(state is FailAuthState)return Text(state.error.toString());
      //     return Container(width: 100,height: 100,color: Colors.amber,);
      //   },
      // ),
    );
  }
}