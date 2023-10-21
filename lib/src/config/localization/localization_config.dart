import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget EasyLocalozationConfig(Widget child,) =>
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('fa','IR'),
        child: child);

// EasyLocalization(
//     supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
//     path: 'assets/translation',
//     saveLocale: true,
//     child: 