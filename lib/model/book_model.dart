// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModele {
  String author;
  String title;
  BookModele({
    required this.author,
    required this.title,
  });


  BookModele copyWith({
    String? author,
    String? title,
  }) {
    return BookModele(
      author: author ?? this.author,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'title': title,
    };
  }

  factory BookModele.fromMap(Map<String, dynamic> map) {
    return BookModele(
      author: map['author'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModele.fromJson(String source) => BookModele.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookModele(author: $author, title: $title)';

  @override
  bool operator ==(covariant BookModele other) {
    if (identical(this, other)) return true;
  
    return 
      other.author == author &&
      other.title == title;
  }

  @override
  int get hashCode => author.hashCode ^ title.hashCode;
}
