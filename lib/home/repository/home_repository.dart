import 'package:http/http.dart';

import 'package:crypto_currency/home/model/home_detail.dart';

/// api Declaration
class HomeRepository {
  final url =
      "https://cryptopanic.com/api/v1/posts/?auth_token=82e386f31b5aebaceabe0073a467b4a657fd3fa0&public=true";

  /// Create a function to fetch  api data
  Future<HomeModel> fetchNews() async {
    final response = await get(Uri.parse(url));
    print(response.body);
    final cryptoNews = HomeFromJson(response.body);
    print(cryptoNews);
    return cryptoNews;
  }
}
