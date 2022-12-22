import 'package:flutter/material.dart';
import 'package:losts_app/models/lost_item.dart';

import '../models/constants.dart';
import '../widgets/founds_list.dart';
import '../widgets/new_found.dart';

class FoundScreen extends StatefulWidget {
  const FoundScreen({super.key});

  @override
  State<FoundScreen> createState() => _FoundScreenState();
}

class _FoundScreenState extends State<FoundScreen> {
  final List<LostItem> _founds = [];

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: _founds.isEmpty
              ? Column(
                  children: [
                    const Center(
                      child: Text(
                        'No founds items added yet !!',
                        style: kLargeTittle,
                      ),
                    ),
                    Image.asset(
                      'assets/images/foundIcon.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              : FoundsList(_founds),
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
