import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // All written by Gerald Hill
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Card',
      home: Scaffold(
        // Centers widgets
        body: Center(
          // There are two main sections in this column as displayed on the assignment
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Each section is a container so I can give it a margin
              Container(
                  margin: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Image of me
                      Image(
                          image: AssetImage('assets/profile.png'),
                          height: 200,
                          width: 200
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      // Name
                      Text(
                          "Gerald Hill",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      // Title
                      Text(
                          "Flutter Developer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                      )
                    ],
                  )
              ),
              Container(
                  margin: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // All children are rows in order to align icons with text
                    children: <Widget>[
                      // Phone Number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.phone),
                          Padding(padding: EdgeInsets.all(10)),
                          Text('(123) 456-7890')
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      // Social Media (Discord)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.discord),
                          Padding(padding: EdgeInsets.all(10)),
                          Text('discord_username')
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      // Email
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.email),
                          Padding(padding: EdgeInsets.all(10)),
                          Text('Gerald.Hill01@student.csulb.edu')
                        ],
                      )
                    ],
                  )
              )
            ],
          )
        )
      ),
    );
  }
}
