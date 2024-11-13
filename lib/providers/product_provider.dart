import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../service/api_service.dart';


enum SortOrder { lowToHigh, highToLow }

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  bool _isLoading = false;
  SortOrder _sortOrder = SortOrder.lowToHigh;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  SortOrder get sortOrder => _sortOrder;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await _apiService.fetchProducts();
      _applySorting();
    } catch (error) {
      print("Error fetching products: $error");
    }
    _isLoading = false;
    notifyListeners();
  }

  void setSortOrder(SortOrder order) {
    _sortOrder = order;
    _applySorting();
    notifyListeners();
  }

  void _applySorting() {
    if (_sortOrder == SortOrder.lowToHigh) {
      _products.sort((a, b) => a.price.compareTo(b.price));
    } else {
      _products.sort((a, b) => b.price.compareTo(a.price));
    }
  }
}
