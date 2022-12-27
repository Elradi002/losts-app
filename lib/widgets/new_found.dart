import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:losts_app/providers/items_provider.dart';
import 'package:provider/provider.dart';

import '../models/constants.dart';
import '../models/language_constants.dart';
import '../models/lost_item.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class NewFound extends StatefulWidget {
  final Function addFound;

  const NewFound(this.addFound, {Key? key}) : super(key: key);

  @override
  State<NewFound> createState() => _NewFoundState();
}

class _NewFoundState extends State<NewFound> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();

  var _selectedDate;

  _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).colorScheme.secondary;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation(context).informAboutFoundItem,
              style: kLargeTittle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            Text(translation(context).nameOfFoundItem, style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_nameController),
            const SizedBox(height: 20.0),
            Text(translation(context).typeOfFoundItem, style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_typeController),
            const SizedBox(height: 20.0),
            Text(translation(context).placeOfFound, style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_placeController),
            const SizedBox(height: 20.0),
            Text(translation(context).yourPhone, style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_phoneController),
            const SizedBox(height: 20.0),
            Text(translation(context).itemDescription, style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_descriptionController),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? translation(context).noDateChosen
                        : '${translation(context).pickedDate} ${DateFormat.yMd().format(_selectedDate)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    translation(context).choseDate,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            CustomButton(
                backgroundColor: buttonTheme,
                text: translation(context).submit,
                textStyle: kButtonTheme,
                height: 50,
                onTabHandler: () {
                  context
                      .read<ItemProvider>()
                      .addFound(
                        LostItem(
                          id: '',
                          name: _nameController.text,
                          type: _typeController.text,
                          place: _placeController.text,
                          phoneNumber: int.parse(_phoneController.text),
                          description: _descriptionController.text,
                          date: _selectedDate,
                        ),
                      )
                      .then((value) => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                              content: Text(translation(context)
                                  .itemAddedSuccessfully))));
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
