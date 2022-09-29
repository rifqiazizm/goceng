import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:async/async.dart';
import 'package:path/path.dart';

class Goceng with ChangeNotifier {

  int id;
  String user;
  String password;
  int userLevel;
  String namaSeksi;

  
  Goceng({
    this.user,
    this.password,
    this.userLevel,
    this.namaSeksi 
  });

  final _url = 'https://pajakcengkareng.my.id/';
  
  final header = {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
  };

  Map<String, String> header2 = {
      'Content-Type': 'multipart/form-data',
    };

  List<Map<String,Object>> _listMobilDinas = [
    {
      'id' : 2,
      'merk' : 'Kijang',
      'tipe' : 'Innova',
      'warna' : 'Hitam',
      'plat' : 'B 1234 ABC',
      'url' : 'https://pajakcengkareng.my.id/images/inovakakap.jpg'
    },
    {
      'id' : 3,
      'merk' : 'Mitsubishi',
      'tipe' : 'Xpander',
      'warna' : 'Hitam',
      'plat' : 'B 2234 ABC',
      'url' : 'https://pajakcengkareng.my.id/images/xpander.png'

    },
    {
      'id' : 99,
      'merk' : 'Tidak ada',
      'tipe' : 'Tidak ada',
      'warna' : 'Tidak ada',
      'plat' : 'Tidak ada',
      'url' : 'https://pajakcengkareng.my.id/images/xpander.png'

    }
  ];


  List<Map<String,Object>> _listSuratTugas = [
    {
      'id' : '1',
      'pesertaST' : 'Muhammad Rifqi Aziz,Sherin Simanjuntak,Hervindy Radit',
      'alamatST' : 'Jalan Kapuk Pesing Poglar',
      'tujuanST' : 'Ping Astono',
      'tglST' : '2021-08-23',
      'tglmulaiST' : '2021-08-23',
      'tglselesaiST' : '2021-08-23',
      'jammulaiST' : '07:30',
      'jamselesaiST' : '12:00',
      'agendaST' : 'Kunjungan Wajib Pajak',
      'seksi' : 'Pelayanan',
      'transport' : false,
      'mobildinas_id' : '',
      'approved' : false,
      'released' : false
    },
    {
      'id' : '2',
      'pesertaST' : 'Ristanty Fitri,Adella Nur Safitri', 
      'alamatST' : 'Jl Lingkar Luar Barat No 10A ',
      'tujuanST' : 'PT Berdikari Makmur',
      'tglST' : '2021-08-23',
      'tglmulaiST' : '2021-08-28',
      'tglselesaiST' : '2021-08-28',
      'jammulaiST' : '09:30',
      'jamselesaiST' : '12:00',
      'agendaST' : 'Kunjungan Wajib Pajak',
      'seksi' : 'P3',
      'transport' : true,
      'mobildinas_id' : '2',
      'approved' : true,
      'released' : false
    },
    {
      'id' : '3',
      'pesertaST' : 'Muhammad Rifqi Aziz,Rendi Kristiawan',
      'alamatST' : 'Komplek Taman Palem Lestari Blok O11 no 12',
      'tujuanST' : 'PT Abadi Jaya Cemerlang',
      'tglST' : '2021-08-23',
      'tglmulaiST' : '2021-08-25',
      'tglselesaiST' : '2021-08-25',
      'jammulaiST' : '12:00',
      'jamselesaiST' : '16:00',
      'agendaST' : 'Penyampaian Surat Teguran',
      'seksi' : 'P3',
      'transport' : true,
      'mobildinas_id' : '3',
      'approved' : true,
      'released' : true
    },
  ];


  Future<bool> checkUserRequest(Map<String,Object> login) async {

    try {

         final req = await http.post(this._url+'api/goceng/checkUser',headers: this.header,body: json.encode(login));
       // final req = await http.get(this._url+'api/goceng/getUser');
       if(req.statusCode == 200) {
        //  print(req.body);
         final data = json.decode(req.body) as Map<String,Object>;
         final berhasil = data['status'];
         final userData = data['data'] as Map<String,Object>;
         if(berhasil) {
            this.id = userData['id'];
            this.user = userData['username'];
            this.password = userData['password'];
            this.namaSeksi = userData['namaSeksi'];
            this.userLevel = userData['userLevel'];

            final prefs = await SharedPreferences.getInstance();
            final jsonData = json.encode(userData);
            prefs.setString('userData', jsonData);
            notifyListeners();
         }
         return berhasil;
         
         
       } else {
       
        //  print(req.headers);
        //  print(req.statusCode);
         return false;
       }


    } catch(err) {
      throw err;
    }
    

    
  }

  Map<String,Object> get orang{
    return {
      'id' : this.id,
      'seksi' : this.namaSeksi,
      'level' : this.userLevel 
    };
  }
 
  List<Map<String,Object>> get listSuratTugas {
    return [
      ...this._listSuratTugas
    ];
  }

  List<Map<String,Object>> get kendaraan {
    return [
      ...this._listMobilDinas
    ];
  }


  Future<bool> approveST(int id) async {
    final req = await http.get('${this._url}api/goceng/approve/$id');
    if(req.statusCode == 200) {
      final res = json.decode(req.body) as Map<String,Object>;
      final status = res['status'];
      final data = res['data'] as bool;
      if(data == true) {
        print(data);
        final st = this._listSuratTugas.firstWhere((element) => element['id'] == id);
        st['approved'] = 1;
        notifyListeners();  
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<Map<String,Object>> addMobilDinas(int id,int mobilId) async {
    try {

      final req = await http.patch('${this._url}api/goceng/mobil/$id',headers: this.header,body: json.encode({
        'mobildinas_id' : mobilId
      }));
      if(req.statusCode == 200) {
        final res = json.decode(req.body) as Map<String,Object>;
        print(res['status']);
        if(res['status']) {
          final st = this._listSuratTugas.firstWhere((element) => element['id'] == id);
          st['mobildinas_id'] = mobilId;
          notifyListeners();
          
        }
        return res;

      } else {
        return {
          'status' : false,
          'kata' : 'request HTTP gagal'
        };
      }


    } catch(err) {
      throw err;
    }

    
  }

  Map<String,Object> getSingleMobil(int id) {
    return this._listMobilDinas.firstWhere((element) => element['id'] == id);
  }

  void addUser(Map<String, Object> userData) {
    this.id = userData['id'];
    this.user = userData['username'];
    this.password = userData['password'];
    this.namaSeksi = userData['namaSeksi'];
    this.userLevel = userData['userLevel'];
    notifyListeners();
  }

  Future<void> saveUser(Map<String, Object> userData) async {
    this.user = userData['username'];
    this.password = userData['password'];
    this.namaSeksi = userData['namaSeksi'];
    this.userLevel = userData['userLevel'];

    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(userData);
    prefs.setString('userData', jsonData);
    notifyListeners();

  }

  Map<String,Object> getDetailST (int id) {
    final detail = this._listSuratTugas.firstWhere((element) => element['id'].toString() == id.toString());
    return detail;
  }


  Future<void> fetchST() async {
    this._listSuratTugas = [];
    final req = await http.get('${this._url}api/goceng/getST/${this.id}');
    if(req.statusCode == 200) {
      final res = json.decode(req.body) as Map<String,Object>;
      final data = res['data'] as List;
      this._listSuratTugas = [
        ...data
      ];
      notifyListeners();
      // print(this._listSuratTugas);
    }
  }

  Future<void> fetchMobilDinas() async {
    this._listMobilDinas = [];

    try {

      final req = await http.get('${this._url}api/goceng/fetchMobil');
      if(req.statusCode == 200) {
        final data = json.decode(req.body) as Map<String,Object>;
        if(data['status'] == 'oke') {
          final mobil = data['data'] as List;
          this._listMobilDinas = [
            ...mobil
          ];
          notifyListeners();
        } 
      }
    } catch(err) {
      throw(err);
    }
  }
  
  Future<bool> addSurat(Map<String,Object> request) async {
    // print(request);
    final req = await http.post(this._url+'api/goceng/surattugas',headers: this.header,body: json.encode(request));
    if(req.statusCode == 200) {
      final res = await json.decode(req.body) as Map<String,Object>;
      this.fetchST();

      return true;
    } else {
      // print(req.statusCode);
      // print(req.headers);
      // print(req.body);
      return false;
    }
  }

  Future<String> laporanST(int id,File image,String koordinat,String uraian) async {
    // final stream = http.ByteStream(image.openRead());
    // stream.cast();
    // final uri = Uri.parse('${this._url}api/goceng/laporanST');
    // final length = await image.length();

    // final request = http.MultipartRequest("POST",uri);

    // print(uri);
    // final multiPartFile = http.MultipartFile('image',stream,length,filename: basename(image.path));
    final body = {
      'id' : id.toString(),
      'koordinat' : koordinat,
      'uraianLaporan' : uraian
    };
    print(image);

    var request = http.MultipartRequest('POST', Uri.parse('${this._url}api/goceng/laporanST'))
      ..fields.addAll(body)
      ..headers.addAll(this.header2)
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    // request.fields['koordinat'] = koordinat;
    // request.fields['uraianLaporan'] = uraian;
    // request.files.add(multiPartFile);

    print(request.fields);
    final req = await request.send();
    final res = await http.Response.fromStream(req);
    final data = json.decode(res.body) as Map<String,Object>;
    if(res.statusCode == 200) {
      final kata = data['kata'] as String;
      return kata;

    } else {
      final kata = data['kata'] as String;
      return kata;
    }


  }



 

}