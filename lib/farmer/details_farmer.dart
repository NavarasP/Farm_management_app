import 'home_farmer.dart';
import 'chatpage_farmer.dart';
import 'transaction_farmer.dart';
import 'stockdetails_farmer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class ProfileDetails {
  String name = '';
  String gender = '';
  String state = '';
  String contactNumber = '';
  String agentPhoneNumber = '';
}

class FarmDetails {
  int totalFarms = 1;
  List<String> farmLocations = [''];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePageFarmer(),
    );
  }
}

class ProfilePageFarmer extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageFarmer> {
  late ProfileDetails profileDetails;
  late FarmDetails farmDetails;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    profileDetails = ProfileDetails();
    farmDetails = FarmDetails();
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
                labelText: 'Your Contact Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => profileDetails.agentPhoneNumber = value,
              decoration: InputDecoration(
                labelText: "Your Agent's Contact Number",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Farm Details',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Total Number of Farms:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 16),
                DropdownButton<int>(
                  value: farmDetails.totalFarms,
                  items:
                      List.generate(50, (index) => index + 1).map((int number) {
                    return DropdownMenuItem<int>(
                      value: number,
                      child: Text(
                        number.toString(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      farmDetails.totalFarms = value ?? 1;
                      farmDetails.farmLocations =
                          List.generate(farmDetails.totalFarms, (index) => '');
                    });
                  },
                  style: TextStyle(
                    color: Colors.blue, 
                    fontSize: 16, 
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.blue, 
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            for (int i = 0; i < farmDetails.totalFarms; i++) ...[
              Column(
                children: [
                  TextField(
                    onChanged: (value) => farmDetails.farmLocations[i] = value,
                    decoration: InputDecoration(
                      labelText: 'Area of Farm ${i + 1}',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 16), 
                ],
              ),
            ],
            SizedBox(height: 18),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePageFarmer()),
                  );
                  print('Profile Details: $profileDetails');
                  print('Farm Details: $farmDetails');
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
                icon: Icon(Icons.business),
                label: 'Updates',
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
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageFarmer()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StockDetailsPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatRoomScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IncomePage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePageFarmer()),
        );
        break;
    }
  }
}
