import 'package:flutter/material.dart';

import '../models/language_constants.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search-screen';
  const SearchScreen({Key? key}) : super(key: key);

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
              autofocus: true,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.teal),
                    onPressed: () {
                      Navigator.pop(context);
                      /* Clear the search field */
                    },
                  ),
                  hintText: translation(context).searchText,
                  border: InputBorder.none),
            ),
          ),
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
