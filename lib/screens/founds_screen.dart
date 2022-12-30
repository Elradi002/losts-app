import 'package:flutter/material.dart';
import 'package:losts_app/models/lost_item.dart';
import 'package:provider/provider.dart';

import '../models/constants.dart';
import '../models/language_constants.dart';
import '../providers/items_provider.dart';
import '../widgets/founds_list.dart';
import '../widgets/main_drawer.dart';
import '../widgets/new_found.dart';

class FoundScreen extends StatefulWidget {
  const FoundScreen({super.key});

  @override
  State<FoundScreen> createState() => _FoundScreenState();
}

class _FoundScreenState extends State<FoundScreen> {
  final List<LostItem> _founds = [];
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
  void updateList(String value, List<LostItem> items) {
    setState(() {
      displayList = items.where((element) =>
          // switch(element)
          // {
          // Case(element.name.toLowerCase().contains(value.toLowerCase())):
          //   return element.name.toLowerCase().contains(value.toLowerCase()).toList();
          // case(element.)
          // }

          element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  InitState() {
    super.initState();
    print("from found init state ");
  }

  void _addNewFound(
    String itemName,
    String itemType,
    String itemPlaceOfFound,
    int phoneNumber,
    String itemDescription,
  ) {
    final newFound = LostItem(
      id: DateTime.now().toString(),
      name: itemName,
      date: DateTime.now(),
      type: itemType,
      place: itemPlaceOfFound,
      phoneNumber: phoneNumber,
      description: itemDescription,
    );
    setState(() {
      _founds.add(newFound);
    });
  }

  void _startAddNewFound(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return NewFound(_addNewFound);
        });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ItemProvider>(context, listen: false).getFounds();
    List<LostItem> _founds = context.watch<ItemProvider>().foundItems;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(translation(context).lostAndFound),
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  onChanged: (value) => updateList(value, _founds),
                  autofocus: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    // suffixIcon: IconButton(
                    //   icon: const Icon(Icons.clear, color: Colors.teal),
                    // onPressed: () {
                    //   TextEditingController.
                    // },
                    // ),
                    // prefixIconColor: Colors.teal,
                    // hintText: translation(context).searchText,
                    // border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: _founds.isEmpty
              ? Column(
                  children: [
                    Center(
                      child: Text(
                        translation(context).noLostFoundsItemsAddedYet,
                        style: kLargeTittle,
                      ),
                    ),
                    Image.asset(
                      'assets/images/foundIcon.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              : displayList.isEmpty
                  ? const Center(
                      child: Text('No results found'),
                    )
                  : const FoundsList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _startAddNewFound(context),
      ),
    );
  }
}
