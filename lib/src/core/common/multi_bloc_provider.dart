// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/locator.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/view/authenticaton_screen/presentation/bloc/auth_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/backend_db_bloc/backend_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/cart_db_bloc/cart_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/contact_db_bloc/contact_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/favorite_db_bloc/favorite_db_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/payment_card_bloc/payment_card_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';

import 'global_state/bloc/global_bloc.dart';


Widget MultiBlocProviderConfig(Widget child) => MultiBlocProvider(providers: [
      BlocProvider<ThemeCubit>(create: (context) => locator(),),
      
      BlocProvider<AuthBloc>(create: (context) => locator(),),
      
      BlocProvider<ProductsBloc>(create: (context) => locator(),),
      
      BlocProvider<CartDbBloc>(create: (context) => locator(),),
      
      BlocProvider<FavoriteDbBloc>(  create: (context) => locator(),),
      
      BlocProvider<BackendDbBloc>(create: (context) => locator(),),

      BlocProvider<ChatBloc>(create: (context) => locator(),),

      BlocProvider<ContactDbBloc>(create: (context) => locator(),),

      BlocProvider<PaymentCardBloc>(create: (context) => locator(),),

      BlocProvider<GlobalBloc>(create: (context) => GlobalBloc(),)

    ], child: child);
