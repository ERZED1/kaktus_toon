import 'package:dio/dio.dart';
import 'book_model.dart';

class BookApi {
  static Future<List<BookModel>> getBook() async {
    final response =
        await Dio().get('https://shortstories-api.herokuapp.com/stories');
    List<BookModel> book = (response.data as List)
        .map(
          (e) => BookModel(
              title: e['title'],
              author: e['author'],
              story: e['story'],
              moral: e['moral']),
        )
        .toList();
    return book;
  }
}
