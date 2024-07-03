import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:guttenberg_book_apps/config/injection.dart';
import 'package:guttenberg_book_apps/features/books/presentation/pages/book_page.dart';

void main() async {
  await initDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        "/": (context) => const BookPage(),
      },
    );
  }
}
