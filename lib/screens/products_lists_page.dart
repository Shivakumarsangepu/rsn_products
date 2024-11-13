import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rsn_products/screens/product_detail_page.dart';
import '../common_widgets/core.dart';
import '../common_widgets/sort_dialog.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  _ProductListScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
        child: buildUI(context, productProvider),
      ),
    );
  }

  Widget buildUI(BuildContext context, ProductProvider productProvider) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async{
          productProvider.fetchProducts();
        },
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Products", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                child: const Icon(Icons.filter_list_alt),
                                onTap: () {
                                  _showFilterDialog(context);
                                },
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                          GridView.builder(
                          shrinkWrap: true,  // To allow GridView to be wrapped inside a ScrollView
                            physics: const NeverScrollableScrollPhysics(), // Disable scrolling for GridView, as it's inside a SingleChildScrollView
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: productProvider.products.length,
                            itemBuilder: (context, index) {
                              final product = productProvider.products[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsScreen(product: product),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Hero(tag: 'product_${product.id}',
                                        child: Core().getNetworkImageFillWidth(product.image,'assets/default_image.png',120,120,BoxFit.contain),
                                      ),
                                      VerticalSpace(),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        product.title,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      VerticalSpace(height: 2,),
                                      Text(
                                        product.category,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      VerticalSpace(height: 2,),
                                      Text(
                                        "\$${product.price}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      VerticalSpace(height: 2,),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${product.rating.rate}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green,
                                            ),
                                          ),
                                          VerticalSpace(height: 2,),
                                          const Icon(Icons.star,size: 16,color:Colors.green,),
                                          HorizontalSpace(width: 4,),
                                          Container(height: 12,width: 1,color: Colors.green,),
                                          HorizontalSpace(width: 4,),
                                          Text(
                                            "${product.rating.count}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (productProvider.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.6), // Adds a slight background overlay
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SortDialog();
      },
    );
  }
}
