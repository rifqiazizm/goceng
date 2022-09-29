import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/PesertaSTDialog.dart';
import '../provider/Goceng.dart';
import '../shared/Config.dart';
import 'package:select_form_field/select_form_field.dart';



class FormSTScreen extends StatelessWidget {




  @override 
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Config.DJPColorPrimer,
        centerTitle: true,
        title: Text(
          'Buat ST',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: BodyST(mediaQ: mediaQ)
    );
  }
}



class BodyST extends StatefulWidget {
  const BodyST({
    Key key,
    @required this.mediaQ,
  }) : super(key: key);

  final Size mediaQ;

  @override
  _BodySTState createState() => _BodySTState();
}


class _BodySTState extends State<BodyST> {

  final _formKey = GlobalKey<FormState>();

  var _formVal = {
    'namaPeserta' : '',
    'alamatST' : '',
    'tujuanST' : '',
    'tglmulaiST' : '',
    'tglselesaiST' : '',
    'jammulaiST' : '', 
    'jamselesaiST' : '',
    'agendaST' : '',
    'transport' : 0,
    'seksi_id' : 1
  };

  List<String> _peserta = [];
  var _isLoading = false;

  String _inputTglMulai;
  String _inputTglSelesai;
  String _inputJamMulai;
  String _inputJamSelesai;

  var _items = [
    {
      'value': 1,
      'label': 'Ya',
      'icon': Icon(Icons.check)
    },
    {
      'value': 0,
      'label': 'Tidak',
      'icon': Icon(Icons.cancel),
      'textStyle': TextStyle(color: Config.DJPColorPrimer),
    },
  ];



  Future<void> _selectDate(bool mulai) async {
    final tgl = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(Duration(days: 360))
    );

    final convert = DateFormat('yyyy-MM-dd').format(tgl).toString();
    setState(() {
      if(mulai) {
        this._inputTglMulai = convert;
        this._formVal = {
          ...this._formVal,
          'tglmulaiST' : convert
        };
      } else {
        this._inputTglSelesai = convert;
        this._formVal = {
          ...this._formVal,
          'tglselesaiST' : convert
        };
      }
        
    });
  }



  Future<void> _selectTime(bool mulai) async {
    final jam = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay(hour: 7, minute: 30,),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );

    final convert = '${jam.hour.toString()}:${jam.minute.toString()}';

    setState(() {
      if(mulai) {
        this._inputJamMulai = convert;
        this._formVal = {
          ...this._formVal,
          'jammulaiST' : convert
        };
      } else {
        this._inputJamSelesai = convert;
        this._formVal = {
          ...this._formVal,
          'jamselesaiST' : convert
        };
      }
    });
    print(jam);
  }


  Future<void> _showdialog() async {
    showDialog(
      context: context, 
      builder: (ctx) => PesertaST(mediaQ : widget.mediaQ)
    ).then((val) {
      if (val != null) {
        setState(() {      
          this._peserta.add(val);
          print(this._peserta);
        });
      }
    });

    // print(namaST);
  }

  void _toggleEnabledLawanTrx(String val) {
      
  }

  Future<void> _loginRequest() async {
    setState(() {
      this._isLoading = true;    
    });
    if(this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      final mergedPeserta = this._peserta.join(',');
      this._formVal['namaPeserta'] = mergedPeserta;

      final id = Provider.of<Goceng>(context,listen: false).orang['id'];
      this._formVal['seksi_id'] = id;
      // print(this._formVal); 
      Provider.of<Goceng>(context,listen: false).addSurat(this._formVal).then((value) {
        if(value) {
          // Navigator.pop(context); 
          setState(() {
            this._isLoading = false;    
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('ada Something Wrong nihhh'),
            backgroundColor: Colors.red.withOpacity(0.7),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ));
          setState(() {
            this._isLoading = false;            
          });
        }
      });
    } 
  }

  Widget _namaPeserta(List<String> pegawai) => Container(
    width: widget.mediaQ.width ,
    margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pegawai.asMap().entries.map((entry) {
        final ind = entry.key;
        final val = entry.value;
        return Dismissible(

          key: Key(val),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            if(direction == DismissDirection.startToEnd) {
              setState(() {
                this._peserta.removeAt(ind);  
                print(this._peserta); 
              });
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            color: Config.DJPColorSekunder.withOpacity(0.75),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal : 15.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.person,color: Colors.white70,),
                  FittedBox(
                    child: Text(
                      val,
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(

      children: [
        Padding( 
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
            color: Config.DJPColorPrimer,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              height: widget.mediaQ.height * 0.20,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('JUMLAH PEGAWAI ST',style: Theme.of(context).textTheme.headline5,),
                  SizedBox(height: 20,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          this._peserta.length.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 65,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        // OutlinedButton(
                        //   style: OutlinedButton.styleFrom(
                        //     shape: StadiumBorder(),
                        //     elevation: 5,
                        //     side: BorderSide(color: Colors.grey),
                        //     minimumSize: Size(100, 40),
                        //     padding: const EdgeInsets.symmetric(horizontal: 15)
                        //   ),
                        //   onPressed: () {}, 
                        //   child: Text('Tambah Pegawai',style: TextStyle(color: Colors.grey,fontSize: 18),)
                        // ),
                        Container(
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.amber,width: 2)
                          ),
                          child: IconButton(
                            splashColor: Colors.amber,
                            icon: Icon(Icons.person_add), 
                            onPressed: this._showdialog,
                            color: Colors.amber,
                            iconSize: 35,
                          ),
                        )
                      
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        this._namaPeserta(this._peserta),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
          child: Text(
            'Isi Form Berikut',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(vertical : 20,horizontal: 15),
          child: Form(
            key: this._formKey,
            child: Column(
              children: [
                
                TextFormField(
                    style: Theme.of(context).textTheme.headline4,
                    decoration: InputDecoration(
                      labelText: 'Agenda ST',
                      labelStyle: TextStyle(color: Config.DJPColorPrimer),
                      hintStyle: TextStyle(
                        color: Colors.grey[400]
                      ),
                      hintText: 'Apa Agenda ST Anda?',
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
                    onSaved: (val) => {
                      this._formVal = {
                        ...this._formVal,
                        'agendaST' : val.toString()
                      }
                    },
                    validator: (val) {
                      if(val.isEmpty) {
                        return "Username Harus diisi" ;
                      }
                      
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline4,
                    decoration: InputDecoration(
                      labelText: 'Wajib Pajak Tujuan ',
                      labelStyle: TextStyle(color: Config.DJPColorPrimer),
                      hintStyle: TextStyle(
                        color: Colors.grey[400]
                      ),
                      hintText: 'Siapa tujuan wajib pajak anda?',
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
                    onSaved: (val) => {
                      this._formVal = {
                        ...this._formVal,
                        'tujuanST' : val.toString()
                      }
                    },
                    validator: (val) {
                      if(val.isEmpty) {
                        return "Tujuan ST Harus diisi" ;
                      }
                      
                      return null;
                    },
                  ),
                  SizedBox(height: 25,),
                  TextFormField(
                    style: Theme.of(context).textTheme.headline4,
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      labelStyle: TextStyle(color: Config.DJPColorPrimer),
                      hintStyle: TextStyle(
                        color: Colors.grey[400]
                      ),
                      hintText: 'Dimana Alamat ST?',
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
                    onSaved: (val) => {
                      this._formVal = {
                        ...this._formVal,
                        'alamatST' : val.toString()
                      }
                    },
                    validator: (val) {
                      if(val.isEmpty) {
                        return "Alamat ST Harus diisi";
                      }
                      
                      return null;
                    },
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        onPressed: () => this._selectDate(true),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(vertical: 18,horizontal: 25),
                        borderSide: BorderSide(
                          color: Config.DJPColorPrimer,
                        ),
                        color: Colors.red,
                        textColor: Config.DJPColorPrimer,
                        splashColor: Config.DJPColorSekunder,
                        
                        child: Text(
                          this._inputTglMulai != null ? this._inputTglMulai : 'Tanggal Mulai' ,
                          style: Config.buttonText,
                        ),
                      ),
                      Icon(Icons.arrow_right_alt),
                      OutlineButton(
                        onPressed: () => this._selectDate(false),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(vertical: 18,horizontal: 25),
                        borderSide: BorderSide(
                          color: Config.DJPColorPrimer,
                        ),
                        color: Colors.red,
                        textColor: Config.DJPColorPrimer,
                        splashColor: Config.DJPColorSekunder,
                        
                        child: Text(
                          this._inputTglSelesai != null ? this._inputTglSelesai : 'Tanggal Selesai' ,
                          style: Config.buttonText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        onPressed: () => this._selectTime(true),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(vertical: 18,horizontal: 35),
                        borderSide: BorderSide(
                          color: Config.DJPColorPrimer,
                        ),
                        color: Colors.red,
                        textColor: Config.DJPColorPrimer,
                        splashColor: Config.DJPColorSekunder,
                        child: Text(
                          this._inputJamMulai != null ? this._inputJamMulai : 'Jam Mulai' ,
                          style: Config.buttonText,
                        ),
                      ),
                      Icon(Icons.arrow_right_alt),
                      OutlineButton(
                        onPressed: () => this._selectTime(false),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(vertical: 18,horizontal: 35),
                        borderSide: BorderSide(
                          color: Config.DJPColorPrimer,
                        ),
                        color: Colors.red,
                        textColor: Config.DJPColorPrimer,
                        splashColor: Config.DJPColorSekunder,
                        child: Text(
                          this._inputJamSelesai != null ? this._inputJamSelesai : 'Jam Selesai' ,
                          style: Config.buttonText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  SelectFormField(
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  decoration: InputDecoration(
                    hintText: 'Ya atau Tidak',
                    labelText: 'Pakai Kendaraan dinas?',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Config.DJPColorPrimer),
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                  icon: null,
                  labelText: 'Pakai Kendaraan Dinas?',
                  items: this._items,
                  onChanged: this._toggleEnabledLawanTrx,
                  onSaved: (val) => this._formVal['transport'] = val,
                  style: TextStyle(color: Config.DJPColorPrimer),
                  validator: (val) {
                    if(val.isEmpty) {
                      return "Harus Pilih Salah Satu!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25,),
                  RaisedButton(
                    onPressed: this._loginRequest,
                    color: Config.DJPColorPrimer.withOpacity(0.9),
                    elevation: 5,
                    splashColor: Config.DJPColorPrimer,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: this._isLoading ? CircularProgressIndicator() : Text(
                        'Submit',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
} 