import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:separate_api/controllers/app_controller.dart';
import 'package:separate_api/pages/checkout_page.dart';
import 'package:separate_api/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CatalogCartAndCheckout()..init(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          "/home": (context) => const HomePage(),
          "/checkout": (context) => const CheckoutPage(),
        },
        home: const HomePage(),
      ),
    );
  }
}
