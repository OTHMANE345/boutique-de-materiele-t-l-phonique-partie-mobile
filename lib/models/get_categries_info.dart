import 'dart:convert';

class CategoryInfo {
  int id;
  String title;
  CategoryInfo({
    this.id = 0,
    this.title = '',
  });

  CategoryInfo.fromJson(Map json)
      : id = json['id'],
        title = json['title'];
  Map toMap() {
    return {
      'id': id,
      'title': title,

    };
  }


}
