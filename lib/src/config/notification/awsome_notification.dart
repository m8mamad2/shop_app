//* aswome notificaton


//! in main
//  AwesomeNotifications().initialize(
//     null,[
//       NotificationChannel(
//         channelKey: 'first', 
//         channelName: 'Sossis', 
//         channelDescription: 'Sossis is Delice')
//     ],
//     debug: true
//   );


// class MyWidget2 extends StatefulWidget {
//   const MyWidget2({super.key});

//   @override
//   State<MyWidget2> createState() => _MyWidget2State();
// }

// class _MyWidget2State extends State<MyWidget2> {

//   @override
//   void initState() {
//     AwesomeNotifications().requestPermissionToSendNotifications().then(
//       (value) {
//         if(!value)AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//         );
//     super.initState();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Center(
//         child:ElevatedButton(
//           onPressed: (){
//             AwesomeNotifications().createNotification(
//               content: NotificationContent(
//                 id: 0, 
//                 channelKey: 'first',
//                 title: "AAAh",
//                 body: 'Oh yes'
//                 ));
//           },
//           child: Text('Press'),
//         ) ,)
//     );
//   }
// }