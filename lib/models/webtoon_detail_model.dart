class WebtoonDetailModel{
  final String title, about, genre, age;

  WebtoonDetailModel.fromJon(Map<String, dynamic> json):
    title = json['title'],
    about = json['about'],
    genre = json['genre'],
    age = json['age'];
}