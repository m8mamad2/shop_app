// ignore_for_file: camel_case_types, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project3/src/config/localization/is_english.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:project3/src/core/common/constans/lottie.dart';
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/core/common/constans/texts.dart';
import 'package:project3/src/core/extension/navigae_extension.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:project3/src/view/main_screens/presentation/screen/details_screen.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/widget/error_bloc.dart';
import '../../../../core/widget/loading.dart';
import '../../../authenticaton_screen/presentation/screen/login_screen.dart';
import '../../domain/entities/products_entity.dart';
import 'check_out_screen.dart';

//! delay in search
// class Debouncer {
//   final int milliseconds;
//   late VoidCallback action;
//   late Timer _timer;
//   Debouncer({required this.milliseconds,});
//   run(VoidCallback action) {
//     if (null != _timer) {
//       _timer.cancel();
//     }
//     _timer = Timer(Duration(milliseconds: milliseconds), action);
//   }
// }
// final _debouncer = Debouncer(milliseconds: 500);
// onChanged: (string) {
//   _debouncer.run(() {
//     print(string);
//     //perform search here
//   }
// );



class SearchScreen extends StatefulWidget {
  bool inBottonNavbar;
  SearchScreen({super.key, required this.inBottonNavbar});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  TextEditingController controller = TextEditingController();
  List<ProductsEntity>? ulist = []; //! all data

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(ApiCallProductsEvent(endPoint: kproducts));
  }

  getSuggestion(String query) async {
    List<String> strings = ulist!.map((e) => e.title!).toList();
    List<String> matches = []; //! seggestion
    matches.addAll(strings);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme(context).primaryColor,
        leading: widget.inBottonNavbar
            ? Container()
            : IconButton(
                color: theme(context).backgroundColor,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.navigationBack(context),
              ),
      ),
      body: SafeArea(
        child: BlocConsumer<ProductsBloc, ProductsState>(
          listener: (context, state) async {if (state is SuccessProductsState) ulist = state.data;},
          builder: (context, state) {
            if (state is SuccessProductsState || state is LoadingProductsState ) {
              return SingleChildScrollView(
                child: Column(children: [
                  Stack(
                    children: [
                      //! back of serach
                      Container(
                        height: sizeH(context) * 0.24,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: theme(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )),
                      ),
                      //! search Field
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            decoration: BoxDecoration(
                                color: theme(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            width: sizeW(context) * 0.828,
                            height: sizeH(context) * 0.06,
                            child: TypeAheadField<String>(
                              // noItemsFoundBuilder: (context) => Padding(
                              //   padding: const EdgeInsets.all(20.0),
                              //   child: Text(
                              //     'sorry... not Found!'.tr(),
                              //     style: theme(context).textTheme.titleMedium!.copyWith(color: theme(context).focusColor),
                              //   ),
                              // ),
                              loadingBuilder: (context) => loading(context),
                              builder:(context, controller, focusNode) => TextField(
                                  controller: controller,
                                  style: theme(context).textTheme.titleMedium!.copyWith(color: theme(context).focusColor),
                                  decoration: InputDecoration(
                                      iconColor:theme(context).primaryColor,
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(2),
                                      hintStyle: theme(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: theme(context).focusColor,fontSize: 15),
                                      hintText: 'Search'.tr(),
                                      icon:  Padding(
                                        padding:isEnglish(context) ? EdgeInsets.only(left: sizeW(context)*0.04) : EdgeInsets.only(right: sizeW(context)*0.04),
                                        child: Icon(Icons.search,color: theme(context).focusColor,),
                                      ))),
                              suggestionsCallback: (pattern) async {
                                return await getSuggestion(pattern);
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35),
                                    child: Text(
                                      suggestion,
                                      style:theme(context).textTheme.titleMedium!.copyWith(color: theme(context).focusColor),
                                    ),
                                  ),
                                );
                              },

                              onSelected: (suggestion) {
                                controller.text = suggestion;
                                ProductsEntity data = ulist!.firstWhere((element) => element.title == suggestion);
                                context.navigation(context, DetailsScreen(data: data));
                              },
                              // suggestionsBoxDecoration:
                              //     SuggestionsBoxDecoration(
                              //         borderRadius: BorderRadius.circular(25)),
                            )),
                      )
                    
                    ],
                  ),
                  //! lottie
                  Container(
                    margin: EdgeInsets.only(top: sizeH(context)*0.18),
                    width: sizeW(context),
                    height: sizeH(context) * 0.5,
                    child: BlocProvider.of<ThemeCubit>(context).isDark ? kDarkSearchLottie : kLightSearchLottie,
                  ),
                ]),
              );
            }
            if (state is FailProductsState) return const ErrorBlocWidget();
            return const SizedBox();
          },
        ),
      ),
    );
  }

}


