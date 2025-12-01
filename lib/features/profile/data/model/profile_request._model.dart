import 'dart:io';

class ProfileRequestModel {
  final File? image;
  final String? name;
  final String? phone;
  final String? email;
  final String userId;
  final String? imageUrl;
  const ProfileRequestModel({
    this.image,
    this.name,
    this.phone,
    this.email,
    required this.userId,
    this.imageUrl,
  });

  factory ProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return ProfileRequestModel(
      name: json['name'],
      phone: json['phone'],
      userId: json['userId'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      image: json['imagePath'] != null ? File(json['imagePath']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'userId': userId,
      'imageUrl': imageUrl,
      'imagePath': image?.path,
    };
  }

  ProfileRequestModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? imageUrl,
    File? image,
  }) {
    return ProfileRequestModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      userId: userId,
      imageUrl: imageUrl ?? this.imageUrl,
      image: image ?? this.image,
    );
  }
}
