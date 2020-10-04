import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List usersData;
  bool isLoading = true;
  final String url = "https://randomuser.me/api/?results=100";

  Future getData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "applications/json"},
    );

    List data = json.decode(response.body)['results'];

    setState(() {
      usersData = data;

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Users'),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: usersData == null ? 0 : usersData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 10.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                usersData[index]['picture']['thumbnail'],
                              ),
                              radius: 38.0,
                              // fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                ),
                                Text(
                                  usersData[index]['name']['first']
                                          .toString()
                                          .toUpperCase() +
                                      " " +
                                      usersData[index]['name']['last']
                                          .toString()
                                          .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                      color: Colors.orangeAccent,
                                      size: 14.0,
                                    ),
                                    Text(
                                      " " + usersData[index]['phone'],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.people,
                                      color: Colors.orangeAccent,
                                      size: 14.0,
                                    ),
                                    Text(
                                      " " + usersData[index]['gender'],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.orangeAccent,
                                      size: 14.0,
                                    ),
                                    Text(
                                      " " +
                                          usersData[index]['dob']['age']
                                              .toString(),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.0),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.email,
                                      color: Colors.orangeAccent,
                                      size: 14.0,
                                    ),
                                    Text(
                                      " " +
                                          usersData[index]['email'].toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
