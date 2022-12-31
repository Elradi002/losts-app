import 'package:flutter/material.dart';
import 'package:losts_app/models/lost_item.dart';
import 'package:losts_app/widgets/FoundInformList.dart';
import 'package:losts_app/widgets/search_icon.dart';
import 'package:provider/provider.dart';
import '../screens/search_screen.dart';
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

  // InitState() {
  //   super.initState();
  //   print("from found init state ");
  // }

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
    List<LostItem> _founds = [];
    List<LostItem> _displayfounds = [];
    bool searchResults = false;
    Provider.of<ItemProvider>(context, listen: false).getFounds();
    Provider.of<ItemProvider>(context, listen: false)
        .foundItems
        .forEach((element) {
      _founds.add(element);
    });

    // List<LostItem> _displayItem = _founds;
    void updateList(String value) {
      setState(() {
        _displayfounds = _founds.where((element) =>
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
      if (_founds.isEmpty) {
        return Column(
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
        );
      } else {
        return FoundInformsList();
      }
    }

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
                        builder: (context) => SearchScreen(_founds,"assets/images/foundImg.jpg")));
                // Navigator.of(context).pushNamed(LostScreen.routeName);
              },

              // TextField(
              //   // onSubmitted: (value) => updateList(value),
              //   onTap: (() =>

              //   // onSubmitted: (value) => Navigator.push(context

              //   // (value) => updateList(value),
              //   autofocus: true,
              //   decoration: const InputDecoration(
              //     prefixIcon: Icon(Icons.search),
              //     // suffixIcon: IconButton(
              //     //   icon: const Icon(Icons.clear, color: Colors.teal),
              //     // onPressed: () {
              //     //   TextEditingController.
              //     // },
              //     // ),
              //     // prefixIconColor: Colors.teal,
              //     // hintText: translation(context).searchText,
              //     // border: InputBorder.none),
              //   ),
              // ),
            ),
          ],
        ),
      ),
      drawer: const MainDrawer(),
      body:
          Padding(padding: const EdgeInsets.only(top: 20), child: items(context)

              //  displayList.isEmpty
              //     ? const Center(
              //         child: Text('No results found'),
              //       )
              //     : c
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
