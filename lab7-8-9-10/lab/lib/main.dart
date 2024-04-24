import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

List<User> registeredUsers = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSports Manager',
      theme: ThemeData(
        primaryColor: Colors.grey[850],
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter your password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true; // Показываем индикатор загрузки
                });
                bool isValid = checkCredentials(
                  _nameController.text,
                  _passwordController.text,
                );
                if (isValid) {
                  // После 2 секунд выключаем индикатор загрузки
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(name: _nameController.text),
                      ),
                    );
                  });
                } else {
                  setState(() {
                    _isLoading = false; // Пользователь ввел неправильные учетные данные, поэтому отключаем индикатор загрузки
                  });
                  showErrorMessage(context);
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                ).then((value) {
                  setState(() {});
                });
              },
              child: Text('Register'),
            ),
            // Отображаем индикатор загрузки, если пользователь в процессе входа
            if (_isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  bool checkCredentials(String name, String password) {
    return registeredUsers.any((user) => user.name == name && user.password == password);
  }

  void showErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Invalid username or password.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class User {
  final String name;
  final String password;

  User({required this.name, required this.password});
}

class RegistrationPage extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter your password',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                String password = _passwordController.text;

                registeredUsers.add(User(name: name, password: password));

                Navigator.pop(context);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final String name;

  MainScreen({required this.name});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    EventDetailsScreen(),
    StreamsScreen(),
    TeamManagementScreen(),
    TopFansScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('eSports Manager'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
          ),
          IconButton(
            icon: IconWithHover(
              icon: Icons.menu,
              scale: 1.5,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey,
      body: _screens[_currentIndex],
      bottomNavigationBar: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: BottomNavigationBar(
          key: ValueKey<int>(_currentIndex),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: IconWithHover(
                icon: Icons.event,
                scale: 1.5,
              ),
              label: 'Event Details',
            ),
            BottomNavigationBarItem(
              icon: IconWithHover(
                icon: Icons.live_tv,
                scale: 1.5,
              ),
              label: 'Streams',
            ),
            BottomNavigationBarItem(
              icon: IconWithHover(
                icon: Icons.group,
                scale: 1.5,
              ),
              label: 'Team Management',
            ),
            BottomNavigationBarItem(
              icon: IconWithHover(
                icon: Icons.favorite,
                scale: 1.5,
              ),
              label: 'Top Fans',
            ),
          ],
        ),
      ),
      endDrawer: CustomDrawer(name: widget.name),
    );
  }
}

class IconWithHover extends StatefulWidget {
  final IconData icon;
  final double size;
  final double scale;

  IconWithHover({required this.icon, this.size = 24.0, this.scale = 1.0});

  @override
  _IconWithHoverState createState() => _IconWithHoverState();
}

class _IconWithHoverState extends State<IconWithHover> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Icon(
        widget.icon,
        size: _isHovering ? widget.size * widget.scale : widget.size,
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final String name;

  CustomDrawer({required this.name});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupportScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}

class EventDetailsScreen extends StatefulWidget {
  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lucky Ticket to',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _fetchUserData();
              },
              child: Text('LUCKY TICKET TO'),
            ),
            SizedBox(height: 20),
            Text(
              'Fan Email: ${_emailController.text}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Fan Age: ${_ageController.text}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchUserData() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/?results=1'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final userData = jsonResponse['results'][0];
      setState(() {
        _emailController.text = userData['email'];
        _ageController.text = userData['dob']['age'].toString();
      });
    } else {
      setState(() {
        _emailController.text = 'Failed to fetch user data';
        _ageController.text = '0';
      });
    }
  }
}

class StreamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Streams'),
      ),
      body: Column(
        children: [],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'NaVi champion major',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          PlayerListItem(name: 'b1t Валерий Ваховский'),
          PlayerListItem(name: 'Aleksib Алекси Виролайнен'),
          PlayerListItem(name: 'jL Джустинас Лекавичус'),
          PlayerListItem(name: 'iM Иван Михай'),
          PlayerListItem(name: 'wonderful Ihor Zhdanov'),
        ],
      ),
    );
  }
}

class PlayerListItem extends StatelessWidget {
  final String name;

  PlayerListItem({required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
      ),
      body: Center(
        child: Text('Support Screen'),
      ),
    );
  }
}

class TopFansScreen extends StatefulWidget {
  @override
  _TopFansScreenState createState() => _TopFansScreenState();
}

class _TopFansScreenState extends State<TopFansScreen> {
  List<Fan> _fans = [];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _donatesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Fans'),
      ),
      body: ListView.builder(
        itemCount: _fans.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_fans[index].name),
            subtitle: Text(_fans[index].email),
            trailing: Text(_fans[index].donates.toString()),
            onTap: () {
              // Handle delete fan here
              _deleteFan(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addFan();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addFan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Fan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _donatesController,
                  decoration: InputDecoration(labelText: 'Donates'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _fans.add(
                    Fan(
                      name: _nameController.text,
                      email: _emailController.text,
                      donates: int.tryParse(_donatesController.text) ?? 0,
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteFan(int index) {
    setState(() {
      _fans.removeAt(index);
    });
  }
}

class Fan {
  final String name;
  final String email;
  final int donates;

  Fan({required this.name, required this.email, required this.donates});
}
