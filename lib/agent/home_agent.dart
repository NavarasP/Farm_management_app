import 'details_agent.dart';
import 'daily_updates.dart';
import 'chatroom_agent.dart';
import 'package:flutter/material.dart';
import 'package:cluck_connect/agent/transaction_agent.dart';



class HomePageAgent extends StatelessWidget {
  const HomePageAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      // Handle menu button click
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AgentStockDisplayPage()),
                        );
                        debugPrint('stock details clicked');
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  RectangleCard(
                    title: 'Chat with your Agent ',
                    imagePath: 'assets/chatroom.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Chatroom()),
                      );
                      debugPrint('Chat with Farmers clicked');
                    },
                  ),
                  const SizedBox(width: 10),
                  RectangleCard(
                    title: 'Financial Transactions',
                    imagePath: 'assets/money_trades.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TransactionPageAgent()),
                      );
                      debugPrint('Financial Transactions clicked');
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePageAgent()),
                        );
                        debugPrint('Profile Management clicked');
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
    );
  }
}

class RectangleCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;
  final bool customImageSize;

  const RectangleCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    this.customImageSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, 
      height: 200, 

      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          color: const Color(0xfff2f4f6),
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  height: customImageSize
                      ? 100
                      : 80, 
                  width: customImageSize
                      ? 100
                      : 80, 
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

