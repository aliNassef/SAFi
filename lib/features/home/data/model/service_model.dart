import 'package:equatable/equatable.dart';

class ServiceModel extends Equatable {
  final String img;
  final String desc;
  final String name;
  final String id;
  const ServiceModel({
    required this.img,
    required this.desc,
    required this.name,
    required this.id,
  });

  factory ServiceModel.fromMap(map) {
    return ServiceModel(
      desc: map['description'],
      img: map['img'],
      name: map['name'],
      id: map['id'],
    );
  }

  @override
  List<Object?> get props => [img, name, desc];
}

List<ServiceModel> dummyServices = const [
  ServiceModel(
    img:
        'https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg',
    desc: 'كى و غشل ',
    name: 'كى و غشل ',
    id: '',
  ),
  ServiceModel(
    img:
        'https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg',
    desc: 'كى و غشل ',
    name: 'كى و غشل ',
    id: '',
  ),

  ServiceModel(
    img:
        'https://www.almawq3.com/wp-content/uploads/2022/05/%D8%BA%D8%B3%D9%8A%D9%84.jpg',
    desc: 'كى و غشل ',
    name: 'كى و غشل ',
    id: '',
  ),
];
