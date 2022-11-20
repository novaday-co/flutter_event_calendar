import 'package:flutter/material.dart';
import 'package:flutter_event_calendar_example/widgets/event_calendar/event_calendar.dart';
import 'package:flutter_event_calendar_example/widgets/setting/setting.dart';
import 'package:flutter_event_calendar_example/widgets/code_preview/code_preview.dart';
class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static  List<Widget> _pageList = <Widget>[
    EventCalendarPage(),
    CodePreview(),
    Setting()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Event Calendar'),
      ),
      body: Center(
        child: _pageList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.calendar_month),
            label: 'preview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'code',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.settings),
            label: 'setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

