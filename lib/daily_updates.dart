import 'agent/home_agent.dart';
import 'agent/details_agent.dart';
import 'agent/chatroom_agent.dart';
import 'agent/transaction_agent.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: AgentStockDisplayPage(),
  ));
}

class EntryDetails {
  int totalChick;
  int deceased;
  String foodStock;
  String medicine1;
  String medicine2;
  String selectedFarm;
  DateTime importDate;
  DateTime exportDate;

  EntryDetails({
    required this.totalChick,
    required this.deceased,
    required this.foodStock,
    required this.medicine1,
    required this.medicine2,
    required this.selectedFarm,
    required this.importDate,
    required this.exportDate,
  });
}

class AgentStockDisplayPage extends StatefulWidget {
  const AgentStockDisplayPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgentStockDisplayPageState createState() => _AgentStockDisplayPageState();
}

class _AgentStockDisplayPageState extends State<AgentStockDisplayPage> {
  List<String> farmerNames = ['Farmer 1', 'Farmer 2', 'Farmer 3'];
  String selectedFarmer = 'Farmer 1'; 
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Monitor your Farmers'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageAgent()),
                );
              },
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Select Farmer',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedFarmer,
                  isDense: true,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedFarmer = value;
                      });
                    }
                  },
                  items: farmerNames.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Expanded(
            child: StockDisplayList(selectedFarmer: selectedFarmer),
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
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: const Color(0xff2e2c2c),
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

  void _navigateToScreen(int index) {
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
          MaterialPageRoute(builder: (context) => const AgentStockDisplayPage()),
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

class StockDisplayList extends StatefulWidget {
  final String selectedFarmer;

  const StockDisplayList({super.key, required this.selectedFarmer});

  @override
  // ignore: library_private_types_in_public_api
  _StockDisplayListState createState() => _StockDisplayListState();
}

class _StockDisplayListState extends State<StockDisplayList> {
  List<EntryDetails> stockEntries = [
    EntryDetails(
      totalChick: 100,
      deceased: 5,
      foodStock: 'Chicken Feed',
      medicine1: 'Medicine A',
      medicine2: 'Medicine B',
      selectedFarm: 'Farmer 1',
      importDate: DateTime.now(),
      exportDate: DateTime.now(),
    ),
    EntryDetails(
      totalChick: 120,
      deceased: 10,
      foodStock: 'Chicken Feed',
      medicine1: 'Medicine A',
      medicine2: 'Medicine B',
      selectedFarm: 'Farmer 2',
      importDate: DateTime.now(),
      exportDate: DateTime.now(),
    ),
    EntryDetails(
      totalChick: 80,
      deceased: 8,
      foodStock: 'Chicken Feed',
      medicine1: 'Medicine A',
      medicine2: 'Medicine B',
      selectedFarm: 'Farmer 3',
      importDate: DateTime.now(),
      exportDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<EntryDetails> filteredEntries = stockEntries
        .where((entry) => entry.selectedFarm == widget.selectedFarmer)
        .toList();

    return ListView.builder(
      itemCount: filteredEntries.length,
      itemBuilder: (context, index) {
        return StockEntryCard(entry: filteredEntries[index]);
      },
    );
  }
}

class StockEntryCard extends StatelessWidget {
  final EntryDetails entry;

  StockEntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.selectedFarm,
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight
                    .bold, 
              ),
            ),
            const SizedBox(height: 8),
            Text('Import Date    : ${entry.importDate}'),
            Text('Total Chick    : ${entry.totalChick}'),
            Text('Deceased       : ${entry.deceased}'),
            Text('Food Stock     : ${entry.foodStock}'),
            Text('Medicine Dose 1: ${entry.medicine1}'),
            Text('Medicine Dose 2: ${entry.medicine2}'),
            Text('Export Date    : ${entry.exportDate}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                
                print('Message acknowledged for ${entry.selectedFarm}');
              },
              child: const Text('Acknowledge'),
            ),
          ],
        ),
      ),
    );
  }
}


