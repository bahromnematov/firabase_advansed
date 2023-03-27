class Post {

  String? first_name;
  String? last_name;
  String? content;
  String? date;

  Post({

    this.first_name,
    this.last_name,
    this.content,
    this.date,
  });

  Post.fromJson(Map<String ,dynamic> json)
      :
        first_name = json['first_name'],
        last_name = json['last_name'],
        content = json['content'],
        date = json['date'];

  Map<String, dynamic> toJson() =>
      {

        'first_name': first_name,
        'last_name': last_name,
        'content': content,
        'date': date,

      };
}
