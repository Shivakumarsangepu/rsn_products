
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      // shrinkWrap: true,
      childAspectRatio: 0.6,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(6, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.white,
          period: const Duration(milliseconds: 1000),
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 500,
            margin: const EdgeInsets.only(bottom: 10),
            decoration:  const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
        );
      }),
    );
  }
}