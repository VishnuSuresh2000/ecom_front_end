class Product {
  String name;
  String description;
  String _id;
  bool inKg;
  CategorySection category;
  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      "name": name,
      "description": description,
      'category': category.toMap(),
      'inKg': inKg
    };
  }

  Product();

  Product.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.name = temp['name'];
    this.description = temp['description'];
    this.category = CategorySection.fromMap(temp['category']);
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
    this.address = temp['address'];
    this.phoneNumber = temp['phoneNumber'];
    this.email = temp['email'];
    this.isVerified = temp['isVerified'];
  }
}

class ProductList {
  String _id;
  Product product;
  CommonProfile seller;
  CommonProfile farmer;
  int count;
  bool isVerified;
  bool toShow;
  DateTime dateOfCreation;
  DateTime dateOfUpdate;
  int amount;

  String get id {
    return this._id;
  }

  ProductList();

  ProductList.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.product = Product.fromMap(temp['product_id']);
    this.farmer = CommonProfile.fromMap(temp['farmer_id']);
    this.seller = CommonProfile.fromMap(temp['seller_id']);
    this.count = temp['count'];
    this.isVerified = temp['isVerified'] ?? null;
    this.toShow = temp['toShow'];
    this.dateOfCreation = temp['dateOfCreation'] == null
        ? null
        : DateTime.parse(temp['dateOfCreation']);
    this.dateOfUpdate = temp['dateOfUpdate'] == null
        ? null
        : DateTime.parse(temp['dateOfUpdate']);
    this.amount = temp['amount'];
  }

  ProductList.fromMapMinimal(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.product = Product.fromMapMinimal(temp['product_id']);
    this.amount = temp['amount'];
  }

  Map<String, dynamic> toMaopMinamal() {
    return {'_id': _id, 'amount': amount, 'product_id': product.toMapMinimal()};
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'product_id': product.id,
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

  Map<String, dynamic> toMapForCreate() {
    return {
      'product_id': product.id,
      'farmer_id': farmer.id,
      'seller_id': seller.id,
      'count': count,
      'toShow': toShow,
      'amount': amount
    };
  }
}

class Cart {
  String _id;
  bool paymentComplete;
  DateTime dataOfCreation;
  String customerId;
  ProductList productList;
  int count;
  bool completed;

  Cart.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.paymentComplete = temp['paymentComplete'];
    this.customerId = temp['customer_id'];
    this.productList = ProductList.fromMapMinimal(temp['productlist_id']);
    this.count = temp['count'];
    this.completed=temp['completed']==null?false:temp['completed'];
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
      'productlist_id': this.productList.toMaopMinamal(),
      'count': this.count
    };
  }
}
