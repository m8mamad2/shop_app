// import 'dart:async';

// import 'package:beamer/beamer.dart';
// import 'package:flutter/material.dart';
// import 'package:project3/src/core/widget/bottom_navigatebar_widget.dart';
// import 'package:project3/src/core/widget/drawer.dart';
// import 'package:project3/src/core/widget/offline_screen.dart';
// import 'package:project3/src/view/main_screens/presentation/screen/home_screen.dart';

// import '../common/internet_connection_chedk.dart';

// class Checker extends StatefulWidget {
//   final int? selected;
//   const Checker({super.key,this.selected});

//   @override
//   State<Checker> createState() => _CheckerState();
// }

// class _CheckerState extends State<Checker> {

//   late StreamSubscription connectionChangeStream;
//   bool isOffline=false;

//   @override
//   void initState() {
//     super.initState();
//     ConnectionStatusSingleton connectinStaus = ConnectionStatusSingleton.getInstance();
//     connectionChangeStream = connectinStaus.connectionChange.listen(connectionChanged);
//   }

//   void connectionChanged(dynamic hasConnection){setState(() {isOffline = !hasConnection;});}

//   @override 
//   Widget build(BuildContext context) => isOffline  ? const OfflineScreen(): BottomNavigationBarWidget(selected: widget.selected,);
  
// }


