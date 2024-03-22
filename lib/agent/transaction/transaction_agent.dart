import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/agent_api.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';

class TransactionDetails {
  String farmerName;
  String farmNum;
  String datePlaceholder;
  double amount;

  TransactionDetails({
    required this.farmerName,
    required this.farmNum,
    required this.datePlaceholder,
    required this.amount,
  });
}

class TransactionPage extends StatefulWidget {
  final String farmId;
  final String farmerId;
  final String farmerName;

  const TransactionPage({
    super.key,
    required this.farmId,
    required this.farmerId,
    required this.farmerName,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<TransactionDetails> _transactions = [];
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }


  Future<void> _loadTransactions() async {
    try {
      List<TransactionDetails> transactions = []; // Create an empty list to store transactions

      Map<String, dynamic> transactionsData =
          await AgentApi.getTransaction(widget.farmId);

      // Check if the response contains the key "status" and its value is "success"
      if (transactionsData.containsKey('status') &&
          transactionsData['status'] == 'success') {
        // Check if the response contains the key "data" and its value is a list
        if (transactionsData.containsKey('data') &&
            transactionsData['data'] is List) {
          // Iterate over the list of transactions data
          List<dynamic> transactionsList = transactionsData['data'];
          for (var transactionData in transactionsList) {
            // Fetch farmer name and add it to transactions list
            Map<String, dynamic> farmerData =
                await AuthenticationApi.getname(transactionData['farmer']);
                Map<String, dynamic> farmData =
                await AgentApi.getFarmName(transactionData['farm']);
            transactions.add(TransactionDetails(
              farmerName: farmerData.containsKey('data')
                  ? farmerData['data']
                  : 'Unknown',
              farmNum: farmData.containsKey('data')
                  ? farmData['data']
                  : 'Unknown',
              datePlaceholder: transactionData['createdAt'],
              amount: double.parse(transactionData['amount'].toString()),
            ));
          }
        }
      }


    setState(() {
      _transactions = transactions;
    });
  } catch (e) {
    debugPrint("Error loading transactions: $e");
    // Optionally, show a snackbar or dialog to inform the user about the error
  }
}

  Future<void> _submitTransactionData() async {
    debugPrint("button");
    try {
      double amount = double.parse(_amountController.text);
      // Assuming you have the date and amount data available
      await AgentApi.createTransaction(
          amount, widget.farmerId, widget.farmId, true, true);
      // Assuming createTransaction is a method in AgentApi to submit the transaction data
    } catch (e) {
      debugPrint("Error submitting transaction data: $e");
    }
    debugPrint("finin");

    setState(() {
    _loadTransactions();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions for ${widget.farmerName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Farmer Name')),
                  DataColumn(label: Text('Farm Name')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Date')),
                  
                ],
                rows: _transactions.map((transaction) {
                  return DataRow(
                    cells: [
                      DataCell(Text(transaction.farmerName)),
                      DataCell(Text(transaction.farmNum)),
                      DataCell(Text(transaction.amount.toString())),
                      DataCell(Text(transaction.datePlaceholder)),
                      
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trade',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Enter Amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: _submitTransactionData,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
