import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart';
import '../utillites/api_utillites.dart';

class CategoriesApi{
  Future<List<Category>> fetchAllCategories() async{
    List<Category> categories = List<Category>();
    String allCategApi = baseApi + allCategoriesApi;
    var response = await http.get(allCategApi);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      var data = jsonData['data'];
      for(var item in data){
        Category category = Category(item['id'].toString(), item['title'].toString());
         categories.add(category);
      }
    }
    /*for(Category category in categories){
      print(category.title);
    }*/
    return categories;
  }
}