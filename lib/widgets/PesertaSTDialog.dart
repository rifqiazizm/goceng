import 'package:flutter/material.dart';
import 'package:goceng/shared/Config.dart';


class PesertaST extends StatefulWidget {
  PesertaST({ Key key, @required this.mediaQ,  }) : super(key: key);

  final Size mediaQ;

  @override
  _PesertaSTState createState() => _PesertaSTState();
}

class _PesertaSTState extends State<PesertaST> {
  TextEditingController _pesertaController = new TextEditingController();


  void _tambahPeserta() {
    Navigator.pop(context,this._pesertaController.text);
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 5,
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text('Input Peserta ST'),
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
      content: Container(
        width: this.widget.mediaQ.width * 0.8,
        height: this.widget.mediaQ.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0,bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: this._pesertaController,
                style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                          labelText: 'Nama Pegawai',
                          labelStyle: TextStyle(color: Config.DJPColorPrimer),
                          hintStyle: TextStyle(
                            color: Colors.grey[400]
                          ),
                          hintText: 'Siapa Pegawai Peserta ST?',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Config.DJPColorPrimer
                            ),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                              color: Config.DJPColorSekunder
                            )
                          )
                ),
              ),
              RaisedButton(
                onPressed: this._tambahPeserta,
                elevation: 5,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                color: Config.DJPColorPrimer,
                child: Text(
                  'Tambah Pegawai',
                  style: TextStyle(color: Colors.white,letterSpacing: 1.5),
                ),
              
              )
            ]
          ),
        ),
      ),
    );
  }
}