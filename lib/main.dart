import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP8266 SG90 Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ESP8266 SG90 Control'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPressed = false;

  _sendRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  _onPressed() async {
    setState(() {
      _isPressed = true;
    });
    _sendRequest('http://192.168.1.100/on');
  }

  _onReleased() {
    setState(() {
      _isPressed = false;
    });
    _sendRequest('http://192.168.1.100/off');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Press and hold the button to turn the motor on:',
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTapDown: (TapDownDetails details) => _onPressed(),
              onTapUp: (TapUpDetails details) => _onReleased(),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: _isPressed ? Colors.blue[700] : Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'ON',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
