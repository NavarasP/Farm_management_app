import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/farmers_api.dart';
import 'package:cluck_connect/services/api_models/farmer_model.dart';



class FarmDetailsPage extends StatefulWidget {
  final String farmId;

  const FarmDetailsPage({Key? key, required this.farmId}) : super(key: key);

  @override
  _FarmDetailsPageState createState() => _FarmDetailsPageState();
}


class _FarmDetailsPageState extends State<FarmDetailsPage>
    with SingleTickerProviderStateMixin {
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
        title: const Text('Farm Details'),
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
          // Flexible(
          //   flex: 2,
          //   child: FlexibleSpaceBar(
          //     background: Image.asset(
          //       'assets/farm.png',
          //       fit: BoxFit.cover,
          //     ),
          //     centerTitle: true,
          //   ),
          // ),
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
            decoration: InputDecoration(labelText: 'Import Date'),
          ),
          TextFormField(
            controller: exportDateController,
            decoration: InputDecoration(labelText: 'Export Date'),
          ),
          TextFormField(
            controller: totalChicksController,
            decoration: InputDecoration(labelText: 'Total Chicks'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: removedChickController,
            decoration: InputDecoration(labelText: 'Removed Chicks'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: foodStockController,
            decoration: InputDecoration(labelText: 'Food Stock'),
          ),
          TextFormField(
            controller: medicineOneController,
            decoration: InputDecoration(labelText: 'Medicine 1'),
          ),
          TextFormField(
            controller: medicineTwoController,
            decoration: InputDecoration(labelText: 'Medicine 2'),
          ),
          ElevatedButton(
            onPressed: () {
              _submitData(
                importDateController.text,
                exportDateController.text,
                int.parse(totalChicksController.text),
                int.parse(removedChickController.text),
                foodStockController.text,
                medicineOneController.text,
                medicineTwoController.text,
              ); // Call function to submit data
            },
            child: const Text('Submit Data'),
          ),
        ],
      ),
    ),
  );
}

  

Widget _buildReportTab() {
  return FutureBuilder(
    future: fetchFarmReports(widget.farmId), // Use widget.farmId to access the farmId passed as an argument
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        List<dynamic> reports = snapshot.data as List<dynamic>;
        if (reports.isEmpty) {
          // If no reports are available, display a message
          return Center(
            child: Text('No reports available'),
          );
        } else {
          // Display fetched reports
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Report ${index + 1}'),
                // Display report details here
              );
            },
          );
        }
      }
    },
  );
}


  // Replace this function with your actual data submission logic
void _submitData(
  String importDate,
  String exportDate,
  int totalChicks,
  int removedChick,
  String foodStock,
  String medicineOne,
  String medicineTwo,
) {
  // Encode form data into JSON format
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

  // Call FarmApi.createFarm method with the JSON data
  FarmApi.createRecord(jsonData).then((response) {
    // Handle response from the API
    // For example, you can show a success message or navigate to another page
    debugPrint('Farm created successfully: $response');
  }).catchError((error) {
    // Handle error from the API
    // For example, you can show an error message
    debugPrint('Error creating farm: $error');
  });
}


  // Replace this function with your actual data fetching logic
Future<List<FarmReport>> fetchFarmReports(String farmId) async {
  // Call getRecordOfFarm and await the result
  List<FarmReport> farmReports = await FarmApi.getRecordOfFarm(farmId);
  
  // Return the fetched farm reports
  return farmReports;
}


}
