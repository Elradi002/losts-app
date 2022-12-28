import 'package:flutter/material.dart';
import 'package:losts_app/models/constants.dart';
import 'package:losts_app/models/lost_item.dart';
import 'package:losts_app/providers/items_provider.dart';
import 'package:losts_app/widgets/informs_list.dart';
import 'package:losts_app/widgets/new_lost.dart';
import 'package:provider/provider.dart';
import '../models/language_constants.dart';

class LostScreen extends StatefulWidget {
  const LostScreen({super.key});

  @override
  State<LostScreen> createState() => _LostScreenState();
}

class _LostScreenState extends State<LostScreen> {
  final List<LostItem> _losts = [];
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
    List<LostItem> _losts = context.watch<ItemProvider>().lostItems;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: _losts.isEmpty
              ? Column(
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
                )
              : const InformsList(),
        ),
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
