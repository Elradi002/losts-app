import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:losts_app/models/constants.dart';
import 'package:losts_app/models/lost_item.dart';
import 'package:losts_app/providers/items_provider.dart';
import 'package:provider/provider.dart';

import '../models/language_constants.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class NewLost extends StatefulWidget {
  final Function addLost;

  const NewLost(this.addLost, {Key? key}) : super(key: key);

  @override
  State<NewLost> createState() => _NewLostState();
}

class _NewLostState extends State<NewLost> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _placeController = TextEditingController();
  //final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
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
              translation(context).informAboutLostItem,
              style: kLargeTittle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            Text(translation(context).nameOfLostItem, style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_nameController),
            const SizedBox(height: 20.0),
            Text(translation(context).typeOfLostItem, style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_typeController),
            const SizedBox(height: 20.0),
            Text(translation(context).placeOfLost, style: kSmallTittle),
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
                    .addLost(LostItem(
                      id: '',
                      name: _nameController.text,
                      type: _typeController.text,
                      place: _placeController.text,
                      phoneNumber: int.parse(_phoneController.text),
                      description: _descriptionController.text,
                      date: _selectedDate,
                    ))
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(translation(context).itemAddedSuccessfully)));

                  Navigator.of(context).pop();
                });

                // context.read<ItemProvider>().add(LostItem(
                //     id: '',
                //     name: _nameController.text,
                //     type: _typeController.text,
                //     place: _placeController.text,
                //     phoneNumber: int.parse(_phoneController.text),
                //     description: _descriptionController.text,
                //     date: _selectedDate,
                //   ));
                // context.read()<LostItem>()(
                //       _nameController.text,
                //       _typeController.text,
                //       _placeController.text,
                //       int.parse(_phoneController.text),
                //       _descriptionController.text,
                //     );
              },
            ),
          ],
        ),
      ),
    );
  }
}
