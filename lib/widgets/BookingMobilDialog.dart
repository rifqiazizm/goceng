import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Goceng.dart';

class BookingMobilDialog extends StatelessWidget {
  
  
  const BookingMobilDialog({ Key key }) : super(key: key);

  void _onDismiss(BuildContext ctx,int id) {
    Navigator.pop(ctx,id);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final mobil = Provider.of<Goceng>(context).kendaraan;
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 5,
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text('Pilih Kendaraan'),
      contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
      content: Container(
        width: media.width * 0.8,
        height: media.height * 0.5,
        child: ListView.builder(
          itemCount: mobil.length,
          itemBuilder: (ctx,i) => Dismissible(
            key: Key(mobil[i]['plat']),
            direction: DismissDirection.startToEnd,
            onDismissed: (_) => this._onDismiss(context, mobil[i]['id']),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Icon(Icons.car_rental,size: 35,),
                title:   Text(
                  mobil[i]['merk'],
                  style: Theme.of(context).textTheme.headline6,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  mobil[i]['tipe'],
                  style: Theme.of(context).textTheme.headline4,
                ),
                trailing: Text(
                  mobil[i]['warna'],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}