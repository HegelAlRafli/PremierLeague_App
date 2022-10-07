import 'package:flutter/cupertino.dart';

final String tableFavorite = 'news  ';

class Favorite {
  static final List<String> values = [id, image, name, julukan, since];

  static final String id = 'id';
  static final String image = 'img';
  static final String name = 'name';
  static final String julukan = 'julukan';
  static final String since = 'since';
}

class FavoriteModel {
  final int? id;
  final String image;
  final String name;
  final String julukan;
  final String since;

  FavoriteModel(
      {this.id,
      required this.image,
      required this.name,
      required this.julukan,
      required this.since});

  static FavoriteModel fromJson(Map<String, Object?> json) => FavoriteModel(
        id: json[Favorite.id] as int?,
        image: json[Favorite.image] as String,
        name: json[Favorite.name] as String,
        julukan: json[Favorite.julukan] as String,
        since: json[Favorite.since] as String,
      );

  Map<String, Object?> toJson() => {
        Favorite.id: id,
        Favorite.image: image,
        Favorite.name: name,
        Favorite.julukan: julukan,
        Favorite.since: since
      };

  FavoriteModel copy(
          {int? id,
          String? imageUrl,
          String? author,
          String? julukan,
          String? since}) =>
      FavoriteModel(
          id: id ?? this.id,
          image: imageUrl ?? this.image,
          name: author ?? this.name,
          julukan: julukan ?? this.julukan,
          since: since ?? this.since);
}
