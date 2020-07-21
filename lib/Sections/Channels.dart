enum apiNames { product, farmer, seller, category,poductList,cart }

class ApiNames {
  static Map api = <apiNames, String>{
    apiNames.category: "category",
    apiNames.product: "product",
    apiNames.farmer: "farmer",
    apiNames.seller: "seller",
    apiNames.poductList:"salles",
    apiNames.cart:"cart"
  };
  static String getApiNames(apiNames data) {
    return api[data];
  }

  static apiNames getApi(String name) {
    apiNames temp;
    api.forEach((key, value) {
      if (value == name.toLowerCase()) {
        temp = key;
      }
    });

    return temp;
  }
}
