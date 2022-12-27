import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:losts_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../models/constants.dart';
import '../models/language_constants.dart';
import '../providers/items_provider.dart';

class LostItemDetailsScreen extends StatelessWidget {
  static const routeName = '/lost-item-detail-screen';

  const LostItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)?.settings.arguments as int;
    final item = context.read<ItemProvider>().lostByID(itemId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${translation(context).lostItem} ${item.name}"),
        ),
        drawer: const MainDrawer(),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    //image should came from the database
                    image: AssetImage("assets/images/lostBag.jpg"),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 300 - 20,
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.place,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 5.0),
                              Text(item.place,
                                  overflow: TextOverflow.ellipsis,
                                  style: kSmallTittle),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_in_talk,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                (item.phoneNumber).toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.black87,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                DateFormat.yMd().format(DateTime.now()),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        translation(context).description,
                        style: kLargeTittle,
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        item.description,
                        style: kDetailsText,
                        textAlign: TextAlign.justify,
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
  }
}
// Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Image.asset(
// "assets/images/lostBag.jpg",
// fit: BoxFit.cover,
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: const [
// Icon(
// Icons.place,
// color: Colors.black87,
// ),
// SizedBox(width: 5.0),
// Text("Khartoum",
// overflow: TextOverflow.ellipsis, style: kSmallTittle),
// ],
// ),
// Row(
// children: const [
// Icon(
// Icons.phone_in_talk,
// color: Colors.black87,
// ),
// SizedBox(width: 5.0),
// Text(
// "+249 9975743",
// overflow: TextOverflow.ellipsis,
// style: TextStyle(color: Colors.grey),
// ),
// ],
// ),
// Row(
// children: [
// const Icon(
// Icons.calendar_month,
// color: Colors.black87,
// ),
// const SizedBox(width: 5.0),
// Text(
// DateFormat.yMd().format(DateTime.now()),
// style: const TextStyle(color: Colors.grey),
// ),
// ],
// ),
// ],
// ),
// const SizedBox(
// height: 10
// ),
// const Text(
// 'Description : ',
// style: kLargeTittle,
// ),
// const Text(
// 'Lost Bag mlkkl jlji hoj iji ioopi didiiop sd poio oidipo popoid ipoid poid ipoid oipoid poidw opoid opoi opoipod poidi ',
// style: kDetailsText,
// textAlign: TextAlign.justify,
// ),
// ],
// ),
