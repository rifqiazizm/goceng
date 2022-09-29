import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/Goceng.dart';

class STListView extends StatelessWidget {

  final String _jenisTab;
  STListView(this._jenisTab);
  

  Widget noData(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical :8.0,horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(child: Image.asset('assets/images/nodata.jpg',width: 300,height:300)),
        SizedBox(height: 15,),
        Text(
          'Belum ada Surat tugas nihh',
          style: Theme.of(context).textTheme.headline3.copyWith(fontSize:18),
          textAlign: TextAlign.center,
        ),
        Text(
          'tambah Surat Tugas dulu!',
          style: Theme.of(context).textTheme.headline3.copyWith(fontSize:18),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final st = Provider.of<Goceng>(context).listSuratTugas;
    print(st);
    final dataArsip = st.where((element) => element['released'] == 0).toList();
    final dataRilis = st.where((element) => element['released'] == 1).toList();
    final data = this._jenisTab == "arsip" ? dataArsip : dataRilis; 
    return data.isEmpty ?
    this.noData(context)
    :
    ListView.builder(
      itemCount: data.length,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
        child: Hero(
          tag: data[i]['id'].toString(),
            child: Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/detail-st',arguments: {
                  'id' : data[i]['id'],
                });
              },
              leading: Container(
                // margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center, 
                height: media.height * 0.3,
                width: 60,
                padding: const EdgeInsets.only(top:5),
                child: Column(
                  children: [
                      Text(
                      DateTime.parse(data[0]['tglmulaiST']).day.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    FittedBox(
                        child: Text(
                          DateFormat('MMM').format(DateTime.parse(data[0]['tglmulaiST'])).toString(),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87
                          ),
                        ),
                      ),
                  ]
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10)
                ),
                // color: Color.fromRGBO(33, 43, 96,1 ),
              ),
              title: Text(
                data[i]['agendaST'],
                style: Theme.of(context).textTheme.headline6,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${data[i]['jammulaiST']} - ${data[i]['jamselesaiST']}',
                style: Theme.of(context).textTheme.headline4,
              ),
              trailing: Text(
                data[i]['approved'] == 1 ? 'Approved' : 'Belum Acc',
                style: TextStyle(
                  color: data[i]['approved'] == 1 ? Colors.amber : Colors.red,
                  fontSize: 15,
                  letterSpacing: 2
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}