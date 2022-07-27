

import 'package:authentication_with_bloc/home/model/home_detail.dart';
import 'package:http/http.dart';

class HomeRepository{
  final url = "https://cryptopanic.com/api/v1/posts/?auth_token=82e386f31b5aebaceabe0073a467b4a657fd3fa0&public=true";


  Future<HomeModel> fetchNews() async{
    final response = await get(Uri.parse(url));
    print(response.body);
    final cryptoNews = HomeFromJson(response.body);
    print(cryptoNews);
    return cryptoNews;
  }

}