class PriciesServiceModel {
  final String id;
  final String item;
  final String price;
  final String img;
  final int qty;
  const PriciesServiceModel({
    required this.id,
    required this.item,
    required this.price,
    required this.img,
    required this.qty,
  });

  PriciesServiceModel copyWith({
    String? id,
    String? item,
    String? price,
    String? img,
    int? qty,
  }) {
    return PriciesServiceModel(
      id: id ?? this.id,
      item: item ?? this.item,
      price: price ?? this.price,
      img: img ?? this.img,
      qty: qty ?? this.qty,
    );
  }

  factory PriciesServiceModel.fromJson(Map<String, dynamic> json) {
    return PriciesServiceModel(
      id: json['id'],
      item: json['item'],
      price: json['price'],
      img: json['img'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item,
      'price': price,
      'img': img,
      'qty': qty,
    };
  }

  @override
  String toString() =>
      '''PriciesServiceModel(id: $id, item: $item, price: $price)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PriciesServiceModel &&
        other.id == id &&
        other.item == item &&
        other.price == price &&
        other.qty == qty;
  }

  num get totalPrice => (num.tryParse(price) ?? 0) * qty;

  @override
  int get hashCode =>
      id.hashCode ^ item.hashCode ^ price.hashCode ^ qty.hashCode;
}

List<PriciesServiceModel> dummyPriciesServiceModel = const [
  PriciesServiceModel(
    id: '1',
    item: 'item',
    price: '2000',
    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
    qty: 1,
  ),
  PriciesServiceModel(
    id: '2',
    item: 'item',
    price: '2000',
    qty: 1,
    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
  ),
  PriciesServiceModel(
    id: '3',
    item: 'item',
    price: '2000',
    qty: 1,
    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
  ),
  PriciesServiceModel(
    id: '4',
    item: 'item',
    price: '2000',
    qty: 1,

    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
  ),
  PriciesServiceModel(
    id: '5',
    item: 'item',
    price: '2000',
    qty: 1,

    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
  ),
  PriciesServiceModel(
    id: '6',
    item: 'item',
    qty: 1,

    price: '2000',
    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
  ),
  PriciesServiceModel(
    id: '7',
    item: 'item',
    price: '2000',
    qty: 1,

    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
  ),
  PriciesServiceModel(
    id: '8',
    item: 'item',
    price: '2000',
    qty: 1,

    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
  ),
  PriciesServiceModel(
    id: '9',
    item: 'item',
    qty: 1,

    price: '2000',
    img:
        "https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg",
  ),
];
