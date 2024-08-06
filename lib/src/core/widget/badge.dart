import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/theme.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
import 'package:project3/src/core/widget/loading.dart';
import 'package:project3/src/view/main_screens/presentation/screen/cart_screen.dart';

import '../../view/main_screens/presentation/blocs/cart_db_bloc/cart_db_bloc.dart';

class BadgeWidget extends StatefulWidget {
  final Color color;
  const BadgeWidget({super.key,required this.color});

  @override
  State<BadgeWidget> createState() => _BadgeWidgetState();
}

class _BadgeWidgetState extends State<BadgeWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartDbBloc>(context).add(InitialCartDBEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: ()=> context.navigation(context, const BottomNavigateWidget(selected: 2,)), icon: Icon(Icons.shopping_bag_outlined, color: widget.color,)),
        Padding(
          padding: EdgeInsets.only(bottom: sizeW(context)*0.01,left: sizeH(context)*0.005),
          child: Align(alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 11,
              backgroundColor: theme(context).primaryColor,
              child: BlocBuilder<CartDbBloc, CartDbState>(
                builder: (context, state) {
                  if(state is LoadingCartDBState)return loading(context);
                  if(state is SuccessCartDBState){
                    int data  = state.data.length;
                    return data == 0 ? Text('0',style: testStyle,) : Text('$data',style: testStyle,);
                  }
                  if(state is FailCartDBState)return  Text('0',style: testStyle,);
                  return Container();
                },
              ),
              ),),
        )
      ],
);
  }

  TextStyle testStyle = const TextStyle(color: Colors.white);
}
