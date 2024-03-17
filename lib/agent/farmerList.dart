import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/agent_api.dart'; // Import the API service for fetching farmers


class Farmer {
  final String id;
  final String name;
  final String email;

  Farmer({
    required this.id,
    required this.name,
    required this.email,
  });
}


class FarmerListPage extends StatefulWidget {
  const FarmerListPage({Key? key}) : super(key: key);

  @override
  _FarmerListPageState createState() => _FarmerListPageState();
}

class _FarmerListPageState extends State<FarmerListPage> {
  List<Farmer> _farmers = [];

  @override
  void initState() {
    super.initState();
    _fetchFarmers();
  }

Future<void> _fetchFarmers() async {
  try {
    List<Map<String, dynamic>>? farmersData = await AgentApi.fetchFarmers();
    if (farmersData != null) {
      List<Farmer> farmers = farmersData.map((data) => Farmer(
        id: data['_id'],
        name: data['name'],
        email: data['email'],
      )).toList();
      setState(() {
        _farmers = farmers;
      });
    } else {
      throw Exception('Failed to fetch farmers');
    }
  } catch (e) {
    debugPrint("Error fetching farmers: $e");
  }
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('List of Farmers'),
    ),
    body: _farmers.isEmpty
        ? Center(
            child: Text(
              'No farmers available',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: _farmers.length,
            itemBuilder: (context, index) {
              final farmer = _farmers[index];
              return ListTile(
                title: Text(farmer.name),
                subtitle: Text(farmer.email),
                // You can add more information about the farmer here
              );
            },
          ),
  );
}

}
