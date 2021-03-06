import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class SplashScreen extends StatefulWidget {


  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Position? _position;
  void _getCurrentLocation() async {
    Position position1 = await _determinePosition();
    setState(() {
      _position = position1;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child:(_position!=null) ? Text(_position.toString()):const Text("no position")),
            ElevatedButton(onPressed: (){
              _getCurrentLocation();
            }, child: Text("Get Location"))

          ],
        )


    );
  }
}