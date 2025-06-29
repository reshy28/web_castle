class HomeDatasModel {
  final int? errorCode;
  final String? message;
  final HomeData? data;

  HomeDatasModel({this.errorCode, this.message, this.data});

  factory HomeDatasModel.fromJson(Map<String, dynamic> json) {
    return HomeDatasModel(
      errorCode: json['error_code'],
      message: json['message'],
      data: json['data'] != null ? HomeData.fromJson(json['data']) : null,
    );
  }
}

class HomeData {
  final List<HomeField>? homeFields;
  final int? notificationCount;

  HomeData({this.homeFields, this.notificationCount});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      homeFields: (json['home_fields'] as List?)
          ?.map((e) => HomeField.fromJson(e))
          .toList(),
      notificationCount: json['notification_count'],
    );
  }
}

class HomeField {
  final String? type;
  final List<CarouselItem>? carouselItems;
  final List<Brand>? brands;
  final List<Category>? categories;
  final String? image;
  final List<BannerGrid>? banners;
  final BannerModel? banner;
  final int? collectionId;
  final String? name;
  final List<Product>? products;

  HomeField({
    this.type,
    this.carouselItems,
    this.brands,
    this.categories,
    this.image,
    this.banners,
    this.banner,
    this.collectionId,
    this.name,
    this.products,
  });

  factory HomeField.fromJson(Map<String, dynamic> json) {
    return HomeField(
      type: json['type'],
      carouselItems: (json['carousel_items'] as List?)
          ?.map((e) => CarouselItem.fromJson(e))
          .toList(),
      brands: (json['brands'] as List?)?.map((e) => Brand.fromJson(e)).toList(),
      categories: (json['categories'] as List?)
          ?.map((e) => Category.fromJson(e))
          .toList(),
      image: json['image'],
      banners: (json['banners'] as List?)
          ?.map((e) => BannerGrid.fromJson(e))
          .toList(),
      banner: json['banner'] != null
          ? BannerModel.fromJson(json['banner'])
          : null,
      collectionId: json['collection_id'],
      name: json['name'],
      products: (json['products'] as List?)
          ?.map((e) => Product.fromJson(e))
          .toList(),
    );
  }
}

class CarouselItem {
  final int? id;
  final String? image;
  final String? type;

  CarouselItem({this.id, this.image, this.type});

  factory CarouselItem.fromJson(Map<String, dynamic> json) {
    return CarouselItem(
      id: json['id'],
      image: json['image'],
      type: json['type'],
    );
  }
}

class Brand {
  final int? id;
  final String? name;
  final String? image;

  Brand({this.id, this.name, this.image});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(id: json['id'], name: json['name'], image: json['image']);
  }
}

class Category {
  final int? id;
  final String? name;
  final String? image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name'], image: json['image']);
  }
}

class BannerGrid {
  final String? image;
  final String? type;
  final int? id;

  BannerGrid({this.image, this.type, this.id});

  factory BannerGrid.fromJson(Map<String, dynamic> json) {
    return BannerGrid(image: json['image'], type: json['type'], id: json['id']);
  }
}

class BannerModel {
  final int? id;
  final String? image;
  final String? type;

  BannerModel({this.id, this.image, this.type});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: json['image'],
      type: json['type'],
    );
  }
}

class Product {
  final int? id;
  final String? image;
  final String? name;
  final String? currency;
  final String? unit;
  final bool? wishlisted;
  final bool? rfqStatus;
  final int? cartCount;
  final int? futureCartCount;
  final bool? hasStock;
  final String? price;
  final String? actualPrice;
  final String? offer;
  final List<dynamic>? offerPrices;

  Product({
    this.id,
    this.image,
    this.name,
    this.currency,
    this.unit,
    this.wishlisted,
    this.rfqStatus,
    this.cartCount,
    this.futureCartCount,
    this.hasStock,
    this.price,
    this.actualPrice,
    this.offer,
    this.offerPrices,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      currency: json['currency'],
      unit: json['unit'],
      wishlisted: json['wishlisted'],
      rfqStatus: json['rfq_status'],
      cartCount: json['cart_count'],
      futureCartCount: json['future_cart_count'],
      hasStock: json['has_stock'],
      price: json['price'],
      actualPrice: json['actual_price'],
      offer: json['offer'],
      offerPrices: json['offer_prices'],
    );
  }
}
