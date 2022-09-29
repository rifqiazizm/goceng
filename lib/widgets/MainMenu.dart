import 'package:flutter/material.dart';
import 'package:goceng/shared/Config.dart';



class MainMenu extends StatelessWidget {




  Widget _menu(IconData icon,String title,bool opsiWarna,BuildContext context,String url) => Card(
    elevation: 10,
    color: opsiWarna ? Config.DJPColorPrimer.withOpacity(0.95) : Config.DJPColorSekunder.withOpacity(0.75),
    // color: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
    child: InkWell(
      focusColor: Colors.black38,
      hoverColor: Colors.white30,
      onTap: () => {
        Navigator.of(context).pushNamed(url)
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,size: 55,color: opsiWarna ? Colors.white : Config.DJPColorPrimer,),
            SizedBox(height: 15,),
            FittedBox(
              // alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: opsiWarna ? Colors.white : Config.DJPColorPrimer,
                  fontSize: 22,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );


  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Text(
            'Main Menu',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),

        Container(
          // alignment: Alignment.center,
          width: mediaQ.width,
          height: 450,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 6/5,
              crossAxisCount: 2, 
              crossAxisSpacing: 15 ,
              mainAxisSpacing: 20,
            ),
            children: [
              this._menu(Icons.note_add_outlined, 'Buat ST', true,context,'/buatST'),
              this._menu(Icons.car_rental, 'Mobil Dinas', false,context,'/mobil'),
              this._menu(Icons.approval, 'Approve ST', false,context,'/approve'),
              this._menu(Icons.airplanemode_on_sharp,'RPNK', true,context,'/tes')
            ],
          ),
        ),
      ]
    );
    
  }
}