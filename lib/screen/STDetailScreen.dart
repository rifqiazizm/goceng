import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:goceng/shared/Config.dart';
import 'package:goceng/widgets/KendaraanDialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/BookingMobilDialog.dart';
import '../provider/Goceng.dart';

class STDetailScreen extends StatefulWidget {
  const STDetailScreen({ Key key }) : super(key: key);

  @override
  _STDetailScreenState createState() => _STDetailScreenState();
}

class _STDetailScreenState extends State<STDetailScreen> {

  var _isLoading = false;
  String kendaraan;


  @override
    void initState() {
      Future.delayed(Duration(milliseconds: 800)).then((value) {
        // Provider.of<Goceng>(context,listen: false).getSharedPrefsVal();
      });
      print('init berjalan');
      super.initState();
    }

  Future<void> _showDialog(int id) async {
    showDialog(
      context: context, 
      builder: (ctx) => BookingMobilDialog()
    ).then((mobilId) {
      if(mobilId != null) {
        setState(() {
          this._isLoading = true;
        });
        return Provider.of<Goceng>(context,listen: false).addMobilDinas(id, mobilId);
      } else {
        return {};
      }
    }).then((value) {
      final res = value as Map<String,Object>;
      if(res['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res['kata']),
          padding: const EdgeInsets.all(10),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,

        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res['kata']),
          padding: const EdgeInsets.all(10),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,

        ));
      }
      setState(() {
        this._isLoading = false;        
      });
    });
  }

  void _showKendaraan(int id) {
    showDialog(
      context: context, 
      builder: (ctx) => Kendaraan(id: id));
  } 


  Widget _renderBox(IconData icon,String title,double size) => Container(
      padding: const EdgeInsets.all(15),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color:  Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,color: Colors.grey,size: 35,),
          Text(
           title,
            style: TextStyle(color: Colors.grey,fontSize: size),
          )
        ],
      ),
    );

  Widget _rowData(String title,String subtitle,Size media) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      
      Text(
        title,
        style: this._styleTitle(),
      ),
      Container(
        alignment: Alignment.centerRight,
        width: media.width * 0.4,
        child: Text(
          subtitle,
          softWrap: true,
          style: this._stylesub(),
          textAlign: TextAlign.right,

        ),
      ),
    ],
  );

  TextStyle _styleTitle() => TextStyle(
    fontSize: 18,
    color: Colors.black,
    letterSpacing: 2,
  );

  TextStyle _stylesub() => TextStyle(
    fontSize: 15,
    color: Colors.grey,
    letterSpacing: 1.5
  );

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final id = ModalRoute.of(context).settings.arguments as Map<String,Object>;
    print('ini id nya    '+id['id'].runtimeType.toString());
    final st = Provider.of<Goceng>(context).getDetailST(id['id']);
    final peserta = st['namaPeserta'] as String;
    final tglST = st['tglmulaiST'] as String;
    final released = st['released'] as int;
    final transport = st['transport'] as int;
    final tanggal = DateTime.parse(tglST);
    final bulan = DateFormat('MMM').format(tanggal);
    final hari = tanggal.day;
    final pegawai = peserta.split(",");
    final mobil = Provider.of<Goceng>(context).getSingleMobil(st['mobildinas_id'] as int);
    // final length = peserta.split(",").length;
    final kendaraan = transport == 1 ? 'Yes' : 'No';
    // final kendaraan = 'yes';
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: media.height * 0.15,horizontal: 20),
            // color:  Color(0xFFF6F7F9),
            // color: Colors.grey,
          color: Color(0xFFDCEEF3),
          // color: Color(0xFFC9CCD5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: media.width * 0.8,
                child: Text(
                  st['agendaST'].toString(),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 35,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),

              ),
              SizedBox(height: 15,),
              Container(
                alignment: Alignment.center,
                width: media.width * 0.8,
                 child: Text(
                  st['alamatST'].toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
             
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: media.height * 0.6,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
              ),
              child: ListView(
                padding: const EdgeInsets.all(15 ),
                children: [
                  Text(
                    'Detail Surat Tugas',
                    style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
                  ),
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      this._renderBox(Icons.person, pegawai.length.toString(), 20),
                      this._renderBox(Icons.calendar_today_outlined, '${bulan.toString()} , ${hari.toString()}', 16),
                      InkWell(
                        onTap: () => this._showKendaraan(st['mobildinas_id']),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color:  Color(0xFFF6F7F9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.car_rental,color: Colors.grey,size: 35,),
                              Text(
                                kendaraan,
                                style: TextStyle(color: Colors.grey,fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 35),
                  this._rowData('Tujuan ST', st['tujuanST'].toString(),media),
                  SizedBox(height: 25),
                  this._rowData('Tanggal Mulai', st['tglmulaiST'].toString(),media),
                  SizedBox(height: 25 ),
                  this._rowData('Tanggal Selesai ', st['tglselesaiST'].toString(),media),
                  SizedBox(height: 25 ),
                  this._rowData('Jam mulai ', st['jammulaiST'].toString(),media),
                  SizedBox(height: 25 ),
                  this._rowData('Jam Selesai ', st['jamselesaiST'].toString(),media),
                  SizedBox(height: 25 ),
                  this._rowData('Kendaraan ', mobil['merk'],media),
                  SizedBox(height: 25 ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                          'Pegawai ST',
                          style: this._styleTitle(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: pegawai.map((e) => Container(
                            width: media.width * 0.5,
                            alignment: Alignment.centerRight,
                            child: Text(
                              '$e -',
                              style: this._stylesub(),
                              textAlign: TextAlign.right,
                            ),
                          )).toList(),
                        )

                    ],
                  ),
                  SizedBox(height: 45,),
                  released == 0 ?
                  RaisedButton(
                    onPressed: () => this._showDialog(st['id']),
                    elevation: 5,
                    color: Config.DJPColorPrimer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: this._isLoading ? 
                      CircularProgressIndicator()
                      :
                      Text(
                        'Booking Kendaraan',
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  )
                  :
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/laporan',arguments: st['id']);
                    },
                    elevation: 5,
                    color: Config.DJPColorPrimer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Laporan ST',
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 45,),


                  
                ],
              ),
            ),  
          )
        ],
      ),
    );
  }
}