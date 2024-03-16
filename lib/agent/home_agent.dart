import 'details_agent.dart';
import 'daily_updates.dart';
import 'package:flutter/material.dart';
import 'package:cluck_connect/chat/chats.dart';
import 'package:cluck_connect/services/widgets.dart';
import 'package:cluck_connect/agent/agent_profile.dart';
import 'package:cluck_connect/agent/transaction_agent.dart';

class HomePageAgent extends StatefulWidget {
  const HomePageAgent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageAgentState createState() => _HomePageAgentState();
}

class _HomePageAgentState extends State<HomePageAgent> {
  late int _currentIndex;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pages = [
      Scaffold(
        backgroundColor: const Color(0xffeaf1f6),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 80,
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'CluckConnect',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1560BD),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        debugPrint('Menu button clicked');
                      },
                    ),
                  ],
                ),
              ),
              const Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Color(0xFF1560BD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Welcome to CluckConnect - Your Broiler Farming Companion. '
                              'Track and manage your broiler farm efficiently with our advanced features and insights.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Explore Features',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1560BD),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      child: RectangleCard(
                        title: 'keep monitor your farmers activity',
                        imagePath: 'assets/group.png',
                        onPressed: () {
                          setState(() {
                            _currentIndex = 1; // Navigate to StockDetailsPage
                          });
                          debugPrint('stock details clicked');
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    RectangleCard(
                      title: 'Chat with your Agent ',
                      imagePath: 'assets/chatroom.png',
                      onPressed: () {
                        setState(() {
                          _currentIndex = 2; // Navigate to IncomePage
                        });
                        debugPrint('Financial Transactions clicked');
                      },
                      customImageSize: true,
                    ),
                    const SizedBox(width: 10),
                    RectangleCard(
                      title: 'Financial Transactions',
                      imagePath: 'assets/money_trades.png',
                      onPressed: () {
                        setState(() {
                          _currentIndex = 3; // Navigate to ChatRoomScreen
                        });
                        debugPrint('Chat with Farmers clicked');
                      },
                      customImageSize: true,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: RectangleCard(
                        title: 'Update your information',
                        imagePath: 'assets/profile.png',
                        onPressed: () {
                          setState(() {
                            _currentIndex = 4; // Navigate to ChatRoomScreen
                          });
                          debugPrint('Chat with Farmers clicked');
                        },
                        customImageSize: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Image.asset(
                'assets/broiler_farm.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      const AgentStockDisplayPage(),
      const ChatUsersPage(),
      const TransactionPageAgent(),
      const ProfilePageAgent(),
    ];
  }
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xfff3faff),
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color(0xff393737),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
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
            icon: Icon(Icons.details),
            label: 'Me',
          ),
          
          
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  
}
