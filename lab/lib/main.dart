import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSports Manager',
      theme: ThemeData(
        primaryColor: Colors.grey[850], // Задаем основной цвет темы как Nardo Grey
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    EventDetailsScreen(),
    StreamsScreen(),
    TeamManagementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eSports Manager'),
      ),
      backgroundColor: Colors.grey,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Event Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Streams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Team Management',
          ),
        ],
      ),
    );
  }
}

class EventDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Center(
        child: Text('Event Details Page'), // Здесь можно отобразить соответствующую информацию
      ),
    );
  }
}

class StreamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Streams'),
      ),
      body: Center(
        child: Text('Streams Page'), // Здесь можно отобразить соответствующую информацию
      ),
    );
  }
}

class TeamManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Management'),
      ),
      body: Center(
        child: Text('Team Management Page'), // Здесь можно отобразить соответствующую информацию
      ),
    );
  }
}
