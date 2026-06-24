import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Affirmations App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Card(
                clipBehavior: .hardEdge,
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: .fitWidth,
                              image: AssetImage('assets/0.jpg')
                          )
                      )
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'I am stronger today.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    )
                  ]
                )
              ),
              Card(
                  clipBehavior: .hardEdge,
                  margin: EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: .fitWidth,
                                    image: AssetImage('assets/1.jpg')
                                )
                            )
                        ),
                        Container(
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
                            child: Text(
                              'I am grateful to wake up in my warm and cozy bed.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20
                              ),
                            )
                        )
                      ]
                  )
              ),
              Card(
                  clipBehavior: .hardEdge,
                  margin: EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: .fitWidth,
                                    image: AssetImage('assets/2.jpg')
                                )
                            )
                        ),
                        Container(
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
                            child: Text(
                              'I am worthy of love.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            )
                        )
                      ]
                  )
              ),
              Card(
                  clipBehavior: .hardEdge,
                  margin: EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: .fitWidth,
                                    image: AssetImage('assets/3.jpg')
                                )
                            )
                        ),
                        Container(
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
                            child: Text(
                              'I am aligning my will with nature.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            )
                        )
                      ]
                  )
              )
            ],
          )
        )
      )
    );
  }
}
