import 'home_agent.dart';
import 'details_agent.dart';
import 'daily_updates.dart';
import 'package:flutter/material.dart';
import 'package:cluck_connect/chat/chats.dart';

void main() {
  runApp(const MyApp());
}

class TransactionDetails {
  String farmerName;
  String farmNum;
  String datePlaceholder;
  double amount;

  TransactionDetails({
    required this.farmerName,
    required this.farmNum,
    required this.datePlaceholder,
    required this.amount,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TransactionPageAgent(),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class TransactionPageAgent extends StatefulWidget {
  const TransactionPageAgent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPageAgent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  final List<TransactionDetails> _transactions = [];
  TransactionDetails _currentTransaction = TransactionDetails(
    farmerName: 'Farmer 1',
    farmNum: 'Farm 1',
    datePlaceholder: 'DD/MM/YY',
    amount: 0.0,
  );

  List<String> farmerList = ["Farmer 1", "Farmer 2", "Farmer 3"];
  List<String> farmList = ["Farm 1", "Farm 2", "Farm 3"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/money_trades.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,

                    tabs: const [
                      Tab(
                        text: 'Trade Entry',
                      ),
                      Tab(
                        text: 'View Details',
                      ),
                    ],
                    indicator: const BoxDecoration(
                      color: Colors.blue,
                      
                    ),

                    indicatorColor: Colors.white,
                    // labelColor: Colors.white,
                    unselectedLabelColor: Colors.blue,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildTradeEntryTab(),
              _buildDataTableTab(),
            ],
          ),
        ),
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
  Widget _buildTradeEntryTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFarmNameDropDown(),
          _buildDropDownList(),
          _buildTransactionCard(_currentTransaction),
        ],
      ),
    );
  }

  Widget _buildDataTableTab() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
            ),
            columns: const [
              DataColumn(label: Text('Farmer Name')),
              DataColumn(label: Text('Farm Name')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Amount')),
            ],
            rows: _transactions.map((transaction) {
              return DataRow(
                cells: [
                  DataCell(Text(transaction.farmerName)),
                  DataCell(Text(transaction.farmNum)),
                  DataCell(Text(transaction.amount.toString())),
                  DataCell(Text(transaction.datePlaceholder)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildFarmNameDropDown() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0), 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Select Farmer',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentTransaction.farmerName,
              items: farmerList.map((String farmer) {
                return DropdownMenuItem<String>(
                  value: farmer,
                  child: SizedBox(
                    width: 80.0,
                    child: Text(
                      farmer,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _currentTransaction.farmerName = newValue!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropDownList() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0), 
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Select Farm',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _currentTransaction.farmNum,
              items: farmList.map((String farm) {
                return DropdownMenuItem<String>(
                  value: farm,
                  child: SizedBox(
                    width: 80.0, 
                    child: Text(
                      farm,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _currentTransaction.farmNum = newValue!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCard(TransactionDetails transaction) {
    return Card(
      color: const Color(0xffffffff), 
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trade',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.save, color: Colors.blue),
                  onPressed: () {
                    _saveTransaction(transaction);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller:
                  TextEditingController(text: transaction.datePlaceholder),
              onChanged: (value) {
                transaction.datePlaceholder = value;
              },
              decoration: const InputDecoration(
                labelText: 'Enter Date',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller:
                  TextEditingController(text: transaction.amount.toString()),
              onChanged: (value) {
                transaction.amount = double.tryParse(value) ?? 0.0;
              },
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  void _saveTransaction(TransactionDetails transaction) {
    setState(() {
      _transactions.insert(0, transaction);
      _currentTransaction = TransactionDetails(
        farmerName: 'Farmer 1',
        farmNum: 'Farm 1',
        amount: 0.0,
        datePlaceholder: 'DD/MM/YY',
      );
    });
    _showConfirmation('Transaction saved successfully!');
  }

  void _showConfirmation(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _navigateToScreen(int index) {
    // Add navigation logic based on the index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePageAgent()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AgentStockDisplayPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatUsersPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TransactionPageAgent()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePageAgent()),
        );
        break;
    }
  }
}
