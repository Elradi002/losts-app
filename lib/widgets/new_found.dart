import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:losts_app/models/constants.dart';
import 'package:provider/provider.dart';

import '../models/language_constants.dart';
import '../models/lost_item.dart';
import '../providers/items_provider.dart';

class NewFound extends StatefulWidget {
  final Function addFound;

  const NewFound(this.addFound, {Key? key}) : super(key: key);

  @override
  State<NewFound> createState() => _NewFoundState();
}

class _NewFoundState extends State<NewFound> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();

  var _selectedDate;

  // void _showSuccessDialog() {
  //   showTimePicker(context: context, initialTime: TimeOfDay.now());
  // }

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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: SingleChildScrollView(
        child: _mainForm(context),
      ),
    );
  }

  Form _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: Text(translation(context).informAboutFoundItem,
                  textAlign: TextAlign.center, style: kLargeTittle),
            ),
          ),
          TextFormField(
            validator: (val) {
              if (val != null && val.isEmpty) {
                return translation(context).requiredField;
              } else if (val!.length < 8) {
                return translation(context).requiredFieldNum;
              } else if (!isValidName(val)) {
                return translation(context).enterValidName;
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).name,
              hintText: translation(context).foundNameHint,
            ),
            controller: _nameController,
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (val) {
              if (val != null && val.isEmpty) {
                return translation(context).requiredField;
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).type,
              hintText: translation(context).hintTypeOfFoundItem,
            ),
            controller: _typeController,
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (val) {
              if (val != null && val.isEmpty) {
                return translation(context).requiredField;
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).place,
              hintText: translation(context).hintPlaceOfFound,
            ),
            controller: _placeController,
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (val) {
              if (val != null && val.isEmpty) {
                return translation(context).requiredField;
              } else if (val!.length < 10) {
                return translation(context).requiredFieldPh;
              } else if (!isValidPhone(val)) {
                return translation(context).enterValidPhone;
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).phone,
              hintText: translation(context).hintPhone,
            ),
            controller: _phoneController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (val) {
              if (val != null && val.isEmpty) {
                return translation(context).requiredField;
              } else if (val!.length < 20) {
                return translation(context).requiredFieldDes;
              }
              return null;
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: translation(context).description,
              hintText: translation(context).hintItemDescription,
            ),
            controller: _descriptionController,
          ),
          const SizedBox(height: 10),
          Row(children: [
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: () {
              if (_key.currentState != null && _key.currentState!.validate()) {
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
                    .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                translation(context).itemAddedSuccessfully))));
                Navigator.of(context).pop();

                //_showSuccessDialog();
              }
            },
            height: 50,
            shape: const StadiumBorder(),
            color: Theme.of(context).colorScheme.secondary,
            child: Center(
              child: Text(
                translation(context).submit,
                style: kButtonTheme,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidName(value) {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(value);
  }

  bool isValidPhone(value) {
    final nameRegExp = RegExp(r"[0-9]");
    return nameRegExp.hasMatch(value);
  }
}
// CustomButton(
//     backgroundColor: Theme.of(context).colorScheme.secondary,
//     text: translation(context).submit,
//     textStyle: kButtonTheme,
//     height: 50,
//     onTabHandler: () {
//       context
//           .read<ItemProvider>()
//           .addFound(
//             LostItem(
//               id: '',
//               name: _nameController.text,
//               type: _typeController.text,
//               place: _placeController.text,
//               phoneNumber: int.parse(_phoneController.text),
//               description: _descriptionController.text,
//               date: _selectedDate,
//             ),
//           )
//           .then((value) => ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                   content: Text(
//                       translation(context).itemAddedSuccessfully))));
//       Navigator.of(context).pop();
//     }),

// Column(
//   //mainAxisAlignment: MainAxisAlignment.start,
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Text(
//       translation(context).informAboutFoundItem,
//       style: kLargeTittle,
//       textAlign: TextAlign.left,
//     ),
//     const SizedBox(height: 30),
//     Text(translation(context).nameOfFoundItem, style: kSmallTittle),
//     const SizedBox(height: 8.0),
//     customTextField(_nameController),
//     const SizedBox(height: 20.0),
//     Text(translation(context).typeOfFoundItem, style: kSmallTittle),
//     const SizedBox(height: 8.0),
//     customTextField(_typeController),
//     const SizedBox(height: 20.0),
//     Text(translation(context).placeOfFound, style: kSmallTittle),
//     const SizedBox(height: 8.0),
//     customTextField(_placeController),
//     const SizedBox(height: 20.0),
//     Text(translation(context).yourPhone, style: kSmallTittle),
//     const SizedBox(height: 8.0),
//     customTextField(_phoneController),
//     const SizedBox(height: 20.0),
//     Text(translation(context).itemDescription, style: kSmallTittle),
//     const SizedBox(height: 8.0),
//     customTextField(_descriptionController),
//     const SizedBox(height: 10.0),
//     Row(
//       children: [
//         Expanded(
//           child: Text(
//             _selectedDate == null
//                 ? translation(context).noDateChosen
//                 : '${translation(context).pickedDate} ${DateFormat.yMd().format(_selectedDate)}',
//             style: const TextStyle(
//               color: Colors.grey,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: _presentDatePicker,
//           child: Text(
//             translation(context).choseDate,
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ),
//       ],
//     ),
//     const SizedBox(height: 20.0),
