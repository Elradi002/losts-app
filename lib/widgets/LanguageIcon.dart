import 'package:flutter/material.dart';

import '../main.dart';
import '../models/language.dart';
import '../models/language_constants.dart';

class LanguageIcon extends StatelessWidget {
  const LanguageIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: DropdownButton<Language>(
        underline: const SizedBox(),
        icon: const Icon(
          Icons.language,
          color: Colors.white,
        ),
        onChanged: (Language? language) async {
          if (language != null) {
            Locale _locale = await setLocale(language.languageCode);
            MyApp.setLocale(context, _locale);
          }
        },
        items: Language.languageList()
            .map<DropdownMenuItem<Language>>(
              (e) => DropdownMenuItem<Language>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      e.flag,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(e.name)
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
