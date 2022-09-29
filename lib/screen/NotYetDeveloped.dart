import 'package:flutter/material.dart';



class NotYetDeveloped extends StatelessWidget {

  final Image image = Image.asset(
    'assets/images/nodata.jpg',
    fit: BoxFit.cover,
    height: 300,
    width: 400,  
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OOOppsss'
        ),
        backgroundColor: Color.fromRGBO(33, 43, 96,1 ),
      ),
      body: Container(
        color: Color(0xFFF6F7F9),
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox(height: 10,),),
            ClipOval(
              child: this.image
            ),
            SizedBox(height: 20),
            Text(
              'Sabar yaaa.. Formulir Rencana Perjalanan Non Kedinasan sedang dibangun disini :D',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '958632702 / 199905192018121004',
                  // style: Theme.of(context).textTheme.headline3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}