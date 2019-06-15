import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';
import '../utillites/api_utillites.dart';

class PostsApi {
  Future<List<Post>> fetchPostsByCategoriesId(String id) async {
    List<Post> posts = List<Post>();
    String whatsNews = baseApi + postsCategoriesApi + id;
    var response = await http.get(whatsNews);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData['data'];      
      for (var item in data) {
        Post post = Post(
          id: item['id'].toString(),
          title: item['title'].toString(),
          content: item['content'].toString(),
          date_written: item['date_written'].toString(),
          featured_image: item['featured_image'].toString(),
          votes_up: item['votes_up'],
          votes_down: item['votes_down'],
          voters_up: item['voters_up'] == null ? List<int>() : jsonDecode(item['voters_up']),
          voters_down: item['voters_down'] == null ? List<int>() : jsonDecode(item['voters_down']),
          user_id: item['user_id'],
          autherName: item['autherName'].toString(),
          autherAvater: item['autherAvater'].toString(),
          category_id: item['category_id'],
          categoryTitle: item['categoryTitle'].toString(),
        );        
        posts.add(post);       
      }
    }
    /*for(Post post in posts){
      print(post.title);
    }*/
    return posts;
  }
}
