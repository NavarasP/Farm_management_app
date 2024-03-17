import 'package:flutter/material.dart';



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
        
      ),
    );
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

  const StockEntryCard({super.key, required this.entry});

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
                
                debugPrint('Message acknowledged for ${entry.selectedFarm}');
              },
              child: const Text('Acknowledge'),
            ),
          ],
        ),
      ),
    );
  }
}


