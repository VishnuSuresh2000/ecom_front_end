class Product {
  String name;
  String description;
  String _id;
  bool hasImg;
  bool inKg;
  CategorySection category;
  List<Salles> list;
  int amount;
  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      "name": name,
      "description": description,
      'category': category == null ? null : category.toMap(),
      'inKg': inKg,
      'amount': amount
    };
  }

  Product();

  Product.fromMap(Map<String, dynamic> temp) {
    this.hasImg = temp['hasImg']??null;
    this._id = temp['_id'];
    this.name = temp['name'];
    this.description = temp['description'];
    this.category = temp['category'] is String
        ? CategorySection.onlyId(temp['category'])
        : CategorySection.fromMap(temp['category']);
    this.inKg = temp['inKg'];
    this.amount = temp['amount'] ?? null;
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
  String firstName;
  String lastName;
  int phoneNumber;
  String email;
  Address address;
  String _id;
  bool sex;
  bool isVerified;

  String get fullName {
    return "$firstName ${lastName ?? ""}";
  }

  String get id {
    return _id;
  }

  set id(String id) {
    this._id = id;
  }

  CommonProfile() {
    this.address = Address();
  }
  CommonProfile.fromMap(Map<String, dynamic> data) {
    this._id = data["_id"] ?? null;
    this.firstName = data['firstName'] ?? null;
    this.lastName = data['lastName'] ?? null;
    this.phoneNumber = data['phoneNumber'] ?? null;
    this.sex = data['sex'] ?? null;
    this.address =
        data['address'] == null ? Address() : Address.fromMap(data['address']);
    this.email = data['email'] ?? null;
    this.isVerified = data['isVerified'] ?? null;
  }
  CommonProfile.fromMapTest(Map<String, dynamic> data) {
    this.firstName = data['name'] ?? null;
    this.lastName = data['lastName'] ?? null;
    this.phoneNumber = data['phoneNumber'] ?? null;
    this.sex = data['sex'] ?? null;
    this.address =
        data['address'] == null ? null : Address.fromMap(data['address']);
    this.email = data['email'] ?? null;
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': this.firstName ?? null,
      'lastName': this.lastName ?? null,
      'phoneNumber': this.phoneNumber ?? null,
      'sex': this.sex ?? null,
      'address': this.address == null ? null : this.address.toMap(),
      'email': this.email ?? null
    };
  }
}

class Address {
  String houseName;
  String locality;
  String city;
  String district;
  String state;
  int pinCode;
  int alternateNumber;
  Address();
  Address.fromMap(Map<String, dynamic> data) {
    this.houseName = data['houseName'];
    this.locality = data['locality'];
    this.pinCode = data['pinCode'];
    this.city = data['city'];
    this.district = data['district'];
    this.state = data['state'];
    this.alternateNumber = data['alternateNumber'] ?? null;
  }
  Map<String, dynamic> toMap() {
    return {
      'houseName': this.houseName ?? null,
      'locality': this.locality ?? null,
      'pinCode': this.pinCode ?? null,
      'city': this.city ?? null,
      'district': this.district ?? null,
      'state': this.state ?? null,
      'alternateNumber': this.alternateNumber ?? null,
    };
  }
}

class Salles {
  String _id;
  CommonProfile seller;
  CommonProfile farmer;
  int count;
  bool isVerified = false;
  bool toShow = false;
  DateTime dateOfCreation;
  DateTime dateOfUpdate;

  String get id {
    return this._id;
  }

  Salles();

  Salles.fromMap(Map<String, dynamic> temp) {
    this._id = temp['_id'];
    this.farmer = CommonProfile.fromMap(temp['farmer_id']);
    this.seller = CommonProfile.fromMap(temp['seller_id']);
    this.count = temp['count'] ?? null;
    this.isVerified = temp['isVerified'] ?? null;
    this.toShow = temp['toShow'] ?? null;
    this.dateOfCreation = temp['dateOfCreation'] == null
        ? null
        : DateTime.parse(temp['dateOfCreation']);
    this.dateOfUpdate = temp['dateOfUpdate'] == null
        ? null
        : DateTime.parse(temp['dateOfUpdate']);
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
