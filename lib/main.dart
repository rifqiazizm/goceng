import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './provider/Goceng.dart';
import './screen/LaporanSTScreen.dart';
import './screen/ApproveSTScsreen.dart';
import './screen/NotYetDeveloped.dart';
import './screen/FormSTScreen.dart';
import './screen/MobilDinasScreen.dart';
import './screen/LoginScreen.dart';
import './screen/SplashScreen.dart';
import './screen/STDetailScreen.dart';
import './screen/TabScreen.dart';


void main() { 
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Goceng())

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.amber,
          fontFamily: 'Lato',
          textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                // letterSpacing: 2
                
            ),
            headline5: GoogleFonts.openSans().copyWith(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2.5
            ),
            headline4: GoogleFonts.openSans().copyWith(
              fontSize: 15,
              color: Colors.grey[400],
              letterSpacing: 3.5,
              fontWeight: FontWeight.bold
            )
            
          ),
        ),
        initialRoute: '/',
        routes: {
          '/' : (ctx) => SplashScreen(),
          '/app' : (ctx) => TabScreen(),
          '/login' : (ctx) => LoginScreen(),
          '/buatST' : (ctx) => FormSTScreen(),
          '/detail-st' : (ctx) => STDetailScreen(),
          '/mobil' : (ctx) => MobilDinasScreen(),
          '/laporan' : (ctx) => LaporanSTScreen(),
          '/approve' : (ctx) => ApproveSTScreen(),
          '/tes' : (ctx) => NotYetDeveloped()
        },
      ),
    );
      
      // home: MyHomePage(title: 'Flutter Demo Home Page'),

  }
}
