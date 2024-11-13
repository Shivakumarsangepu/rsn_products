import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsn_products/screens/products_lists_page.dart';
import 'providers/product_provider.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product API App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}
