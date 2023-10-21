import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3/src/config/theme/cubit_changer/theme_cubit.dart';
import 'package:shimmer/shimmer.dart';

Widget cachedImageWidget( BuildContext context, String imageUrl, double width, double height) {
  ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

  return CachedNetworkImage(
    key: UniqueKey(),
    imageUrl: imageUrl,
    width: width,
    height: height,
    placeholder: (context, url) => Shimmer.fromColors(
      baseColor: theme.isDark ? Colors.black54 : Colors.white54,
      highlightColor: theme.isDark ? Colors.white70 : Colors.black87,
      child: Container(
        color: Colors.white10,
      ),
    ),
  );
}
