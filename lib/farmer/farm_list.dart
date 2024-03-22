import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/farmers_api.dart';
import 'package:cluck_connect/services/api_models/farmer_model.dart';
import 'package:cluck_connect/farmer/farm_details.dart'; // Import the next page

class StockDetailsPage extends StatefulWidget {
  const StockDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StockDetailsPageState createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  Farm? selectedFarm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedFarm != null ? selectedFarm!.area : 'Select Farm'),
      ),
      body: Column(
        children: [
          _buildFarmSelector(),
          // Add other widgets here
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewFarmDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Farm>> fetchFarms() async {
    try {
      debugPrint('Fetching farms...');
      List<Farm> farms = await FarmApi.getListOfFarmsForFarmer();
      debugPrint('Farms fetched: $farms');
      return farms;
    } catch (e) {
      debugPrint('Error fetching farms: $e');
      debugPrint('Error fetching farms: $e');
      throw Exception('Failed to load farms: $e');
    }
  }

  Widget _buildFarmSelector() {
    return FutureBuilder<List<Farm>>(
      future: fetchFarms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Farm>? farms = snapshot.data;
          if (farms != null && farms.isNotEmpty) {
            return Expanded(
              child: ListView.builder(
                itemCount: farms.length,
                itemBuilder: (context, index) {
                  Farm farm = farms[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      title: Text(farm.area),
                      onTap: () {
                        setState(() {
                          selectedFarm = farm;
                        });
                        // Navigate to the next page and pass selected farm
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FarmDetailsPage( farmId: farm.id,),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No farms available',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
        }
      },
    );
  }

  // Method to show dialog for creating new farm
  Future<void> _showNewFarmDialog(BuildContext context) async {
    String? newFarmArea;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create New Farm'),
          content: TextFormField(
            onChanged: (value) {
              newFarmArea = value;
            },
            decoration: const InputDecoration(
              labelText: 'Farm Area',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Call the API to create the new farm
                if (newFarmArea != null) {
                  try {
                    await FarmApi.createFarm(newFarmArea!);
                    // Refresh farms list after creating new farm
                    setState(() {});
                  } catch (e) {
                    debugPrint('Error creating farm: $e');
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error creating farm: $e'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
