import 'package:flutter/material.dart';
import 'package:goceng/shared/Config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/Goceng.dart';



class ApproveSTScreen extends StatelessWidget {


  
  void _approve(int id,BuildContext context) {
    Provider.of<Goceng>(context,listen: false).approveST(id).then((value) {
      if(value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Berhasil Di Approve'),
           duration: Duration(seconds: 2),
           backgroundColor: Colors.green,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
           padding: const EdgeInsets.all(10),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gagal Di Approve!!!!!'),
           duration: Duration(seconds: 2),
           backgroundColor: Colors.red,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
           padding: const EdgeInsets.all(10),
        ));
      }
    });
  }


  Widget noData(BuildContext context,String error1,String error2) => Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical :18.0,horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(child: Image.asset('assets/images/nodata.jpg',width: 300,height:300)),
          SizedBox(height: 15,),
          Text(
            
            error1,
            style: Theme.of(context).textTheme.headline3.copyWith(fontSize:18),
            textAlign: TextAlign.center,
          ),
          Text(
            error2,
            style: Theme.of(context).textTheme.headline3.copyWith(fontSize:18),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final st = Provider.of<Goceng>(context).listSuratTugas;
    final user = Provider.of<Goceng>(context).userLevel;
    print(user);
    final data = st.where((element) => element['approved'] == 0).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.DJPColorPrimer,
        centerTitle: true,
        title: Text('Approve ST'),
      ),
      body: 
      user == 1 ? 
      data.isEmpty ?
      this.noData(context,'Belum ada Surat Tugas !','Silahkan menunggu pegawai mengajukan ST')
      :
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: Dismissible(
              key: Key(data[i]['id'].toString()),
              direction: DismissDirection.startToEnd,
              onDismissed: (sa) => this._approve(data[i]['id'], context),
              child: Hero(
                tag: data[i]['id'].toString(),
                  child: Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/detail-st',arguments: {
                        'id' : data[i]['id'].toString(),
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
                      data[i]['approved'] == true ? 'Approved' : 'Belum Acc',
                      style: TextStyle(
                        color: data[i]['approved'] == true ? Colors.amber : Colors.red,
                        fontSize: 15,
                        letterSpacing: 2
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ),
      )
      : 
      this.noData(context,'Restricted Page!!!!!','Menu Ini Hanya bisa diakses oleh Kepala Kantor') 
    );
  }
}