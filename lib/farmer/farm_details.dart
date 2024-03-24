import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/farmers_api.dart';

class FarmDetailsPage extends StatefulWidget {
  final String farmId;

  const FarmDetailsPage({super.key, required this.farmId});

  @override
  // ignore: library_private_types_in_public_api
  _FarmDetailsPageState createState() => _FarmDetailsPageState();
}

class _FarmDetailsPageState extends State<FarmDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Details',style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Enter Data'),
            Tab(text: 'Reports'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEnterDataTab(),
                _buildReportTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnterDataTab() {
    TextEditingController importDateController = TextEditingController();
    TextEditingController exportDateController = TextEditingController();
    TextEditingController totalChicksController = TextEditingController();
    TextEditingController removedChickController = TextEditingController();
    TextEditingController foodStockController = TextEditingController();
    TextEditingController medicineOneController = TextEditingController();
    TextEditingController medicineTwoController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: importDateController,
              decoration: const InputDecoration(labelText: 'Import Date YYYY/MM/DD'),
            ),
            TextFormField(
              controller: exportDateController,
              decoration: const InputDecoration(labelText: 'Export Date YYYY/MM/DD'),
            ),
            TextFormField(
              controller: totalChicksController,
              decoration: const InputDecoration(labelText: 'Total Chicks'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: removedChickController,
              decoration: const InputDecoration(labelText: 'Removed Chicks'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: foodStockController,
              decoration: const InputDecoration(labelText: 'Food Stock'),
            ),
            TextFormField(
              controller: medicineOneController,
              decoration: const InputDecoration(labelText: 'Medicine 1'),
            ),
            TextFormField(
              controller: medicineTwoController,
              decoration: const InputDecoration(labelText: 'Medicine 2'),
            ),
            ElevatedButton(
              onPressed: () {
                _submitData(
                  widget.farmId,
                  importDateController.text,
                  exportDateController.text,
                  int.tryParse(totalChicksController.text) ?? 0,
                  int.tryParse(removedChickController.text) ?? 0,
                  foodStockController.text,
                  medicineOneController.text,
                  medicineTwoController.text,
                );
              },
              child: const Text('Submit Data'),
            ),
          ],
        ),
      ),
    );
  }


  Future<List<dynamic>> fetchFarmReports() async {
    try {
      final List<dynamic> farmReports = await FarmApi.getRecordOfFarm(widget.farmId);
      return farmReports;
    } catch (e) {
      debugPrint('Error fetching farm reports: $e');
      rethrow;
    }
  }

  Widget _buildReportTab() {
    return FutureBuilder(
      future: fetchFarmReports(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<dynamic> reports = snapshot.data as List<dynamic>;
          if (reports.isEmpty) {
            return const Center(
              child: Text('No reports available'),
            );
          } else {
            return ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Card(
                  child: ListTile(
                    title: Text('Report ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Import Date: ${report['importDate']}'),
                        Text('Export Date: ${report['exportDate']}'),
                        Text('Total Chicks: ${report['totalChicks']}'),
                        Text('Removed Chick: ${report['removedChick']}'),
                        Text('Food Stock: ${report['foodStock']}'),
                        Text('Medicine One: ${report['medicineOne']}'),
                        Text('Medicine Two: ${report['medicineTwo']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }

  void _submitData(
    String farmId,
    String importDate,
    String exportDate,
    int totalChicks,
    int removedChick,
    String foodStock,
    String medicineOne,
    String medicineTwo,
  ) {
    Map<String, dynamic> formData = {
      'importDate': importDate,
      'exportDate': exportDate,
      'totalChicks': totalChicks,
      'removedChick': removedChick,
      'foodStock': foodStock,
      'medicineOne': medicineOne,
      'medicineTwo': medicineTwo,
    };
    String jsonData = jsonEncode(formData);

    FarmApi.createReport(farmId, jsonData).then((response) {
      debugPrint('Farm created successfully: $response');
          setState(() {
fetchFarmReports();
});

    }).catchError((error) {
      debugPrint('Error creating farm: $error');
    });
  }
}
