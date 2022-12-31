import 'package:flutter/material.dart';
import 'package:losts_app/models/lost_item.dart';
import 'package:losts_app/providers/items_provider.dart';
import 'package:losts_app/screens/search_screen.dart';
import 'package:losts_app/widgets/Lostinforms_list.dart';
import 'package:losts_app/widgets/new_lost.dart';
import 'package:provider/provider.dart';

import '../models/language_constants.dart';
import '../widgets/FoundInformList.dart';
import '../widgets/main_drawer.dart';
import '../models/constants.dart';

class LostScreen extends StatefulWidget {
  static const routeName = '/lost-screen';
  const LostScreen({super.key});

  @override
  State<LostScreen> createState() => _LostScreenState();
}

class _LostScreenState extends State<LostScreen> {
  final List<LostItem> _losts = [];
  static List<LostItem> dummyData = [
    LostItem(
        id: DateTime.now().toString(),
        name: 'laptop',
        date: DateTime.now(),
        type: 'Electronic',
        place: 'Khartoum',
        phoneNumber: 1223456,
        description: 'description'),
    LostItem(
        id: DateTime.now().toString(),
        name: 'bag',
        date: DateTime.now(),
        type: 'laser',
        place: 'Omdurman',
        phoneNumber: 1223456,
        description: 'gjhghj description'),
    LostItem(
        id: DateTime.now().toString(),
        name: 'craft',
        date: DateTime.now(),
        type: 'cotton',
        place: 'West Khartoum',
        phoneNumber: 1223456,
        description: 'vmbnm description'),
    LostItem(
        id: DateTime.now().toString(),
        name: 'phone',
        date: DateTime.now(),
        type: 'Electronic',
        place: 'Bahri',
        phoneNumber: 1223456,
        description: 'bjkn description'),
    LostItem(
        id: DateTime.now().toString(),
        name: 'cat',
        date: DateTime.now(),
        type: 'animal',
        place: 'Kalakla',
        phoneNumber: 1223456,
        description: 'bjkn,m description'),
    LostItem(
        id: DateTime.now().toString(),
        name: 'Dog',
        date: DateTime.now(),
        type: 'animal',
        place: 'Borri',
        phoneNumber: 1223456,
        description: 'jhkh description'),
  ];

  List<LostItem> displayList = <LostItem>[];
  void updateList(String value) {
    setState(() {
      displayList = dummyData.where((element) =>
          // switch(element)
          // {
          // Case(element.name.toLowerCase().contains(value.toLowerCase())):
          //   return element.name.toLowerCase().contains(value.toLowerCase()).toList();
          // case(element.)
          // }

          element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ItemProvider>(context, listen: false).getLosts();
    super.initState();
  }

  void _addNewLost(
    String itemName,
    String itemType,
    String itemPlaceOfLost,
    int phoneNumber,
    String itemDescription,
  ) {
    final newLost = LostItem(
      id: DateTime.now().toString(),
      name: itemName,
      date: DateTime.now(),
      type: itemType,
      place: itemPlaceOfLost,
      phoneNumber: phoneNumber,
      description: itemDescription,
    );
    setState(() {
      _losts.add(newLost);
    });
  }

  void _startAddNewLost(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return NewLost(_addNewLost);
        });
  }

  @override
  Widget build(BuildContext context) {
    List<LostItem> _losts = [];
    List<LostItem> _displayLosts = [];
    bool searchResults = false;
    Provider.of<ItemProvider>(context, listen: false).getLosts();
    Provider.of<ItemProvider>(context, listen: false)
        .lostItems
        .forEach((element) {
      _losts.add(element);
    });

    // List<LostItem> _displayItem = _founds;
    void updateList(String value) {
      setState(() {
        _displayLosts = _losts.where((element) =>
            // switch(element)
            // {
            // Case(element.name.toLowerCase().contains(value.toLowerCase())):
            //   return element.name.toLowerCase().contains(value.toLowerCase()).toList();
            // case(element.)
            // }

            element.name.toLowerCase().contains(value.toLowerCase())).toList();

        searchResults = true;
        //print(SearchResults);
      });
    }

    Widget items(context) {
      if (_losts.isEmpty) {
        return Column(
          children: [
            Center(
              child: Text(
                translation(context).noLostFoundsItemsAddedYet,
                style: kLargeTittle,
              ),
            ),
            Image.asset(
              'assets/images/searchIcon.jpg',
              fit: BoxFit.cover,
            ),
          ],
        );
      } else {
        return LostInformsList();
      }
    }

    // List<LostItem> _losts = context.watch<ItemProvider>().lostItems;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(translation(context).lostAndFound),
            InkWell(
              child: const Icon(Icons.search, size: 32, color: Colors.white),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchScreen(_losts, "assets/images/lostImg.jpg")));
                // Navigator.of(context).pushNamed(LostScreen.routeName);
              },
            ),
          ],
        ),
      ),
      drawer: const MainDrawer(),
      body: Padding(
          padding: const EdgeInsets.only(top: 20), child: items(context)

          //  Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: Expanded(
          //     child: ListView.builder(
          //       itemCount: displayList.length,
          //       itemBuilder: (context, index) => Card(
          //         elevation: 5.0,
          //         child: Container(
          //           padding: const EdgeInsets.all(10),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               //Text(displayList[index].id),
          //               Text(displayList[index].name),
          //               Text('${displayList[index].date}'),
          //               Text(displayList[index].type),
          //               Text(displayList[index].place),
          //               Text('${displayList[index].phoneNumber}'),
          //               Text(displayList[index].description),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   // _losts.isEmpty
          //   //     ? Column(
          //   //         children: [
          //   //           Center(
          //   //             child: Text(
          //   //               translation(context).noLostFoundsItemsAddedYet,
          //   //               style: kLargeTittle,
          //   //             ),
          //   //           ),
          //   //           Image.asset(
          //   //             'assets/images/searchIcon.jpg',
          //   //             fit: BoxFit.cover,
          //   //           ),
          //   //         ],
          //   //       )
          //   //     : const InformsList(),
          // ),
          ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _startAddNewLost(context),
      ),
    );
  }
}
