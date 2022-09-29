import 'package:flutter/material.dart';
import 'package:goceng/provider/Goceng.dart';
import 'dart:io';
import 'package:goceng/shared/Config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LaporanSTScreen extends StatefulWidget {
  

  @override
  _LaporanSTScreenState createState() => _LaporanSTScreenState();
}

class _LaporanSTScreenState extends State<LaporanSTScreen> {

  Size _mediaQ;
  var _isLoading = false;
  var _init = true;
  File _tmpFile;
  LocationData _location;
  TextEditingController _lapForm = new TextEditingController();
  int id;


    @override
      void didChangeDependencies() {
        if(this._init) {
          this._mediaQ = MediaQuery.of(context).size;
          this._init = false;
          this.id = ModalRoute.of(context).settings.arguments;
        }
        print(this._lapForm.text.length);
        super.didChangeDependencies();
    }


    Future<void> _addImage() async {
      final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
      final loc = await Location().getLocation();
      if(pickedFile != null) {
        setState(() {
          this._tmpFile = File(pickedFile.path);        
          this._location = loc;
        });
        print(this._location.toString());

      } else {
        return;
      }
      
    }

    void _submitLaporan() {
      setState(() {
        this._isLoading = true;        
      });
      Provider.of<Goceng>(context,listen: false).laporanST(this.id, this._tmpFile, this._location.toString(), this._lapForm.text).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value),
          backgroundColor: Colors.green,
        ));
        setState(() {
        this._isLoading = false;        
      });
      });
    }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.DJPColorPrimer,
        centerTitle: true,
        title: Text(
          'Laporan Rilis ST',
        ),
      ),
      body: ListView(
        children: [
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child : 
          //   ),
          Container(
            // height: media.height,
            // height: 600,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Column(
              children: [
                Container(
                  
                  alignment: Alignment.center,
                  width: double.infinity,
                  // height: this._mediaQ.height * 0.4,
                  height: 250,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F7F9),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.withOpacity(0.6),width: 2),
                    image: this._tmpFile != null ? DecorationImage(
                      image: FileImage(this._tmpFile),
                      fit: BoxFit.cover,
                      alignment: Alignment.center
                    )
                    :
                    null
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera,color: Colors.grey.withOpacity(0.7),size: 45,),
                      SizedBox(height: 25,),
                      Text(
                        'Preview Foto',
                        style: TextStyle(
                          fontSize: 27,
                          letterSpacing: 1.5,
                          color:  Colors.grey.withOpacity(0.7)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  controller: this._lapForm,
                  decoration: InputDecoration(
                    hintText: 'Masukan Rincian kegiatan ST',
                    hintStyle: TextStyle(color: Config.DJPColorPrimer,letterSpacing: 1.5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Config.DJPColorPrimer,width: 1.5)
                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Config.DJPColorSekunder))
                  ), 
                  enabled: true,

                )
              ],
            ),
          ),
          SizedBox(height: this._mediaQ.height * 0.12,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              // width: double.infinity,
              height: this._mediaQ.height * 0.25,
              // color: Colors.green,
              // color: Colors.black,
              child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlineButton(
                        onPressed: this._addImage,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        borderSide: BorderSide(color: Config.DJPColorPrimer,width: 2),
                        child: Text(
                          'Tambah Foto',
                          style: TextStyle(
                            color: Config.DJPColorPrimer,
                            letterSpacing: 2,
                            fontSize: 18
                          ),
                        ),  
                      ),
                      SizedBox(height: 15,),
                      RaisedButton(
                        onPressed: this._lapForm.text.length != 0 ? this._submitLaporan : null,
                        color: Config.DJPColorPrimer,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.white,
                        splashColor: Config.DJPColorSekunder,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: this._isLoading ? CircularProgressIndicator() : Text(
                          'Submit Laporan',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18

                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ),
          ),
        ],

      ),
    );
  }
}