import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {



  void setWorldTime() async {
    WorldTime instance= WorldTime(location: 'India', flag: 'India.png' , url: 'Asia/Kolkata');
    await instance.setTime();
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location' : instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDaytime':instance.isDaytime,
    });


  }



  @override
  void initState() {
    super.initState();
    setWorldTime();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 70,),
          Image.asset('assets/globe.jpg',height:310 ,width: 310,),
          SizedBox(height: 120,),
          Text('W O R L D T I M E',
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),

          ),

          SizedBox(height: 8,),
          SpinKitFadingCircle(
            color: Colors.black,
            size: 30.0,
          ),

        ],
      ),
    );
  }
}
