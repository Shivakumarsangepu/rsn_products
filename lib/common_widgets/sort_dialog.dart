import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class SortDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Sort By Price',style: TextStyle(fontWeight: FontWeight.bold),),
      content: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: const Text("Low to High",style: TextStyle(fontWeight: FontWeight.bold),),
                value: SortOrder.lowToHigh,
                groupValue: provider.sortOrder,
                onChanged: (SortOrder? value) {
                  provider.setSortOrder(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: const Text("High to Low",style: TextStyle(fontWeight: FontWeight.bold),),
                value: SortOrder.highToLow,
                groupValue: provider.sortOrder,
                onChanged: (SortOrder? value) {
                  provider.setSortOrder(value!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
