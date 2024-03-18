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
  final farmerid;
  
  final farmername;

  const FarmListPage({Key? key, required this.farmerid, required this.farmername}) : super(key: key);

  @override
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
        title: Text('Farms for ${widget.farmername}'),
      ),
      body: _farms.isEmpty
        ? Center(
            child: Text(
              'No farms available for ${widget.farmername}',
              style: TextStyle(fontSize: 18),
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
