class ProductModel {
  int? totalElements;
  int? totalPages;
  int? size;
  List<Content>? content;
  int? number;
  Sort? sort;
  bool? first;
  bool? last;
  int? numberOfElements;
  Pageable? pageable;
  bool? empty;

  ProductModel({
    this.totalElements,
    this.totalPages,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.first,
    this.last,
    this.numberOfElements,
    this.pageable,
    this.empty,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    size = json['size'];
    content = json['content'] != null
        ? List<Content>.from(json['content'].map((v) => Content.fromJson(v)))
        : null;
    number = json['number'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    first = json['first'];
    last = json['last'];
    numberOfElements = json['numberOfElements'];
    pageable =
    json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
    data['size'] = size;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    data['number'] = number;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['first'] = first;
    data['last'] = last;
    data['numberOfElements'] = numberOfElements;
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    data['empty'] = empty;
    return data;
  }
}

class Content {
  String? id;
  String? name;
  double? marketPrice;
  double? salePrice;
  String? skuCode;
  String? description;
  ProductMetaData? productMetaData;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<String>? categories;

  Content({
    this.id,
    this.name,
    this.marketPrice,
    this.salePrice,
    this.skuCode,
    this.description,
    this.productMetaData,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.categories,
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    marketPrice = json['marketPrice'];
    salePrice = json['salePrice'];
    skuCode = json['skuCode'];
    description = json['description'];
    productMetaData = json['productMetaData'] != null
        ? ProductMetaData.fromJson(json['productMetaData'])
        : null;
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    categories = json['categories'] != null
        ? List<String>.from(json['categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['marketPrice'] = marketPrice;
    data['salePrice'] = salePrice;
    data['skuCode'] = skuCode;
    data['description'] = description;
    if (productMetaData != null) {
      data['productMetaData'] = productMetaData!.toJson();
    }
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (categories != null) {
      data['categories'] = categories;
    }
    return data;
  }
}

class ProductMetaData {
  String? size;
  String? color;

  ProductMetaData({this.size, this.color});

  ProductMetaData.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['color'] = color;
    return data;
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['empty'] = empty;
    data['sorted'] = sorted;
    data['unsorted'] = unsorted;
    return data;
  }
}

class Pageable {
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.paged,
    this.unpaged,
  });

  Pageable.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['offset'] = offset;
    data['paged'] = paged;
    data['unpaged'] = unpaged;
    return data;
  }
}
