import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../shared/Config.dart';
import '../provider/Goceng.dart';
import '../widgets/STListView.dart';


class RekapSTScreen extends StatefulWidget {

  final Size _media;
  RekapSTScreen(this._media);

  @override
  _RekapSTScreenState createState() => _RekapSTScreenState();
}

class _RekapSTScreenState extends State<RekapSTScreen> {

  var _tabSelect = 'arsip';

  void _selectorTab(String tab) {
      setState(() {
        this._tabSelect = tab;
      });
  }

  

  @override
    void initState() {
      Future.delayed(Duration(milliseconds: 800)).then((value) {
        // Provider.of<Goceng>(context,listen: false).getSharedPrefsVal();
      });
      print('init berjalan');
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Config.DJPColorPrimer,
              // color: Colors.amber,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            height: this.widget._media.height * 0.20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Text(
                    'Data Surat Tugas',
                    style: Theme.of(context).textTheme.headline4),
                    
                  margin: const EdgeInsets.only(left: 24, bottom: 30),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => this._selectorTab('arsip'),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          height: widget._media.height * 0.05,
                          width: widget._media.width * 0.5,
                          // color: isKelasPajak ?  Colors.transparent : Theme.of(context).accentColor,
                          child: Text(
                            'Arsip',
                            style: GoogleFonts.roboto().copyWith(
                                color: this._tabSelect == 'arsip'
                                    ? Colors.white
                                    : Color(0xFF6F678E),
                                fontSize: 15),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: this._tabSelect == 'arsip'
                                        ? Theme.of(context).accentColor
                                        : Colors.transparent,
                                    width: 5
                                )
                            )
                              // border: Border.all(color: Theme.of(context).accentColor,width: 5)
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => this._selectorTab('rilis'),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          height: widget._media.height * 0.05,
                          width: widget._media.width * 0.5,
                          // color: this._tabSelect ?  Colors.transparent : Theme.of(context).accentColor,
                          child: Text(
                            'Rilis',
                            style: GoogleFonts.roboto().copyWith(
                                color: this._tabSelect == 'rilis'
                                    ? Colors.white
                                    : Color(0xFF6F678E),
                                fontSize: 15),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: this._tabSelect == 'rilis'
                                          ? Theme.of(context).accentColor
                                          : 
                                          Colors.transparent,
                                      width: 5
                                  )
                              )
                              // border: Border.all(color: Theme.of(context).accentColor,width: 5)
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:widget._media.height * 0.2),
            height: widget._media.height * 0.70,
            width : double.infinity,
            // color: Colors.black,
            child: STListView(this._tabSelect) ,
          )
        ],
    ),
    );
  }
}