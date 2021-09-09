import 'package:dio/dio.dart';
import 'package:networking_app/models/NewsResponse.dart';

class NewsApiServices {
  static String _apiKey = 'f57136a8cbd84b1c871fafe949da9aa9';
  String _url =
      'https://newsapi.org/v2/everything?q=tesla&from=2021-08-09&sortBy=publishedAt&apiKey=$_apiKey';
  Dio _dio;
  NewsApiServices() {
    _dio = Dio();
  }

  Future<List<Article>> fetchNewsArticle() async {
    try {
      Response response = await _dio.get(_url);
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      return newsResponse.articles;
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }
}
