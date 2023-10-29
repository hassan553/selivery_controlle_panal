import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
late SharedPreferences sharedPreferences;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  runApp(const SeliveryControl());
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void main() {
//   runApp(MyApp());
// }

// class SearchController extends GetxController {
//   final searchText = ''.obs;
//   final items = <String>[
//     'Apple',
//     'Banana',
//     'Cherry',
//     'Durian',
//     'Elderberry',
//     'Fig',
//     'Grapes',
//     'Honeydew',
//     'Jackfruit',
//     'Kiwi',
//     'Lemon',
//     'Mango',
//     'Orange',
//     'Papaya',
//     'Quince',
//     'Raspberry',
//     'Strawberry',
//     'Tomato',
//     'Ugli fruit',
//     'Watermelon'
//   ].obs;

//   List<String> get filteredItems {
//     if (searchText.value.isEmpty) {
//       return items.toList();
//     } else {
//       return items.where((item) => item.toLowerCase().contains(searchText.value.toLowerCase())).toList();
//     }
//   }
// }

// class MyApp extends StatelessWidget {
//   final SearchController controller = Get.put(SearchController());

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Search Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: TextField(
//             onChanged: (value) {
//               controller.searchText.value = value;
//             },
//             decoration: InputDecoration(
//               hintText: 'Search...',
//             ),
//           ),
//         ),
//         body: Obx(
//           () => ListView.builder(
//             itemCount: controller.filteredItems.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(controller.filteredItems[index]),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
