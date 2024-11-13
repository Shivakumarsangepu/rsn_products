import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common_widgets/core.dart';
import '../models/product_model.dart';


class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // App Bar with a Back Button
                    SizedBox(height: deviceHeight(context) * 0.01),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text("Explore Product", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                         SizedBox(width: deviceWidth(context) * 0.08), // Empty space for alignment
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Body
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Hero(
                                tag: 'product_${product.id}',
                                  child: Core().getNetworkImageFillWidth(product.image,'assets/default_image.png',deviceWidth(context),deviceHeight(context)/2,BoxFit.contain),
                                ),
                                VerticalSpace(),
                                Text(
                                  product.title,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                VerticalSpace(height: 2,),
                                Text(
                                  product.category,
                                  style: const TextStyle(fontSize: 14,),
                                ),
                                VerticalSpace(height: 2,),
                                Text(
                                  "\$${product.price}",
                                  style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                ),
                                VerticalSpace(height: 2,),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${product.rating.rate}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Icon(Icons.star,size: 20,color: Colors.green,),
                                    HorizontalSpace(width: 4,),
                                    Container(height: 15,width: 1,color: Colors.green,),
                                    HorizontalSpace(width: 4,),
                                    Text(
                                      "${product.rating.count}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalSpace(),
                                Text(
                                  product.description,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                VerticalSpace(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
