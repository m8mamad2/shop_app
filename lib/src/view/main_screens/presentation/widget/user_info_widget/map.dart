// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocode/geocode.dart' as Gcoder;
import 'package:project3/src/core/common/constans/size.dart';
import 'package:project3/src/view/main_screens/presentation/blocs/backend_db_bloc/backend_db_bloc.dart';

import '../../../../../config/theme/theme.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}
class _MapWidgetState extends State<MapWidget> {
  PickerMapController controller = PickerMapController(initMapWithUserPosition: true);
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    return CustomPickerLocation(
      controller: controller,
      bottomWidgetPicker: Positioned(
          bottom: 15,
          right: 15,
          child: FloatingActionButton(
            backgroundColor: theme(context).primaryColor,
            onPressed:loading ? null: () async {
              
              setState(() {loading = true;});
              Gcoder.GeoCode geoCode = Gcoder.GeoCode();
              GeoPoint? p = await controller.selectAdvancedPositionPicker();

              Gcoder.Address address = await geoCode.reverseGeocoding(latitude: p.latitude, longitude: p.longitude);

              String? data = '${address.countryName ?? ''},${address.city ?? ''},${address.streetAddress ?? ''}';
              print('--------> first time$data');
              Navigator.pop(context,' $data');
              
              // Navigator.pop(context, p);
            },
            child:loading 
              ? Center(child: CircularProgressIndicator(strokeWidth: sizeW(context)*0.04,color: theme(context).backgroundColor,))
              : Icon(Icons.check,color: theme(context).backgroundColor,),
          )
          ),
      pickerConfig: CustomPickerLocationConfig(
      initZoom: 15,
      advancedMarkerPicker: MarkerIcon(
        // iconWidget: Container(color: Colors.amber,width: 10,height: 10,),
        icon: Icon(Icons.location_on_rounded,size: sizeW(context)*0.2,color: theme(context).primaryColor,),
      )),
    );
  }
}

// class ChoeseMapWidget extends StatefulWidget {
//   const ChoeseMapWidget({super.key});

//   @override
//   State<ChoeseMapWidget> createState() => _ChoeseMapWidgetState();
// }
// class _ChoeseMapWidgetState extends State<ChoeseMapWidget> {

//   late GeoPoint geoPoint;
//   var country,city,street;
//   Gcoder.GeoCode geoCode = Gcoder.GeoCode();

//   @override
//   void initState() {
//     geoPoint = GeoPoint(latitude: 0.0, longitude: 0.0);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: ()async{
//         GeoPoint p = await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const MapWidget(),));
        
//         Gcoder.Address address = await geoCode.reverseGeocoding(latitude: p.latitude, longitude: p.longitude);
//         setState(() {
//           city = address.city;
//           country = address.countryName;
//           street = address.streetAddress;
//         });
//         BlocProvider.of<BackendDbBloc>(context).add(UpdateUserInfoDataBackendDBEvent(context, 'address', '$country,$city,$street')
//         );
//         setState(() {});
//       },
//     );
//   }
// }