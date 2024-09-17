import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/main.dart';
import 'package:test_new_feature/ui/page/country_list_bloc_page.dart';
import 'package:test_new_feature/ui/page/country_list_page.dart';
import 'package:test_new_feature/ui/page/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: CountryListBlocPage(),
      themeMode: ThemeMode.system,
    );
  }
}
