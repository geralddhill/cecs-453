import 'package:flutter/material.dart';

typedef Piece = ({
  String path,
  String title,
  String artist,
  int year
});

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Art Gallery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Piece> _pieces = [
    (
      path: 'assets/starry_night.jpeg',
      title: "Starry Night",
      artist: "Vincent van Gogh",
      year: 1889
    ),
    (
      path: "assets/water_lilies.png",
      title: "Water Lilies",
      artist: "Claude Monet",
      year: 1906
    ),
    (
    path: "assets/kahlo_portrait.jpg",
    title: "Self-Portrait with Thorn Necklace and Hummingbird",
    artist: "Frida Kahlo",
    year: 1940
    ),
    (
    path: "assets/picasso_mandolin.jpg",
    title: "Girl with a Mandolin (Fanny Tellier)",
    artist: "Pablo Picasso",
    year: 1910
    )
  ];
  int _index = 0;

  void _incrementCounter() {
    setState(() {
      _index++;
      if (_index >= _pieces.length) {
        _index = 0;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      _index--;
      if (_index < 0) {
        _index = _pieces.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: Image(
                  image: AssetImage(_pieces[_index].path),
                  fit: BoxFit.contain
              )
            ),
            Padding(padding: EdgeInsets.all(20)),
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: 300,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: .start,
                children: <Widget>[
                  Text(
                    _pieces[_index].title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: .w500
                    ),
                    textAlign: .left,
                  ),
                  Text("${_pieces[_index].artist} (${_pieces[_index].year})")
                ]
              )
            ),
            Padding(padding: EdgeInsets.all(20)),
            Container(
              child: Row(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton(onPressed: _decrementCounter, child: Text("Previous")),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Container(
                    width: 150,
                    child: ElevatedButton(onPressed: _incrementCounter, child: Text("Next")),
                  )
                ],
              )
            )
          ]
        )
      )
    );
  }
}
