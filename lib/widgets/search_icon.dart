import 'package:flutter/material.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.only(top: 3, bottom: 3, right: 3),
          child: const Icon(Icons.search, size: 10, color: Colors.white),
        ),
      ),
      onTap: () {
        // Navigator.of(context).pushNamed(LostScreen.routeName);
      },
    );
  }
}
