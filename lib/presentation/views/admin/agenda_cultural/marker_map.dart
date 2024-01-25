import 'dart:async';

import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/presentation/cubits/homeCubits/home_cubit.dart';
import 'package:culturappco/presentation/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersMapPage extends StatefulWidget {
  const MarkersMapPage({super.key});

  @override
  State<MarkersMapPage> createState() => _MarkersMapPageState();
}

class _MarkersMapPageState extends State<MarkersMapPage> {

  CameraPosition inicialPosition = CameraPosition(
    target: LatLng(8.762816, -75.883065),
    zoom: 15
    );

    
   //viene de esta libreria dart:async
    Completer<GoogleMapController> mapController =Completer();
        var addessName='';
        LatLng? addressLatLng;
    Position? position;



  @override
  void initState() {
    // TODO: implement initState
    //  context.read<HomeCubit>().permisoGPS(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
          title: Text('Ubica tu dirección en el mapa'),
          leading: Builder(builder: (BuildContext context) {
            return backButton(context, Colors.white);
          })),
      body: Stack(children: [
        _googleMaps(),
         iconMapLocation(),
        carAdrresDirection(),
        Spacer(),
        buttonSelect(context)
      ]),
    );
  }

  Widget _googleMaps() {
    //retornamos googlemap de flutter
    return GoogleMap(
      //Inicia camera donde estara la posicion inicial
      initialCameraPosition: inicialPosition,
      //tipo de mapa
      mapType: MapType.normal,
      onMapCreated: onMapCreate,
      //crea un pequeño punto azul
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      
      onCameraMove: (position) {
        inicialPosition = position;
      },
       onCameraIdle: () async {
      //   //llamamos a nuestro controlador cada vez que movamos el marcador se este actualizando
         await setLocationDraggableInfo();
       },
    );
  }

  Widget iconMapLocation(){
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Center(
          child:  Image.asset('assets/images/my_location.png',
          width: 60,
          height: 60,
        ),
      ),
    );
  }

  Widget carAdrresDirection(){
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(addessName,style: TextStyle(color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold),),
          ),
      ),
    );
  }

Widget buttonSelect(BuildContext context){
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(10),
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      child: ElevatedButton(
        child: Text('SELECCIONAR ESTE PUNTO',style: TextStyle(
          color: Colors.white,
          
        ),),
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          padding: EdgeInsets.all(15)
        ),
        onPressed: ()=> seleccionarPuntoReferencia(context),

    
        ),
    );
  }
      void onMapCreate(GoogleMapController controller){
      //inicializamos
      mapController.complete(controller);
    }


     //establecer el nombre de la direccion cuando arrastramos el map
    Future setLocationDraggableInfo() async{
         double lat =inicialPosition.target.latitude;
         double long =inicialPosition.target.longitude;

       
         List<Placemark> address = await placemarkFromCoordinates(lat, long);

         if(address.isNotEmpty){
            String direction = address[0].thoroughfare ?? '';   
            String calle = address[0].subThoroughfare ?? '';
            String city = address[0].locality ?? '';
            String departamento = address[0].administrativeArea ?? '';
            String country = address[0].country ?? '';
            setState(() {
            addessName='$direction #$calle , $city, $departamento';
              
            });

            addressLatLng=LatLng(lat, long);
         }

    }

    //verificar si el gps esta activado
    void verificarGPS()async{
       bool isLocationEnable = await Geolocator.isLocationServiceEnabled();
       //si el gps esta activado actualizamos la localizacion
       if(isLocationEnable==true){
        updateLocation();
       }else{
        // bool locationGPS = await Location().requestService();
            final status = await Permission.location.request();

        if(status.isGranted){
          setState(() {
            
          });
        }
       }
    }

      void updateLocation() async{
     try{
        await _determinePosition();
        //ontenemos la longitud y latitud de nuestro dispositivo actual
        position =await Geolocator.getLastKnownPosition();
        animateCameraPosition(position!.latitude, position!.longitude);

     }catch(e){
      print('errorr==>>$e');
     }
 }

  Future<Position?> _determinePosition() async {
   bool serviceEnabled;
   LocationPermission permission;
   serviceEnabled = await Geolocator.isLocationServiceEnabled();
   if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  }

   
  //recibimos la lat and long
  Future animateCameraPosition(double lat, double lgt) async{
       GoogleMapController controller = await mapController.future;
       controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat,lgt),
        zoom: 14,
        bearing: 0
        ),
       ),
      );
  }

 

     void seleccionarPuntoReferencia(BuildContext context){

      if(addressLatLng!=null){
        Map<String,dynamic> data = {
          'address': addessName,
          'lat':addressLatLng!.latitude,
          'lng':addressLatLng!.longitude
        };
        
       Navigator.pop(context,data);
      };

    }

}


