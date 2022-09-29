import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Goceng.dart';
import '../shared/Config.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  Size _mediaQ;
  var _isLoading = false;
  var _isinit = true;

  var _formVal = {
    'username' : '',
    'password' : ''
  };

  @override
    void didChangeDependencies() {
      if(this._isinit) {
        this._mediaQ = MediaQuery.of(context).size;
        this._isinit = false;
      }
      super.didChangeDependencies();
  }

  void _requestLogin(Map<String,String> values) {
    // proses login disini 
    print(values);
  }

  Future<void> _saveForm() async {
    setState(() {
      this._isLoading = true;      
    });
    if(this._formKey.currentState.validate()) {
     

        await this._formKey.currentState.save();
        print('validate berjalan');

        final req = await Provider.of<Goceng>(context,listen: false).checkUserRequest(this._formVal);
        if(req) {
          Navigator.of(context).pushReplacementNamed('/app'); 
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
            backgroundColor: Colors.red.withOpacity(0.8),
            content: const Text('Username/Password Salah!!!'),
          ));
          setState(() {
            this._isLoading = false;      
          });
        }
        
        // if(this._formVal['password'] == '123') {
        //   print('oke benar akan di redirect');
        //   this._requestLogin(this._formVal);
        //   Provider.of<Goceng>(context,listen: false).saveUser({
        //     ...this._formVal,
        //     'namaSeksi' : 'Pengawasan V', 
        //     'userLevel' : '1' 
        //   }); 
        //   Navigator.of(context).pushReplacementNamed('/app'); 
        // } else { 
        //   print('password salah'); 
        //   this._isLoading = false; 
        // } 
 
    } else { 
      setState(() {
            this._isLoading = false;      
          });
    } 
  } 
 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: SafeArea( 
        child: Padding( 
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25), 
          child: Form( 
            key: this._formKey, 
            child: ListView( 
              children: <Widget> [
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.grey
                  //   )
                  // ),
                  height: this._mediaQ.height * 0.3,
                  // width: 200,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logodjp4.png',
                    alignment: Alignment.center,
                    fit: BoxFit.cover ,
                    height: this._mediaQ.height * 0.2,
                  ),
                ),
                SizedBox(height: this._mediaQ.height * 0.1,),
                TextFormField(
                  style: Theme.of(context).textTheme.headline4,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Config.DJPColorPrimer),
                    hintStyle: TextStyle(
                      color: Colors.grey[400]
                    ),
                    hintText: 'Masukan Username Anda',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Config.DJPColorPrimer
                      ),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Config.DJPColorSekunder
                      )
                    )
                  ),
                  enableSuggestions: true,
                  onSaved: (val) => {
                    this._formVal = {
                      ...this._formVal,
                      'username' : val.toString()
                    }
                  },
                  validator: (val) {
                    if(val.isEmpty) {
                      return "Username Harus diisi" ;
                    }
                    
                    return null;
                  },
                ),
                SizedBox(height: 35,),
                TextFormField(
                  style: Theme.of(context).textTheme.headline4,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'password',
                    labelStyle: TextStyle(color: Config.DJPColorPrimer),
                    hintStyle: TextStyle(
                      color: Colors.grey[400]
                    ),
                    hintText: 'Masukan Password Anda',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Config.DJPColorPrimer
                      ),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Config.DJPColorSekunder
                      )
                    )
                  ),
                  enableSuggestions: false,
                  autocorrect: false,
                  onSaved: (val) => {
                    this._formVal = {
                      ...this._formVal,
                      'password' : val.toString()
                    }
                  },
                  validator: (val) {
                    if(val.isEmpty) {
                      return "password Harus diisi" ;
                    }
                    
                    return null;
                  },
                ),
                SizedBox(height: this._mediaQ.height * 0.1,),
                RaisedButton(
                  elevation: 5,
                  highlightColor: Colors.amber,
                  splashColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  color: Config.DJPColorPrimer,
                  onPressed: () => this._saveForm(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20
                    ),
                    child: this._isLoading ?
                      CircularProgressIndicator()
                    :
                      Text(
                        'Login skuy',
                        // style: Theme.of(context).textTheme.headline4
                        style: Theme.of(context).textTheme.headline5
                      ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}