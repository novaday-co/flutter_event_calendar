import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, }) : super(key: key);




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ValueNotifier<CalendarType> typeCalendar = ValueNotifier<CalendarType>(CalendarType.JALALI);
  ValueNotifier<String> calendarLanguage = ValueNotifier<String>("en");
  ValueNotifier<ViewType> calendarViewType = ValueNotifier<ViewType>(ViewType.MONTHLY);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
// create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  showBottomSheet(){
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),color: Colors.white),
          height: 400,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //    mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("calendarType",  style: TextStyle(
                        fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("headerMonthBackColor" ,style: TextStyle(
                        fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    //   Container(color: Colors.red,child: OutlinedButton.styleFrom(: ,onPressed: openPaltte, child: Icon(Icons.palette)),),
                    OutlinedButton(

                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(10, 40),
                        side: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                      child:   Icon(Icons.palette,color: Colors.cyan,),
                      onPressed: openPaltte,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("calendarLanguage" ,style: TextStyle(
                        fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),

                  ],
                ),
                SizedBox(height: 20,),


                Row(
                  children: [
                    Text("MonthStringTypes" ,style: TextStyle(
                        fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),

                  ],
                ),


              ],
            ),
          ),
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {


    typeCalendar.addListener(() {
      print("addListener callde + ${typeCalendar.value}");

      setState(() {

      });
      ;
    });


    calendarLanguage.addListener(() {     setState(() {

    });});


    return  Scaffold(
      appBar: AppBar(actions: [ Container(child: IconButton(onPressed: showBottomSheet,icon: Icon(Icons.settings),),),Icon(Icons.add)
      ],),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
            children: [
              Expanded(
                child: EventCalendar(
                  showLoadingForEvent: true,
                  calendarType: typeCalendar.value,
                  calendarLanguage: calendarLanguage.value,
                  calendarOptions: CalendarOptions(viewType: ViewType.MONTHLY,toggleViewType: true),
                ),
              ),
            ] ),
      ),
    );
  }

  openPaltte() {
    return showDialog(

      context: context,
      builder:(context)=> AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Container(
          height: 300,
          // child: SlidePicker(
          //   showSliderText: false,
          //   showParams: false,
          //
          //   pickerColor: pickerColor,
          //   onColorChanged: changeColor,),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: OutlinedButton(

              style: OutlinedButton.styleFrom(
                fixedSize: Size(10, 40),
                shape: CircleBorder(

                ),),
              child:   Icon(Icons.format_paint,color: Colors.cyan,),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                print(currentColor);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}



