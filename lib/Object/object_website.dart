class Website {
  int id;
  String websiteUrl;

  /*String img;
  String nickname;*/

  Website.fromJson(Map json)
      :websiteUrl = json['websiteUrl'],
      id=json['id'];

  Map toJson() {
    return {'websiteUrl': websiteUrl, 'id':id};
  }

}
