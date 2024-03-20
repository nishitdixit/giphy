import 'dart:convert';

GifModel gifModelFromJson(String str) => GifModel.fromJson(json.decode(str));

String gifModelToJson(GifModel data) => json.encode(data.toJson());

class GifModel {
  final String type;
  final String id;
  final String url;
  final String embedUrl;
  final String username;
  final String title;

  GifModel({
    required this.type,
    required this.id,
    required this.url,
    required this.embedUrl,
    required this.username,
    required this.title,
  });

  factory GifModel.fromJson(Map<String, dynamic> json) => GifModel(
        type: json["type"],
        id: json["id"],
        url: "https://i.giphy.com/media/${json["url"].split('-').last}/200.gif",
        embedUrl: json["embed_url"],
        username: json["username"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "url": url,
        "embed_url": embedUrl,
        "username": username,
        "title": title,
      };
}
