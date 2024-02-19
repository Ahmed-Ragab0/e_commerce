class CategoryModel {
  bool? status;
  CategoriesDataModel? data;

  CategoryModel.fromJson(json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  List<CategoryDataModel> data = [];
  CategoriesDataModel.fromJson(json) {
    json['data'].forEach((element) {
      data.add(CategoryDataModel.fromjson(element));
    });
  }
}

class CategoryDataModel {
  int? id;
  String? name;
  String? image;

  CategoryDataModel.fromjson(json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
