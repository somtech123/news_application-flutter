class Article {
  String title;
  String author;
  String description;
  String urlToImage;
  // DateTime publshedAt;
  String content;
  String articleUrl;

  Article({
    required this.title,
    required this.description,
    required this.author,
    required this.content,
    //  required this.publshedAt,
    required this.urlToImage,
    required this.articleUrl,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'author': author,
        'content': content,
        'urlToImage': urlToImage,
        'url': articleUrl
      };

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      author: json['author'],
      content: json['content'],
      urlToImage: json['urlToImage'],
      articleUrl: json['url'],
    );
  }
}
