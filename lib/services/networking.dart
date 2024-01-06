import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/services/location.dart';
class Networking{
  double temp=0;
    String data='', city='', description='';
    int id=0;
    String appID = '1425dacdf2c00ea150ba620bccd4828c';

  Future<String> getData() async {
    Location location = new Location();
    location.getLocation();
    double lat = location.lat;
    double lon = location.lon;

    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appID&units=metric");
    Response response = await get(url);
    print('hatdog');
    data = response.body;
    if (response.statusCode == 200){
      return data;
    }else{
      return "Error";
    }
  }
}