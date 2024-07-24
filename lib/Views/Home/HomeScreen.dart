import 'dart:convert';

import 'package:demo/Controller/theme_controller.dart';
import 'package:demo/Models/HomeModel.dart';
import 'package:demo/Views/Home/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text("Homescreen"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Column(
          children: [
            // const Text(
            //   'Toggle Dark Mode:',
            //   style: TextStyle(fontSize: 18),
            // ),
            // Switch(
            //   activeColor: controller.isDarkMode ? white : black,
            //   value: controller.isDarkMode,
            //   onChanged: (value) {
            //     controller.toggleTheme();
            //   },
            // ),
            // const SizedBox(height: 20),
            // Text(
            //   'Current Mode: ${controller.isDarkMode ? 'Dark' : 'Light'}',
            //   style: const TextStyle(fontSize: 18),
            // ),
            Expanded(
              child: FutureBuilder<List<HomeModel>>(
                future: getApiList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No data available"),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(left: 7.w, right: 7.w),
                      child: ListWheelScrollView(
                        itemExtent: 100,
                        children: List.generate(snapshot.data!.length, (index) {
                          HomeModel data = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => DetailScreen(data));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: controller.isDarkMode
                                    ? Colors.blue
                                    : Colors.blue,
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      data.id.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      data.title,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<HomeModel>> getApiList() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      List<HomeModel> homeList = [];
      for (var i in data) {
        homeList.add(HomeModel.fromJson(i));
      }
      return homeList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}


 // Expanded(
            //   child: FutureBuilder<List<HomeModel>>(
            //     future: getApiList(),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else if (snapshot.hasError) {
            //         return Center(
            //           child: Text("Error: ${snapshot.error}"),
            //         );
            //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //         return const Center(
            //           child: Text("No data available"),
            //         );
            //       } else {
            //         return Container(
            //           margin: EdgeInsets.only(left: 7.w, right: 7.w),
            //           child: ListView.builder(
            //             itemBuilder: (context, index) {
            //               HomeModel data = snapshot.data![index];
            //               return GestureDetector(
            //                 onTap: () {
            //                   Get.to(() => DetailScreen(data));
            //                 },
            //                 child: Container(
            //                   margin: const EdgeInsets.symmetric(vertical: 8),
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     color: controller.isDarkMode
            //                         ? Colors.blue
            //                         : Colors.blue,
            //                   ),
            //                   padding: const EdgeInsets.all(16),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         data.id.toString(),
            //                         style:
            //                             const TextStyle(color: Colors.white),
            //                       ),
            //                       Text(
            //                         data.title,
            //                         style:
            //                             const TextStyle(color: Colors.white),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             },
            //             itemCount: snapshot.data!.length,
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // ),
      






//WOO-COMMERCE API IN FLUTTER

// Future<List<dynamic>> fetchProducts() async {
//   final String url = 'https://your-woocommerce-store.com/wp-json/wc/v3/products';
//   final String consumerKey = 'your_consumer_key';
//   final String consumerSecret = 'your_consumer_secret';

//   final response = await http.get(
//     Uri.parse('$url'),
//     headers: {
//       'Authorization': 'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret')),
//     },
//   );

//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   } else {
//     throw Exception('Failed to load products');
//   }
// }
