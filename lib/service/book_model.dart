class BookModel {
  final String title, author, story, moral;
  BookModel({
    required this.title,
    required this.author,
    required this.story,
    required this.moral,
  });
}


// class BookModel {
//   String sId;
//   String title;
//   String author;
//   String story;
//   String moral;

//   BookModel({this.sId, this.title, this.author, this.story, this.moral});

//   BookModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     title = json['title'];
//     author = json['author'];
//     story = json['story'];
//     moral = json['moral'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = this.sId;
//     data['title'] = this.title;
//     data['author'] = this.author;
//     data['story'] = this.story;
//     data['moral'] = this.moral;
//     return data;
//   }
// }


