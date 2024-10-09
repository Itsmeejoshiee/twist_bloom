class Info {
  final String? id;
  final String name;
  final String bio;
  final String gender;
  final String birthday;
  final String image;
  final String phoneNum;
  final String email;
  final String address;

  Info({
    this.id,
    required this.name,
    required this.bio,
    required this.gender,
    required this.birthday,
    required this.image,
    required this.phoneNum,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'gender': gender,
      'birthday': birthday,
      'image': image,
      'phoneNum': phoneNum,
      'email': email,
      'address': address,
    };
  }

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      id: json['id'],
      name: json['name'],
      bio: json['bio'],
      gender: json['gender'],
      birthday: json['birthday'],
      image: json['image'],
      phoneNum: json['phoneNum'],
      email: json['email'],
      address: json['address'],
    );
  }
}
