import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/author.dart';
import '../utillites/api_utillites.dart';

class AuthorsApi{
  
  Future<List<Author>> fetchAllAuthors() async{
    List<Author> authors = List<Author>();
    String allAutApi = baseApi + allAuthorsApi;
    var response = await http.get(allAutApi);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      var data = jsonData['data'];
      for(var item in data){
        Author author = Author(item['id'].toString(), item['name'].toString(),
         item['email'].toString(), item['avater'].toString());
         authors.add(author);
      }
    }
    /*for(Author author in authors){
      print(author.name);
    }*/
    return authors;
  }
}