import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/agent_api.dart'; 
import 'package:cluck_connect/agent/dailyupdate/daily_updates.dart';
class Farm {
  final String id;
  final String area;

  Farm({
    required this.id,
    required this.area,
  });
}




class FarmListPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final farmerid;
  
  // ignore: prefer_typing_uninitialized_variables
  final farmername;

  const FarmListPage({super.key, required this.farmerid, required this.farmername});

  @override
  // ignore: library_private_types_in_public_api
  _FarmListPageState createState() => _FarmListPageState();
}

class _FarmListPageState extends State<FarmListPage> {
  List<Farm> _farms = [];

  @override
  void initState() {
    super.initState();
    _fetchFarms(widget.farmerid);
  }

  Future<void> _fetchFarms(String farmerId) async {
    try {
      List<Map<String, dynamic>>? farmsData = await AgentApi.fetchFarms(farmerId);
      if (farmsData != null) {
        List<Farm> farms = farmsData.map((data) => Farm(
          id: data['_id'],
          area: data['area'],
        )).toList();
        setState(() {
          _farms = farms;
        });
      } else {
        throw Exception('Failed to fetch farms');
      }
    } catch (e) {
      debugPrint("Error fetching farms: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farms for ${widget.farmername}',style: TextStyle(
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
      ),
      body: _farms.isEmpty
        ? Center(
            child: Text(
              'No farms available for ${widget.farmername}',
              style: const TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: _farms.length,
            itemBuilder: (context, index) {
              final farm = _farms[index];
              return ListTile(
                title: Text(farm.area),
                // subtitle: Text(farm.location),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FarmDetailsPageagent( farmId: farm.id),
                    ),
                  );
                },
              );
            },
          ),
    );
  }
}
