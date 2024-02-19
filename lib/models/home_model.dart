class HomeModel {
  bool? status;
  DataModel? data;

  HomeModel.fromJson(json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<BannersModel>? banners = [];
  List<ProductModel>? products = [];

  DataModel.fromJson(json) {
    json['banners'].forEach((element) {
      banners?.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products?.add(ProductModel.fromJson(element));
    });
  }
}

class BannersModel {
  int? id;
  String? image;
  BannersModel.fromJson(json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  String? name;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  bool? inFav;
  bool? inCart;
  ProductModel.fromJson(json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    inFav = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
