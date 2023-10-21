import 'package:flutter/material.dart';

double sizeH(BuildContext context) => MediaQuery.of(context).size.height;
double sizeW(BuildContext context) => MediaQuery.of(context).size.width;

SizedBox sizeBoxH(double height) => SizedBox(height: height);
SizedBox sizeBoxW(double width) => SizedBox(width: width);
