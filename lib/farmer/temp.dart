// import 'package:flutter/material.dart';
// import 'package:cluck_connect/farmer/home_farmer.dart';
// import 'package:cluck_connect/services/api/chat_api.dart';
// import 'package:cluck_connect/services/api/farmers_api.dart';
// import 'package:cluck_connect/services/api_models/farmer_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart'; // Import DateFormat
// // import 'package:cluck_connect/services/api/farmers_api.dart';
// // import 'package:your_api_package'; // Import your API package
// // import 'package:cluck_connect/services/models/farmer_model.dart';
// // import 'package:your_app/services/api.dart'; // Import the API file

// // Future<List<Farm>> fetchFarms() async {
// //   try {
// //     List<Farm> farms = await FarmApi.getListOfFarmsForFarmer();
// //     return farms;
// //   } catch (e) {
// //     throw Exception('Failed to load farms: $e');
// //   }
// // }

// // class StockDetailsPage extends StatefulWidget {
// //   const StockDetailsPage({Key? key});

// //   @override
// //   _StockDetailsPageState createState() => _StockDetailsPageState();
// // }

// // class _StockDetailsPageState extends State<StockDetailsPage>
// //     with SingleTickerProviderStateMixin {
// //   late TabController _tabController;
// //   Farm? selectedFarm;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 2, vsync: this);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       length: 2,
// //       child: Scaffold(
// //         body: NestedScrollView(
// //           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
// //             return [
// //               SliverAppBar(
// //                 expandedHeight: 200.0,
// //                 floating: false,
// //                 pinned: true,
// //                 flexibleSpace: FarmFlexibleSpaceBar(
// //                   selectedFarm: selectedFarm,
// //                   onChanged: (Farm? value) {
// //                     if (value != null) {
// //                       setState(() {
// //                         selectedFarm = value;
// //                       });
// //                     }
// //                   },
// //                 ),
// //               ),
// //               SliverPersistentHeader(
// //                 delegate: _SliverAppBarDelegate(
// //                   TabBar(
// //                     controller: _tabController,
// //                     tabs: const [
// //                       Tab(
// //                         text: 'Enter Data',
// //                       ),
// //                       Tab(
// //                         text: 'Report',
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 pinned: true,
// //               ),
// //             ];
// //           },
// //           body: TabBarView(
// //             controller: _tabController,
// //             children: [
// //               _buildEnterDataTab(),
// //               _buildReportTab(),
// //             ],
// //           ),
// //         ),
// //         floatingActionButton: FloatingActionButton(
// //           onPressed: () {
// //             _createNewFarm();
// //           },
// //           child: Icon(Icons.add),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildEnterDataTab() {
// //     return SingleChildScrollView(
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             _buildFarmSelector(),
// //             const SizedBox(height: 8),
// //             _buildCurrentBatchDataEntryCard(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildReportTab() {
// //     return SingleChildScrollView(
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: _buildDataTable(selectedFarm?.id),
// //       ),
// //     );
// //   }

// //   Widget _buildFarmSelector() {
// //     return FutureBuilder<List<Farm>>(
// //       future: fetchFarms(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return CircularProgressIndicator();
// //         } else if (snapshot.hasError) {
// //           return Text('Error: ${snapshot.error}');
// //         } else {
// //           List<Farm>? farms = snapshot.data;
// //           return Card(
// //             elevation: 2,
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 children: [
// //                   InputDecorator(
// //                     decoration: const InputDecoration(
// //                       labelText: 'Select Farm',
// //                       border: OutlineInputBorder(
// //                         borderSide: BorderSide(color: Colors.blue),
// //                       ),
// //                     ),
// //                     child: DropdownButtonHideUnderline(
// //                       child: DropdownButton<Farm>(
// //                         value: selectedFarm,
// //                         isDense: true,
// //                         onChanged: (Farm? value) {
// //                           if (value != null) {
// //                             setState(() {
// //                               selectedFarm = value;
// //                             });
// //                           }
// //                         },
// //                         items: farms!.map((Farm farm) {
// //                           return DropdownMenuItem<Farm>(
// //                             value: farm,
// //                             child: Text(farm.area),
// //                           );
// //                         }).toList(),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }
// //       },
// //     );
// //   }

// //   Widget _buildCurrentBatchDataEntryCard() {
// //     return BatchDataEntryCard(
// //       onSave: (entry) {
// //         debugPrint('Entry saved: $entry');
// //       },
// //       selectedFarm: selectedFarm,
// //     );
// //   }

// //   Widget _buildDataTable(String? farmId) {
// //     // Implement fetching and displaying farm reports based on farmId
// //     return Container(
// //       child: Text('Farm Report for farm ID: $farmId'),
// //     );
// //   }

// //   Future<void> _createNewFarm() async {
// //     try {
// //       await FarmApi.createFarm('AreaName');
// //       // Refresh the farm list after creating a new farm
// //       setState(() {});
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('New farm created successfully')),
// //       );
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Failed to create new farm: $e')),
// //       );
// //     }
// //   }
// // }

// // class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
// //   final TabBar tabBar;

// //   _SliverAppBarDelegate(this.tabBar);

// //   @override
// //   double get minExtent => tabBar.preferredSize.height;

// //   @override
// //   double get maxExtent => tabBar.preferredSize.height;

// //   @override
// //   Widget build(
// //       BuildContext context, double shrinkOffset, bool overlapsContent) {
// //     return Container(
// //       color: Colors.blue,
// //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //       child: tabBar,
// //     );
// //   }

// //   @override
// //   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
// //     return false;
// //   }
// // }

// // class FarmFlexibleSpaceBar extends StatelessWidget {
// //   final Farm? selectedFarm;
// //   final Function(Farm?)? onChanged;

// //   const FarmFlexibleSpaceBar({Key? key, this.selectedFarm, this.onChanged});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         DropdownButton<Farm>(
// //           value: selectedFarm,
// //           onChanged: onChanged,
// //           items: [],
// //         ),
// // FlexibleSpaceBar(
// //   background: Image.asset(
// //     'assets/farm.png',
// //     fit: BoxFit.cover,
// //   ),
// //   centerTitle: true,
// // ),
// //       ],
// //     );
// //   }
// // }

// // class BatchDataEntryCard extends StatefulWidget {
// //   final Function(Map<String, dynamic>) onSave;
// //   final Farm? selectedFarm;

// //   const BatchDataEntryCard({
// //     Key? key,
// //     required this.onSave,
// //     required this.selectedFarm,
// //   });

// //   @override
// //   _BatchDataEntryCardState createState() => _BatchDataEntryCardState();
// // }

// // class _BatchDataEntryCardState extends State<BatchDataEntryCard> {

// //   @override
// //   void initState() {
// //     super.initState();
// //     currentEntry = FarmReport(
// //       totalChicks: 0,
// //       removedChick: 0,
// //       foodStock: '',
// //       medicineOne: '',
// //       medicineTwo: '',
// //       importDate: DateTime.now(),
// //       exportDate: DateTime.now(),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       color: Colors.white,
// //       margin: const EdgeInsets.symmetric(vertical: 8.0),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 const Text(
// //                   "Stock Entry",
// //                   style: TextStyle(
// //                     fontSize: 20.0,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Row(
// //                   children: [
// //                     IconButton(
// //                       icon: const Icon(Icons.save, color: Colors.blue),
// //                       onPressed: _saveData, // Call _saveData function on button press
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 8),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: TextEditingController(
// //                         text: currentEntry.totalChick.toString()),
// //                     onChanged: (value) =>
// //                         currentEntry.totalChick = int.tryParse(value) ?? 0,
// //                     decoration: const InputDecoration(
// //                       labelText: 'Total Chick',
// //                       border: OutlineInputBorder(
// //                         borderSide: BorderSide(color: Colors.blue),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 Expanded(
// //                   child: TextField(
// //                     controller: TextEditingController(
// //                         text: currentEntry.removedChick.toString()),
// //                     onChanged: (value) =>
// //                         currentEntry.removedChick = int.tryParse(value) ?? 0,
// //                     decoration: const InputDecoration(
// //                       labelText: 'Removed Chick',
// //                       border: OutlineInputBorder(
// //                         borderSide: BorderSide(color: Colors.blue),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 8),
// //             TextField(
// //               controller: TextEditingController(text: currentEntry.foodStock),
// //               onChanged: (value) => currentEntry.foodStock = value,
// //               decoration: const InputDecoration(
// //                 labelText: 'Food Stock',
// //                 border: OutlineInputBorder(
// //                   borderSide: BorderSide(color: Colors.blue),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             TextField(
// //               controller: TextEditingController(text: currentEntry.medicineOne),
// //               onChanged: (value) => currentEntry.medicineOne = value,
// //               decoration: const InputDecoration(
// //                 labelText: 'Medicine Dose 1',
// //                 border: OutlineInputBorder(
// //                   borderSide: BorderSide(color: Colors.blue),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             TextField(
// //               controller: TextEditingController(text: currentEntry.medicineTwo),
// //               onChanged: (value) => currentEntry.medicineTwo = value,
// //               decoration: const InputDecoration(
// //                 labelText: 'Medicine Dose 2',
// //                 border: OutlineInputBorder(
// //                   borderSide: BorderSide(color: Colors.blue),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _saveData() async {
// //     try {
// //       final importDate = DateFormat('yyyy/MM/dd').format(currentEntry.importDate);
// //       final exportDate = DateFormat('yyyy/MM/dd').format(currentEntry.exportDate);
// //       final totalChicks = currentEntry.totalChicks;
// //       final removedChick = currentEntry.removedChick;
// //       final foodStock = currentEntry.foodStock;
// //       final medicineOne = currentEntry.medicineOne;
// //       final medicineTwo = currentEntry.medicineTwo;

// //       // Call the API function to save data
// //       final response = await YourAPI.createRecord(
// //         importDate,
// //         exportDate,
// //         totalChicks,
// //         removedChick,
// //         foodStock,
// //         medicineOne,
// //         medicineTwo,
// //       );

// //       // Pass response data to the callback
// //       widget.onSave(response);
// //     } catch (e) {
// //       // Handle error
// //     }
// //   }
// // }

// Future<List<Farm>> fetchFarms() async {
//   try {
//     List<Farm> farms = await FarmApi.getListOfFarmsForFarmer();
//     return farms;
//   } catch (e) {
//     throw Exception('Failed to load farms: $e');
//   }
// }

// Future<List<dynamic>> fetchFarmReports(farmId) async {
//   try {
//     // Call your API function here and pass the farmId
//     List<dynamic> reports = await FarmApi.getRecordOfFarm(farmId);
//     return reports;
//   } catch (e) {
//     throw Exception('Failed to fetch farm reports: $e');
//   }
// }

// class StockDetailsPage extends StatefulWidget {
//   const StockDetailsPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _StockDetailsPageState createState() => _StockDetailsPageState();
// }

// class _StockDetailsPageState extends State<StockDetailsPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Farm? selectedFarm;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(selectedFarm != null ? selectedFarm!.area : 'Select Farm'),
//       ),
//       body: Column(
//         children: [
//           _buildFarmSelector(),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildEnterDataTab(),
//                 _buildReportTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _createNewFarm();
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildEnterDataTab() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Add your form fields to collect data
//             ElevatedButton(
//               onPressed: () {
//                 _submitData(); // Call function to submit data
//               },
//               child: const Text('Submit Data'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildReportTab() {
//     return FutureBuilder(
//       future: fetchFarmReports(selectedFarm?.id),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<dynamic> reports = snapshot.data as List<dynamic>;
//           // Display fetched reports
//           return ListView.builder(
//             itemCount: reports.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('Report ${index + 1}'),
//                 // Display report details here
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildFarmSelector() {
//     return FutureBuilder<List<Farm>>(
//       future: fetchFarms(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Farm>? farms = snapshot.data;
//           return Card(
//             elevation: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   InputDecorator(
//                     decoration: const InputDecoration(
//                       labelText: 'Select Farm',
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue),
//                       ),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<Farm>(
//                         value: selectedFarm,
//                         isDense: true,
//                         onChanged: (Farm? value) {
//                           if (value != null) {
//                             setState(() {
//                               selectedFarm = value;
//                             });
//                           }
//                         },
//                         items: farms!.map((Farm farm) {
//                           return DropdownMenuItem<Farm>(
//                             value: farm,
//                             child: Text(farm.area),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

//   Future<void> _createNewFarm() async {
//     try {
//       await FarmApi.createFarm('AreaName');
//       // Refresh the farm list after creating a new farm
//       setState(() {});
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('New farm created successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to create new farm: $e')),
//       );
//     }
//   }

//   Future<void> _submitData() async {
//     try {
//       // Example data for submitting
//       final Map<String, dynamic> data = {
//         "importDate": "2024/02/16",
//         "exportDate": "2024/02/29",
//         "totalChicks": 95,
//         "removedChick": 5,
//         "foodStock": "Chick Food",
//         "medicineOne": "Medicine 1",
//         "medicineTwo": ""
//       };

//       // Replace the below call with your actual API call
//       await FarmApi.createRecord(
//         'your_token',
//         data['importDate'],
//         data['exportDate'],
//         data['totalChicks'],
//         data['removedChick'],
//         data['foodStock'],
//         data['medicineOne'],
//         data['medicineTwo'],
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Data submitted successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to submit data: $e')),
//       );
//     }
//   }
// }
// items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.business),
//                 label: 'Updates',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.chat),
//                 label: 'Chat Room',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.monetization_on),
//                 label: 'Transaction',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Me',
//               ),
//             ],













//             import 'package:flutter/material.dart';

// class ChatRoomScreen extends StatefulWidget {
//   const ChatRoomScreen({Key? key, required this.chatRoomId}) : super(key: key);

//   final String chatRoomId;

//   @override
//   _ChatRoomScreenState createState() => _ChatRoomScreenState();
// }

// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<Message> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     // fetchMessages(widget.chatRoomId); // Fetch messages when the screen is initialized
//   }

//   // void sendMessage(String message) async {
//   //   try {
//   //     // Send message to the current chat room
//   //     await ChatService.sendMessage(widget.chatRoomId, message);
//   //     // After sending the message, fetch updated messages
//   //     // fetchMessages(widget.chatRoomId);
//   //   } catch (e) {
//   //     debugPrint("Error sending message: $e");
//   //   }
//   // }

//   // void fetchMessages(String chatId) async {
//   //   try {
//   //     // Fetch all messages of the current chat room
//   //     Map<String, dynamic> fetchMessagesResponse = (await ChatService.fetchChatMessages(chatId)) as Map<String, dynamic>;
//   //     List<dynamic> messageData = fetchMessagesResponse['data'];
//   //     setState(() {
//   //       _messages.clear();
//   //       _messages.addAll(messageData.map((messageJson) => Message.fromJson(messageJson)));
//   //     });
//   //   } catch (e) {
//   //     debugPrint("Error fetching messages: $e");
//   //   }
//   // }

//   void _sendMessage() {
//     String messageText = _messageController.text.trim();
//     if (messageText.isNotEmpty) {
//       debugPrint("messga esnd");
//       // sendMessage(messageText);
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 231, 237, 241),
//       appBar: PreferredSize(
//         preferredSize:
//             Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Chat Room',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _messages.isEmpty
//                 ? Center(
//                     child: Text(
//                       'No messages available',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   )
//                 : ListView.builder(
//                     reverse: true,
//                     itemCount: _messages.length,
//                     itemBuilder: (context, index) {
//                       var message = _messages[index];
//                       return Align(
//                         alignment: Alignment.centerRight,
//                         child: Container(
//                           margin: const EdgeInsets.all(8.0),
//                           padding: const EdgeInsets.all(12.0),
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Text(
//                             '${message.senderEmail}: ${message.content}',
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20.0),
//                       border: Border.all(color: Colors.blue),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _messageController,
//                             decoration: const InputDecoration(
//                               hintText: 'Type your message...',
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.all(10.0),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send, color: Colors.blue),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Message {
//   final String senderEmail;
//   final String content;

//   Message({required this.senderEmail, required this.content});

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       senderEmail: json['sender']['email'],
//       content: json['content'],
//     );
//   }
// }
