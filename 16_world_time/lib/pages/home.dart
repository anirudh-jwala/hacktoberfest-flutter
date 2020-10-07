import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};
  
  @override
  Widget build(BuildContext context) {
    data= data.isEmpty? ModalRoute.of(context).settings.arguments:data;
    String bgimage = data['isDaytime'] ? 'day.png':'night.png';
    print(data);
    
    return Scaffold(
      body: Container(
        decoration:BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgimage'),fit: BoxFit.fill
          )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: SafeArea(

              child:Column(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic results = await Navigator.pushNamed(context,'/location');
                      setState(() {
                        data['time']=results['time'];
                        data['location']=results['location'];
                        data['flag']=results['flag'];
                        data['isDaytime']=results['isDaytime'];
                      });
                    },
                    icon: Icon(
                        Icons.location_searching,
                        color: Colors.grey[200],
                    ),
                    label: Text(
                      'Select location',
                      style: TextStyle(
                        color: Colors.grey[200]
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20),
                  Text(data['time'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 65,

                  ),)
                ],
              )),
        ),
      ),
    );
  }
}
