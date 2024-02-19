class FavoritesModel {
  bool? status;
  String? message;

  FavoritesModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
  }
}
