import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/services/location.dart';

class Networking {
  
  String AppId = "1425dacdf2c00ea150ba620bccd4828c";
  double temp = 0;
  double longitude = 0;
  double latitude = 0;
  late String data, city, description;
  int id = 0;

  Future<String> getDataWithCity(String city) async {

    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$AppId&units=metric");
    Response res = await get(url);
    data = res.body;

    if (res.statusCode == 200) {
      return data;
    } else if (res.statusCode == 400) {
      throw ErrorDescription("400-Nothing to search");
    } else if (res.statusCode == 404) {
      throw ErrorDescription("404-Not found");
    } else {
      throw ErrorDescription("${res.statusCode}-Something went wrong");
    }
  }

  Future<String> getDataWithLocation() async {

    Location location = Location();
    await location.getLocation();
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$AppId&units=metric");
    Response res = await get(url);
    data = res.body;

    if (res.statusCode == 200) {
      return data;
    } else {
      throw Exception("HTTP GET Request Failed, Status Code: ${res.statusCode}");
    }
  }
}