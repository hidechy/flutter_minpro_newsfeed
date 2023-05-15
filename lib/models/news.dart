import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  News({required this.articles});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  final List<Article> articles;

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class Article {
  Article({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishDate,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  @JsonKey(name: 'publishedAt')
  final String? publishDate;
  final String? content;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
