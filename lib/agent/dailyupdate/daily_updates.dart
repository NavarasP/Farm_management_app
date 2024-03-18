import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/agent_api.dart';
import 'package:cluck_connect/services/api/farmers_api.dart';

class FarmDetailsPageagent extends StatefulWidget {
  final farmId;

  const FarmDetailsPageagent({super.key,   required this.farmId});

  @override
  _FarmDetailsPageagentState createState() => _FarmDetailsPageagentState();
}

class _FarmDetailsPageagentState extends State<FarmDetailsPageagent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
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
                _buildReportTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Future<List<dynamic>> fetchFarmReports(String farmId) async {
    try {
      final List<dynamic> farmReports = await FarmApi.getRecordOfFarm(farmId);
      return farmReports;
    } catch (e) {
      debugPrint('Error fetching farm reports: $e');
      throw e;
    }
  }

  Widget _buildReportTab() {
    return FutureBuilder(
      future: fetchFarmReports(widget.farmId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<dynamic> reports = snapshot.data as List<dynamic>;
          if (reports.isEmpty) {
            return Center(
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

  
}
