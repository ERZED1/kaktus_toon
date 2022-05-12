import 'package:flutter/Material.dart';
import 'book_api.dart';
import 'book_model.dart';

class BookProvider with ChangeNotifier {
  List<BookModel> _book = [];
  List<BookModel> get book => _book;

  getAllBook() async {
    _book = (await BookApi.getBook()) as List<BookModel>;
    notifyListeners();
  }
}
