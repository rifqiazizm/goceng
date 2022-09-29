import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/MainMenu.dart';
import '../shared/Config.dart';
import '../provider/Goceng.dart';


class HomeScreen extends StatelessWidget {
  
  final Size _mediaQ;

  HomeScreen(this._mediaQ);

  @override
  Widget build(BuildContext context) {
   
    final media = MediaQuery.of(context);
    // final user = Provider.of<User>(context);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text('Hello'),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Container(
          //     width: this._mediaQ.width * 0.5,
          //     color: Config.DJPColorPrimer,
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
              height: this._mediaQ.height  * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                
              ),
              child: Padding(
                padding: EdgeInsets.only(top: this._mediaQ.height * 0.1),
                child: Center(child: MainMenu(),),
              )
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 35),
            height: this._mediaQ.height * 0.3,
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.amber,width: 5),
              color: Config.DJPColorPrimer,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90))
            ),
            child: Consumer<Goceng>(
              builder:(ctx,goceng,child) => Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 44,
                      // backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset('assets/images/logodjp2.png'),
                        ),
                        backgroundColor: Config.DJPColorPrimer,
                        radius: 40,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goceng.namaSeksi,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        // SizedBox(height: ,),
                        Text(
                          'User Level ${goceng.userLevel}',
                          style: Theme.of(context).textTheme.headline4,
                        )
                      ]
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}