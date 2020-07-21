class Product {
  String name;
  String description;
  String _id;
  bool inKg;
  CategorySection category;
  List<Salles> list;

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      "name": name,
      "description": description,
      'category': category == null ? null : category.toMap(),
      'inKg': inKg
    };
  }

  Product();

  Product.fromMap(Map<String, dynamic> temp) {
    
    this._id = temp['_id'];
    this.name = temp['name'];
    this.description = temp['description'];
    this.category = temp['category'] is String
        ? CategorySection.onlyId(temp['category'])
        : CategorySection.fromMap(temp['category']);
    this.inKg = temp['inKg'];
  }
  Product.fromMapMinimal(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.name = temp['name'];
  }
  String get id {
    return this._id;
  }

  Map<String, dynamic> toMapMinimal() {
    return {
      '_id': _id,
      "name": name,
    };
  }
}

class CategorySection {
  String name;
  String _id;

  CategorySection();

  Map<String, dynamic> toMap() {
    return {'_id': _id, 'name': name};
  }

  CategorySection.onlyId(String id) {
    this._id = id;
  }
  CategorySection.fromMap(Map<String, dynamic> temp) {
    this.name = temp['name'] ?? null;
    this._id = temp['_id'] ?? null;
  }
  String get id {
    return this._id;
  }

  set id(String id) {
    this._id = id;
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
      'isVerified': isVerified
    };
  }

  CommonProfile();

  String get id {
    return this._id;
  }

  CommonProfile.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.name = temp['name'];
    this.address = temp['address'] ?? null;
    this.phoneNumber = temp['phoneNumber'] ?? null;
    this.email = temp['email'] ?? null;
    this.isVerified = temp['isVerified'] ?? null;
  }
}

class Salles {
  String _id;
  CommonProfile seller;
  CommonProfile farmer;
  int count;
  bool isVerified=false;
  bool toShow=false;
  DateTime dateOfCreation;
  DateTime dateOfUpdate;
  int amount;

  String get id {
    return this._id;
  }

  Salles();

  Salles.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.farmer = CommonProfile.fromMap(temp['farmer_id']);
    this.seller = CommonProfile.fromMap(temp['seller_id']);
    this.count = temp['count']??null;
    this.isVerified = temp['isVerified'] ?? null;
    this.toShow = temp['toShow']??null;
    this.dateOfCreation = temp['dateOfCreation'] == null
        ? null
        : DateTime.parse(temp['dateOfCreation']);
    this.dateOfUpdate = temp['dateOfUpdate'] == null
        ? null
        : DateTime.parse(temp['dateOfUpdate']);
    this.amount = temp['amount']??null;
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'farmer_id': farmer.toMap(),
      'seller_id': seller.toMap(),
      'count': count,
      'isVerified': isVerified,
      'toShow': toShow,
      'dateOfCreation': dateOfCreation,
      'dateOfUpdate': dateOfUpdate,
      'amount': amount
    };
  }
  Map<String, dynamic> toMapToAdd() {
    return {
      'farmer_id': farmer.id,
      'seller_id': seller.id,
      'count': count,
      'isVerified': isVerified,
      'toShow': toShow,
      'dateOfCreation': dateOfCreation,
      'dateOfUpdate': dateOfUpdate,
      'amount': amount
    };
  }
}

class Cart {
  String _id;
  bool paymentComplete;
  DateTime dataOfCreation;
  String customerId;
  Salles productList;
  int count;
  bool completed;

  Cart.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.paymentComplete = temp['paymentComplete'];
    this.customerId = temp['customer_id'];
    // this.productList = Salles.fromMapMinimal(temp['productlist_id']);
    this.count = temp['count'];
    this.completed = temp['completed'] == null ? false : temp['completed'];
  }
  Cart();
  String get id {
    return this._id;
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': this._id,
      'paymentComplete': this.paymentComplete,
      'customer_id': this.customerId,
      // 'productlist_id': this.productList.toMaopMinamal(),
      'count': this.count
    };
  }
}
