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
