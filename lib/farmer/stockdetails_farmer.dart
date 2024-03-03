import 'home_farmer.dart';
import 'details_farmer.dart';
import 'chatpage_farmer.dart';
import 'transaction_farmer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StockDetailsPage(),
    );
  }
}

class StockDetailsPage extends StatefulWidget {
  @override
  _StockDetailsPageState createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedFarm = 'Farm 1';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FarmFlexibleSpaceBar(selectedFarm: selectedFarm),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: 'Enter Data',
                      ),
                      Tab(
                        text: 'Report',
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildEnterDataTab(),
              _buildReportTab(),
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

  Widget _buildEnterDataTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFarmSelector(),
            SizedBox(height: 8),
            _buildCurrentBatchDataEntryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildDataTable(),
      ),
    );
  }

  Widget _buildFarmSelector() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Select Farm',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedFarm,
                  isDense: true,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedFarm = value;
                      });
                    }
                  },
                  items: [
                    'Farm 1',
                    'Farm 2',
                    'Farm 3',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentBatchDataEntryCard() {
    return BatchDataEntryCard(
      onSave: (entry) {
        print('Entry saved: $entry');
      },
      selectedFarm: selectedFarm,
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            child: DataTable(
              dividerThickness: 1.0,
              columns: [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Farm No')),
                DataColumn(label: Text('Import Date')),
                DataColumn(label: Text('Total Chick')),
                DataColumn(label: Text('Deceased')),
                DataColumn(label: Text('Food Stock')),
                DataColumn(label: Text('Medicine Dose 1')),
                DataColumn(label: Text('Medicine Dose 2')),
                DataColumn(label: Text('Export Date')),
                DataColumn(label: Text('Actions')),
              ],
              rows: [], // Empty rows for a fresh table
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class FarmFlexibleSpaceBar extends StatelessWidget {
  final String selectedFarm;

  FarmFlexibleSpaceBar({required this.selectedFarm});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Image.asset(
        'assets/farm.png',
        fit: BoxFit.cover,
      ),
      centerTitle: true,
    );
  }
}

class BatchDataEntryCard extends StatefulWidget {
  final Function(EntryDetails) onSave;
  final String selectedFarm;

  BatchDataEntryCard({
    required this.onSave,
    required this.selectedFarm,
  });

  @override
  _BatchDataEntryCardState createState() => _BatchDataEntryCardState();
}

class _BatchDataEntryCardState extends State<BatchDataEntryCard> {
  late EntryDetails currentEntry;

  @override
  void initState() {
    super.initState();
    currentEntry = EntryDetails(
      totalChick: 0,
      deceased: 0,
      foodStock: '',
      medicine1: '',
      medicine2: '',
      selectedFarm: widget.selectedFarm,
      importDate: DateTime.now(),
      exportDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stock Entry",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.save, color: Colors.blue),
                      onPressed: () {
                        widget.onSave(currentEntry);
                        setState(() {
                          currentEntry = EntryDetails(
                            totalChick: 0,
                            deceased: 0,
                            foodStock: '',
                            medicine1: '',
                            medicine2: '',
                            selectedFarm: widget.selectedFarm,
                            importDate: DateTime.now(),
                            exportDate: DateTime.now(),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(
                        text: currentEntry.totalChick.toString()),
                    onChanged: (value) =>
                        currentEntry.totalChick = int.tryParse(value) ?? 0,
                    decoration: InputDecoration(
                      labelText: 'Total Chick',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(
                        text: currentEntry.deceased.toString()),
                    onChanged: (value) =>
                        currentEntry.deceased = int.tryParse(value) ?? 0,
                    decoration: InputDecoration(
                      labelText: 'Deceased',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: currentEntry.foodStock),
              onChanged: (value) => currentEntry.foodStock = value,
              decoration: InputDecoration(
                labelText: 'Food Stock',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: currentEntry.medicine1),
              onChanged: (value) => currentEntry.medicine1 = value,
              decoration: InputDecoration(
                labelText: 'Medicine Dose 1',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: currentEntry.medicine2),
              onChanged: (value) => currentEntry.medicine2 = value,
              decoration: InputDecoration(
                labelText: 'Medicine Dose 2',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

