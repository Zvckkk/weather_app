import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/utilities/constant.dart';
import 'dart:convert';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data,{super.key});
  String data;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp=0;
  String city='', info='', weathericon='', weathermessage='';
  int id =0;

  @override
  void initState() {
    super.initState();
    info =  widget.data;
    updateUI();
  }

  void updateUI(){
    city =  jsonDecode(info)['name'];
    id = jsonDecode(info)['id'];
    temp = jsonDecode(info)['main']['temp'];
    print(temp);
    print(city);
    print(id);

    WeatherModel weatherModel = new WeatherModel();
    weathericon = weatherModel.getWeatherIcon(id);
    weathermessage = weatherModel.getMessage(temp.toInt());


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String newcity;
                      newcity = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      print(newcity);
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.toStringAsFixed(0) + '°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermessage in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

