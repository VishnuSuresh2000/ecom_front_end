class Product {
  String name;
  String description;
  String _id;
  CategorySection category;
  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      "name": name,
      "description": description,
      'category': category.toMap()
    };
  }

  Product();

  Product.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.name = temp['name'];
    this.description = temp['description'];
    this.category = CategorySection.fromMap(temp['category']);
  }
  String get id {
    return this._id;
  }
}

class CategorySection {
  String name;
  String _id;

  CategorySection();

  Map<String, dynamic> toMap() {
    return {'_id': _id, 'name': name};
  }

  CategorySection.fromMap(Map<String, dynamic> temp) {
    this.name = temp['name'];
    this._id = temp['_id'];
  }
  String get id {
    return this._id;
  }
}

class CommonProfile {
  String name;
  String address;
  int phoneNumber;
  String email;
  String _id;
  bool isVerified;
  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'isVerified':isVerified
    };
  }

  CommonProfile();

  String get id {
    return this._id;
  }

  CommonProfile.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.name = temp['name'];
    this.address = temp['address'];
    this.phoneNumber = temp['phoneNumber'];
    this.email = temp['email'];
    this.isVerified=temp['isVerified'];
  }
}
