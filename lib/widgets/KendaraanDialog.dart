import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Goceng.dart';


class Kendaraan extends StatelessWidget {
  const Kendaraan({ Key key,@required this.id }) : super(key: key);

  final int id;

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
    final mobil = this.id != 99 ? Provider.of<Goceng>(context).getSingleMobil(this.id) : {
      'merk' : '-',
      'tipe' : '-' ,
      'warna' : '-',
      'plat' : '-'
    };
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 5,
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text('Kendaraan di Booking'),
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
      content: Container(
        padding: const EdgeInsets.only(top: 15),
        width: media.width * 0.8,
        height: media.height * 0.3,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Merk',
                  style: this._styleTitle()
                ),
                Text(
                  mobil['merk'].toString(),
                  style: this._stylesub(),
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tipe',
                  style: this._styleTitle()
                ),
                Text(
                  mobil['tipe'].toString(),
                  style: this._stylesub(),
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Warna',
                  style: this._styleTitle()
                ),
                Text(
                  mobil['warna'].toString(),
                  style: this._stylesub(),
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Plat Nomor',
                  style: this._styleTitle()
                ),
                Text(
                  mobil['plat'].toString(),
                  style: this._stylesub(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}