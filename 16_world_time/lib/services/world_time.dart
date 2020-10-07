import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String time;
  String location;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({
    this.location,this.url,this.flag
});



  Future<void> setTime() async
  {
    try {
      Response response1 = await get('http://worldtimeapi.org/api/timezone/$url');
      Map timedata = jsonDecode(response1.body);

      String datetime = timedata['datetime'];
      String offset = timedata['utc_offset'];
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset.substring(1, 3)),
          minutes: int.parse(offset.substring(4, 6))));
      isDaytime=now.hour>6 && now.hour<20 ? true:false;
      time=DateFormat.jm().format(now);
    }

    catch(e){
      print('Exception found: $e');
      time='''can't fetch time from server''';
    }

  }





}

