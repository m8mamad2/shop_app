import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:project3/src/core/common/constans/texts.dart';

class ApiProvider {
  final Dio dio = Dio();

  Future callApi(String endPoint) async {
    Response respone = await dio.get(apiUri + endPoint);
    return respone;
  }
}


// بلوار جوان، از سمت میدان عالم به سمت میدان دانش‌آموز، روبروی اولین بریدگی، مجتمع جوان، واحد ۳
// ساعت کاری: شنبه، دوشنبه، چهارشنبه از ساعت ۹ تا ۱۷