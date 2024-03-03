import 'home_farmer.dart';
import 'details_farmer.dart';
import 'chatpage_farmer.dart';
import 'stockdetails_farmer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class TransactionDetails {
  String datePlaceholder;
  double amount;

  TransactionDetails({
    required this.datePlaceholder,
    required this.amount,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IncomePage(),
    );
  }
}

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final List<TransactionDetails> transactions = [
    TransactionDetails(
      datePlaceholder: 'DD/MM/YY',
      amount: 100.0,
    ),
    TransactionDetails(
      datePlaceholder: 'DD/MM/YY',
      amount: 150.0,
    ),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(250.0),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: Column(
                children: [
                  SizedBox(
                    height: 210.0,
                    child: Image.asset(
                      'assets/trade_appbar.jpg', 
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.blue, 
            ),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Your Income',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionCard(transaction: transactions[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xfff3faff),
            selectedItemColor: Colors.blue,
            unselectedItemColor: const Color(0xff393737),
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
                _navigateToScreen(index);
              });
            },
            items: const [
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
          MaterialPageRoute(builder: (context) => const HomePageFarmer()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StockDetailsPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatRoomScreen()),
        );
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const IncomePage()));
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePageFarmer()),
        );
        break;
    }
  }
}

class TransactionCard extends StatefulWidget {
  final TransactionDetails transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  bool isAcknowledged = false;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: const Color(0xff9fcce1), 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${widget.transaction.datePlaceholder}'),
            const SizedBox(height: 8),
            Text('Amount: ₹${widget.transaction.amount.toString()}'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAcknowledged = !isAcknowledged;
                    });
                  },
                  child: Container(
                    color: isAcknowledged ? Colors.green : Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          isAcknowledged ? 'Acknowledged' : 'Not Acknowledged',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCompleted = !isCompleted;
                    });
                  },
                  child: Container(
                    color: isCompleted ? Colors.green : Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          isCompleted ? 'Complete' : 'Not Complete',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

