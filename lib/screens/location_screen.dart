import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  var temperature;
  var weatherIcon;
  var weatherMessage;
  var cityName;
  var tempPercebida;
  var minima;
  var maxima;
  var umidade;
  var vento;
  // var chuva;
  var nuvens;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = '-';
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        tempPercebida = '';
        minima = '';
        maxima = '';
        umidade = '';
        vento = '';
        // chuva = '';
        nuvens = '';
        return;
      }
      temperature = weatherData['main']['temp'].toInt();
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      tempPercebida = weatherData['main']['feels_like'].toInt();
      minima = weatherData['main']['temp_min'].toInt();
      maxima = weatherData['main']['temp_max'].toInt();
      umidade = weatherData['main']['humidity'];
      vento = weatherData['wind']['speed'];
      //chuva = weatherData['rain']['1h'];
      nuvens = weatherData['clouds']['all'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Sensação Térmica: ',
                      style: kTextSecundario,
                    ),
                    Text(
                      '$tempPercebida°',
                      style: kTextStyleSecundario,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Min: ',
                      style: kTextSecundario,
                    ),
                    Text(
                      '$minima°',
                      style: kTextStyleSecundario,
                    ),
                    Text(
                      '   Max: ',
                      style: kTextSecundario,
                    ),
                    Text(
                      '$maxima°',
                      style: kTextStyleSecundario,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Umidade: ',
                      style: kTextSecundario,
                    ),
                    Text(
                      '$umidade%',
                      style: kTextStyleSecundario,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Vel. do vento: ',
                      style: kTextSecundario,
                    ),
                    Text(
                      '$vento m/s',
                      style: kTextStyleSecundario,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 15.0),
              //   child: Row(
              //     children: <Widget>[
              //       Text(
              //         'Vol. de Chuva (1h): ',
              //         style: kTextSecundario,
              //       ),
              //       Text(
              //         '$chuva mm',
              //         style: kTextStyleSecundario,
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Nebulosidade: ',
                      style: kTextSecundario,
                    ),
                    Text(
                      '$nuvens %',
                      style: kTextStyleSecundario,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in ' + cityName + '!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
