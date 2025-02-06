class UserModel {
  String? name, email, image, phone;
  bool isOnline;

  UserModel(
      {required this.name,
      required this.email,
      required this.image,
      required this.phone,
      required this.isOnline});

  factory UserModel.fromMap(Map m1) {
    return UserModel(
        name: m1['name'],
        email: m1['email'],
        image: m1['image'],
        phone: m1['phone'],
        isOnline: m1['isOnline']);
  }

  Map<String, dynamic> toMap(UserModel user) {
    return {
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'phone': user.phone,
      'isOnline': user.isOnline,
    };
  }
}
