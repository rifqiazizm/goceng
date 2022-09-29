import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../provider/Goceng.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Size media;

  @override
  void initState() {
    _loadWidget();
    super.initState();
  }


  Future<void> _loadWidget() async {
    final duration = Duration(seconds: 4);
    return Timer(duration, _navigate);
  }

  Future<void> _navigate() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('userData')) {
      final Map<String, Object> userData =
          json.decode(pref.getString('userData'));
      await Provider.of<Goceng>(context, listen: false).addUser(userData);
      print(userData);
      Navigator.of(context).pushReplacementNamed('/app');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  void didChangeDependencies() {
    this.media = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: this.media.height, 
          width: this.media.width,
          color: Color.fromRGBO(33, 43, 96, 1),
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: SizedBox(height: 10,)),
                Image.asset(
                  'assets/images/logodjp2.png',
                  height: 250,
                  width: 170,
                  fit: BoxFit.fill,          
                ),
                // Expanded(
                //   child: Center(
                //     child: Text(
                //       'KPP Pratama Jakarta Cengkareng',
                //       style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 35),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'KPP Pratama Jakarta Cengkareng',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
 