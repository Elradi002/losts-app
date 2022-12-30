import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/constants.dart';
import '../models/lost_item.dart';
import '../screens/lost_item_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';

class FoundInformsList extends StatefulWidget {
  const FoundInformsList({super.key});
  @override
  State<FoundInformsList> createState() => _FoundInformsListState();
}

class _FoundInformsListState extends State<FoundInformsList> {
  @override
  Widget build(BuildContext context) {
    final List<LostItem> _informs = context.read<ItemProvider>().lostItems;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8.0),
        child: SizedBox(
          height: 600,
          child: ListView.builder(
            itemCount: _informs.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(LostItemDetailsScreen.routeName, arguments:
                     index,
                  );
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
                            image: AssetImage("assets/images/foundImage.jpg"),
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
                                  _informs[index].name,
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
                                      _informs[index].type,
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
                                    Text(_informs[index].place,
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
                                          .format(_informs[index].date),
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
                                    Text(_informs[index].phoneNumber.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.grey)),
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
