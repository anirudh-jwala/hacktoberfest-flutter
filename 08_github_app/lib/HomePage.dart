import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {

  final String title;

  HomePage(
    {
      Key key,
      @required
      this.title   
    }
  ) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://api.github.com/users";

  List data;

  var isLoading = false;

  @override
  void initState() {
    super.initState();

    this.getjsondata();
  }

  Future<String> getjsondata() async {
    
    var response = await http.get(
      Uri.encodeFull(url),
    );

    // print(response.body);

    setState(() {

     var convertDatatoJson = json.decode(
       response.body
     ); 

      data = convertDatatoJson;

      // print(data);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: data != null? data.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.deepPurpleAccent,
                    size: 40.0,
                  ),
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text(
                    data[index]['login'],
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    data[index]['url'],
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  onTap: () {},
                  trailing: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}