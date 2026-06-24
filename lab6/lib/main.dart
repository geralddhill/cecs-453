import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class WeatherService {
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final apiKey = dotenv.env['API_KEY'];
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cityController = TextEditingController(text: 'Anaheim');
  final _weatherService = WeatherService();

  Map<String, dynamic>  _data = {};


  void fetchWeather() async {
    Map<String, dynamic> response = await _weatherService.fetchWeather(_cityController.text);
    setState(() {
      _data = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 5,
            children: [
              TextField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'Enter a City Name')
              ),
              ElevatedButton(onPressed: fetchWeather, child: Text('Search')),
              Padding(padding: EdgeInsets.all(15)),
              if (_data['name'] != null)
                Text(
                  _data['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: .bold
                  ),
                ),
              if (_data['weather'] != null)
                Text('Weather: ${_data['weather'][0]['main']}'),
              if (_data['main'] != null) ...[
                Text('Temperature: ${_data['main']['temp']}ºC'),
                Text('Humidity: ${_data['main']['humidity']}%'),
                Text('Pressure: ${_data['main']['pressure']} hPa')
              ]
            ],
          ),
        ),
      )
    );
  }
}
