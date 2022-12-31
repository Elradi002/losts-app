import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/language_constants.dart';
import '../models/lost_item.dart';
import '../screens/found_item_details_screen.dart';
import '../models/constants.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  List<LostItem> dummydata = [];
  String image = '';
  SearchScreen(this.dummydata, this.image, {Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // static List<LostItem> dummyData = [
  //   LostItem(
  //       id: DateTime.now().toString(),
  //       name: 'laptop',
  //       date: DateTime.now(),
  //       type: 'Electronic',
  //       place: 'Khartoum',
  //       phoneNumber: 1223456,
  //       description: 'description'),
  //   LostItem(
  //       id: DateTime.now().toString(),
  //       name: 'bag',
  //       date: DateTime.now(),
  //       type: 'laser',
  //       place: 'Omdurman',
  //       phoneNumber: 1223456,
  //       description: 'gjhghj description'),
  //   LostItem(
  //       id: DateTime.now().toString(),
  //       name: 'craft',
  //       date: DateTime.now(),
  //       type: 'cotton',
  //       place: 'West Khartoum',
  //       phoneNumber: 1223456,
  //       description: 'vmbnm description'),
  //   LostItem(
  //       id: DateTime.now().toString(),
  //       name: 'phone',
  //       date: DateTime.now(),
  //       type: 'Electronic',
  //       place: 'Bahri',
  //       phoneNumber: 1223456,
  //       description: 'bjkn description'),
  //   LostItem(
  //       id: DateTime.now().toString(),
  //       name: 'cat',
  //       date: DateTime.now(),
  //       type: 'animal',
  //       place: 'Kalakla',
  //       phoneNumber: 1223456,
  //       description: 'bjkn,m description'),
  //   LostItem(
  //       id: DateTime.now().toString(),
  //       name: 'Dog',
  //       date: DateTime.now(),
  //       type: 'animal',
  //       place: 'Borri',
  //       phoneNumber: 1223456,
  //       description: 'jhkh description'),
  // ];

  List<LostItem> displayList = <LostItem>[];
  void updateList(String value) {
    setState(() {
      displayList = widget.dummydata.where((element) =>
          // switch(element)
          // {
          // Case(element.name.toLowerCase().contains(value.toLowerCase())):
          //   return element.name.toLowerCase().contains(value.toLowerCase()).toList();
          // case(element.)
          // }

          element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  Widget results(_founds) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8.0),
        child: SizedBox(
          height: 600,
          child: ListView.builder(
            itemCount: _founds.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    FoundItemDetailsScreen.routeName,
                    arguments: index,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 5.0,
                    child: Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.fill,
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.asset(widget.image),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _founds[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    style: kLargeTittle,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.category,
                                        color: Colors.black87,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        _founds[index].type,
                                        overflow: TextOverflow.ellipsis,
                                        style: kSmallTittle,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.place,
                                        color: Colors.black87,
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(_founds[index].place,
                                          overflow: TextOverflow.ellipsis,
                                          style: kSmallTittle),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.black87,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                        DateFormat.yMd()
                                            .format(_founds[index].date),
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                  ]),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone_in_talk,
                                        color: Colors.black87,
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(
                                          _founds[index].phoneNumber.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        //backgroundColor: Colors.white,
        // The search area here
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              onChanged: (value) => updateList(value),
              autofocus: true,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  // suffixIcon: IconButton(
                  //   icon: const Icon(Icons.clear, color: Colors.teal),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //     /* Clear the search field */
                  //   },
                  // ),
                  prefixIconColor: Colors.teal,
                  hintText: translation(context).searchText,
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: displayList.isEmpty
              ? const Center(
                  child: Text('No result found'),
                )
              : results(displayList),
          // : ListView.builder(
          //     itemCount: displayList.length,
          //     itemBuilder: (context, index) => Card(
          //       elevation: 5.0,
          //       child: Container(
          //         padding: const EdgeInsets.all(10),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             //Text(displayList[index].id),
          //             Text(displayList[index].name),
          //             Text('${displayList[index].date}'),
          //             Text(displayList[index].type),
          //             Text(displayList[index].place),
          //             Text('${displayList[index].phoneNumber}'),
          //             Text(displayList[index].description),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:losts_app/models/constants.dart';
// import 'package:losts_app/widgets/custom_button.dart';
//
// import '../widgets/custom_text_field.dart';
//
// class SearchScreen extends StatelessWidget {
//   static const routeName = '/search-screen';
//   final _nameController = TextEditingController();
//   final _typeController = TextEditingController();
//   SearchScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final buttonTheme = Theme.of(context).colorScheme.secondary;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Search',
//           style: kAppBarTheme,
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
//           child: Column(
//             //mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 'Search about lost item ...',
//                 style: kLargeTittle,
//                 textAlign: TextAlign.left,
//               ),
//               const SizedBox(height: 40),
//               const Text('Name of lost item : ', style: kSmallTittle),
//               const SizedBox(height: 8.0),
//               customTextField(_nameController),
//               const SizedBox(height: 30.0),
//               const Text('Type of lost item : ', style: kSmallTittle),
//               const SizedBox(height: 8.0),
//               customTextField(_typeController),
//               const SizedBox(height: 30.0),
//               CustomButton(
//                 backgroundColor: buttonTheme,
//                 text: 'Submit ',
//                 textStyle: kButtonTheme,
//                 height: 40,
//                 onTabHandler: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
