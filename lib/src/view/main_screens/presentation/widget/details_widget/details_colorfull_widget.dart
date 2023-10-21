// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/localization/is_english.dart';
import '../../../../../core/common/constans/size.dart';
import '../../../domain/entities/products_entity.dart';

// ignore: must_be_immutable
class DetailsColorFullWidget extends StatefulWidget {
  Color dataColor;
  ProductsEntity? data;
  BuildContext context;
  DetailsColorFullWidget({
    Key? key,
    required this.dataColor,
    required this.data,
    required this.context,
  }) : super(key: key);

  @override
  State<DetailsColorFullWidget> createState() => _DetailsColorFullWidgetState();
}

class _DetailsColorFullWidgetState extends State<DetailsColorFullWidget> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<FavoriteBloc>(context).add(LoadFavoriteDbEvent());
  }

  @override
  Widget build(BuildContext context) {
    // ProductsHiveModel hiveModel = ProductsHiveModel(
    //   title: widget.prd!.title,
    //   size: widget.prd!.size,
    //   price: widget.prd!.price,
    //   image: widget.prd!.image,
    //   id: widget.prd!.id,
    //   description: widget.prd!.description,
    //   colors: widget.prd!.colors,
    //   color: widget.prd!.color,
    //   IRdescription: widget.prd!.IRdescription,
    //   howmuch: widget.prd!.howmuch);
    return Container(
      decoration: BoxDecoration(
          color: widget.dataColor,
          borderRadius: isEnglish(context)
              ? const BorderRadius.only(bottomLeft: Radius.circular(100))
              : const BorderRadius.only(bottomRight: Radius.circular(100))),
      width: sizeW(context) * 0.52,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // BlocBuilder<FavoriteBloc, FavoriteState>(
              //   builder: (context, state) {
              //     if(state is LoadingFavoriteState)return loading(Theme.of(context).primaryColorLight);
              //     if(state is SuccessFavoriteState){
              //       bool isFavoriteState = state.Favoritebox!.containsKey(widget.data!.id);
              //       return IconButton(
              //         onPressed: (){
              //             setState(() {isFavoriteState = !isFavoriteState;});

              //             isFavoriteState
              //               ? boxList[1].put(hiveModel.id, hiveModel)
              //               : BlocProvider.of<FavoriteBloc>(context).add(RemoveFavoriteDbEvent(widget.index));
              //         },

              //         icon: Icon(state.Favoritebox!.containsKey(widget.data!.id)?
              //         Icons.favorite : Icons.favorite_border_outlined,
              //         color: Theme.of(context).scaffoldBackgroundColor,
              //         )
              //       );
              //     }
              //     if(state is FailFavoriteState)return Text(state.fail!);
              //     return const Text('data');
              //   },
              // ),
              // badge(
              //     context,
              //     Icon(
              //       Icons.shopping_cart,
              //       color: Theme.of(context).scaffoldBackgroundColor,
              //     ))
            ],
          ),
          SizedBox(
            height: sizeH(context) * 0.06,
          ),
          Align(
            alignment: isEnglish(context)
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                widget.data!.title!,
                style: const TextStyle(color: Colors.white24, fontSize: 35),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isSelect = false;
}
