import 'home_agent.dart';
import 'chatroom_agent.dart';
import '../daily_updates.dart';
import 'transaction_agent.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class ProfileDetails {
  String name = '';
  String gender = '';
  String state = '';
  String contactNumber = '';
}

class FarmDetails {
  int totalFarms = 1;
  List<String> farmLocations = [''];
}

class AgentDetails {
  int noOfFarmers = 1;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePageAgent(),
    );
  }
}

class ProfilePageAgent extends StatefulWidget {
  @override
  _ProfilePageAgentState createState() => _ProfilePageAgentState();
}

class _ProfilePageAgentState extends State<ProfilePageAgent> {
  late ProfileDetails profileDetails;
  late FarmDetails farmDetails;
  late AgentDetails agentDetails;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    profileDetails = ProfileDetails();
    farmDetails = FarmDetails();
    agentDetails = AgentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Details',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => profileDetails.name = value,
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Gender:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 16),
                Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: profileDetails.gender,
                      onChanged: (value) {
                        setState(() {
                          profileDetails.gender = value.toString();
                        });
                      },
                    ),
                    Text('Male'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Female',
                      groupValue: profileDetails.gender,
                      onChanged: (value) {
                        setState(() {
                          profileDetails.gender = value.toString();
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => profileDetails.state = value,
              decoration: InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => profileDetails.contactNumber = value,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Agent Details',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) =>
                  agentDetails.noOfFarmers = int.tryParse(value) ?? 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Farmers Under You',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 18),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePageAgent()),
                  );
                  print('Profile Details: $profileDetails');
                  print('Agent Details: $agentDetails');
                },
                child: Text('Save Details'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xfff3faff),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Color(0xff393737),
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
                _navigateToScreen(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Farmer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat Room',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                label: 'Transaction',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Me',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(int index) {
    // Add navigation logic based on the index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageAgent()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AgentStockDisplayPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Chatroom()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TransactionPageAgent()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePageAgent()),
        );
        break;
    }
  }
}

