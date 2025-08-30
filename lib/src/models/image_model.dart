class ImageModel {
  late int id ;
  late String url;
  late String title;
  String tempUrl = '';

  ImageModel(this.id, this.url, this.title);

  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
      id = parsedJson['id'];
      tempUrl = parsedJson['url'];
      title = parsedJson['title'];
      url = tempUrl.replaceAll('via.placeholder.com', 'place-hold.it');
  }
  
}