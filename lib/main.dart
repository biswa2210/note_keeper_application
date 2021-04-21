import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_keeper_app/home.dart';
void main(){
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp
   ]);*/
  runApp(
    MaterialApp(
      home: SplashScreen(),
    )
  );
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:AssetImage('assets/images/spsc.png'),
          fit: BoxFit.contain
        )
      ),
    );
  }
  Future<Timer> loadData() async{
    return new Timer(Duration(seconds: 3),onDoneLoading);
  }
  onDoneLoading() async{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyApp()));
  }
}