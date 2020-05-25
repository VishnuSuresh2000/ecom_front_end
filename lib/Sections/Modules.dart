class Product {
  String name;
  String dis;
  String _id;
  CategorySection category;
  Map<String, dynamic> toMap() {
    return {'_id': _id, "name": name, "dis": dis,'category':category.toMap()};
  }

  Product();

  Product.fromMap(Map<String, dynamic> temp) {
    this.name = temp['_id'];
    this.name = temp['name'];
    this.dis = temp['dis'];
    this.category=CategorySection.fromMap(temp['category']);
  }
   String get id{
    return this._id;
  }
}

class CategorySection {
  String name;
  String _id;
  Map<String, dynamic> toMap() {
    return {'_id': _id, 'name': name};
  }

  CategorySection.fromMap(Map<String, dynamic> temp) {
    this.name = temp['name'];
    this._id = temp['_id'];
  }
   String get id{
    return this._id;
  }
}

class CommonProfile {
  String name;
  String address;
  int phoneNumber;
  String email;
  String _id;
  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email
    };
  }

  CommonProfile();

  String get id{
    return this._id;
  }

  CommonProfile.fromMap(Map<String, dynamic> temp) {
    this.name = temp['_id'];
    this.name = temp['name'];
    this.address = temp['address'];
    this.phoneNumber = temp['phoneNumber'];
    this.email = temp['email'];
  }
}
