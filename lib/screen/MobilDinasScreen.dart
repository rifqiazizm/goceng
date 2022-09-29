import 'package:flutter/material.dart';
import 'package:goceng/shared/Config.dart';
import '../provider/Goceng.dart';
import 'package:provider/provider.dart';

class MobilDinasScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final kendaraan = Provider.of<Goceng>(context).kendaraan;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.DJPColorPrimer,
        centerTitle: true,
        title: Text(
          'Mobil Dinas Tersedia'
        ),
      ),
      body: Container(
        color:  Color(0xFFF6F7F9),
        child: ListView.builder(
          itemCount: kendaraan.length,
          itemBuilder: (ctx,i) => Card(
            margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 7,
            color: Colors.grey.withOpacity(0.5),
            child: Container(
              height: 250,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    kendaraan[i]['url'],
                    fit: BoxFit.cover, 
                    height: 200,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text( 
                            kendaraan[i]['merk'],
                          ),
                          Text(
                            kendaraan[i]['tipe'],
                          ),
                          Text(
                            kendaraan[i]['plat'],
                          )
                        ],
                      ),

                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}