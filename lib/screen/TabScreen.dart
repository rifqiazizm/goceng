import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../screen/RekapSTScreen.dart';
import '../provider/Goceng.dart';
import '../screen/HomeScreen.dart';
import '../shared/Config.dart';

class TabScreen extends StatefulWidget {


  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {


  var _isInit = true;
  int _bottomNavbarIndex;
  PageController _pageController;
  Size _mediaQ;

  @override
    void initState() {
      this._bottomNavbarIndex = 0;
      
      this._pageController = PageController(initialPage: this._bottomNavbarIndex);
      Provider.of<Goceng>(context,listen: false).fetchST();
      Provider.of<Goceng>(context,listen: false).fetchMobilDinas();
      super.initState();
    }

  @override
    void didChangeDependencies() {
      if(this._isInit == true) {
        this._mediaQ = MediaQuery.of(context).size;
        this._isInit = false;
      }

      super.didChangeDependencies();
    }

  void _onPageChange(int pageInd) {
    setState(() {
      this._bottomNavbarIndex = pageInd;
            
    });
  }

  void _selectIndex(int index) {
    setState(() {
      this._bottomNavbarIndex = index;
      this._pageController.jumpToPage(index);      
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.yellow,),
          SafeArea(
            child: Container(
              // color: Color(0xFFF6F7F9),
              color: Colors.white,
              // color: Color.fromRGBO( 249, 249, 249 , 100)
            ),
          ),
          PageView(
            controller: this._pageController,
            onPageChanged: (ind) {
              setState(() {
                this._bottomNavbarIndex = ind;
              });
            },
            children: <Widget>[
              HomeScreen(this._mediaQ),
              RekapSTScreen(this._mediaQ)
            ],
          ),
 
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(10),
              height: 65,
              child: BottomNavigationBar(
                iconSize: 27, 
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.amber[700],
                backgroundColor: Colors.transparent,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                // unselectedLabelStyle: GoogleFonts.openSans().copyWith(
                //   letterSpacing: 2
                // ),
                unselectedLabelStyle: TextStyle(
                  letterSpacing: 2,
                  fontSize: 13
                ),
                onTap: this._selectIndex,
                currentIndex: this._bottomNavbarIndex,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_sharp),
                    label: 'Rekap ST'
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Config.DJPColorPrimer,
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
            ),
          )
        ],
      ),
      
    );
  }
}