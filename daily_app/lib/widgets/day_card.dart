import 'package:daily_app/screens/register_day_screen.dart';
import 'package:flutter/material.dart';

class CustomDayCard extends StatefulWidget {
  const CustomDayCard({
    Key? key,
    required this.imageNumber,
  }) : super(key: key);


  final int imageNumber;

  @override
  State<CustomDayCard> createState() => _CustomDayCardState();
}

class _CustomDayCardState extends State<CustomDayCard> {

  String _getImagePath(int imageNumber) {
    switch (imageNumber) {
      case 1:
        return 'images/angry.png';
      case 2:
        return 'images/IconoApp.png';
      case 3:
        return 'images/serios.png';
      default:
        return 'images/meh.png';
    }
  }
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterDayScreen()),
          );
        },
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0XFFFFFFFF),
            boxShadow:[
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 1,
                offset: Offset(1, 1),
              ),
            ]
        ),

        child:
        Row(
          children: [
                Container(
                  width: 60,
                  height: 110,
                  child:
                  Column(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(_getImagePath(widget.imageNumber)),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade400,
                        ),
                        child: Text(' 09 Lun', style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                        ),),
                      )
                    ],
                  )
                ),
            VerticalDivider(
              width: 35,
              thickness: 1.5,
              indent: 1,
              endIndent: 1,
              color: Colors.grey.shade300,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric( horizontal: 4, vertical: 5,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade300,
                      ),
                      child:

                      Text(',', style: TextStyle(color: Colors.grey.shade300,),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric( horizontal: 4, vertical: 5,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade300,
                      ),
                      child:

                      Text(',', style: TextStyle(color: Colors.grey.shade300,),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric( horizontal: 4, vertical: 5,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade300,
                      ),
                      child:

                      Text(',', style: TextStyle(color: Colors.grey.shade300,),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric( horizontal: 4, vertical: 5,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade300,
                      ),
                      child:

                      Text(',', style: TextStyle(color: Colors.grey.shade300,),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric( horizontal: 4, vertical: 1,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade300,
                      ),
                      child:

                      Text(',', style: TextStyle(color: Colors.grey.shade300,),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric( horizontal: 4, vertical: 1,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade300,
                      ),
                      child:

                      Text(',', style: TextStyle(color: Colors.grey.shade300,),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric( horizontal: 4, vertical: 1,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade300,
                      ),
                      child:

                      Text(',', style: TextStyle(color: Colors.grey.shade300,),),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.symmetric( horizontal: 4, vertical: 1,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.grey.shade300,
                      ),
                      child:

                      Text(',', style: TextStyle(color: Colors.grey.shade300,),),
                    ),
                  ],
                )
              ],
            ),
          ],
        )
        ,
            ),
      );
  }
}
