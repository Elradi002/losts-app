import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:losts_app/screens/found_item_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import '../models/constants.dart';
import '../models/lost_item.dart';
import '../screens/lost_item_details_screen.dart';

class FoundsList extends StatefulWidget {
  //final List<LostItem> _founds;
  const FoundsList( {super.key});
  @override
  State<FoundsList> createState() => _FoundsListState();
}

class _FoundsListState extends State<FoundsList> {

  @override
  Widget build(BuildContext context) {
      List<LostItem> _founds = context.watch<ItemProvider>().foundItems;
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
                  Navigator.of(context)
                      .pushNamed(FoundItemDetailsScreen.routeName, arguments:
                      index,) ;
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Colors.teal[50],
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/lostBag.jpg"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.teal[50],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
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
                                    const SizedBox(width: 5.0),
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
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.black87,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      DateFormat.yMd()
                                          .format(_founds[index].date),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone_in_talk,
                                      color: Colors.black87,
                                    ),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      _founds[index].phoneNumber
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}

// Row(
// children: [
// const Icon(
// Icons.phone_in_talk,
// color: Colors.grey,
// ),
// Text(
// widget._founds[index].phoneNumber
//     .toString(),
// overflow: TextOverflow.ellipsis,
// style: const TextStyle(
// color: Colors.grey,
// ),
// ),
// ],
// ),
