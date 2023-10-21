import 'package:flutter/material.dart';

extension navigate on BuildContext{
  Future navigation(BuildContext context , Widget widget)=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget,));
  void navigationBack(BuildContext context)=>Navigator.of(context).pop();
  Future navigatiomRemove(BuildContext context,Widget widget)=> Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget,), (route) => false);
}