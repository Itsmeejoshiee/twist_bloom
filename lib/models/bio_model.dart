class BioModel {
  String bio;

  BioModel({required this.bio});

  Map<String, dynamic> toMap() {
    return {
      'bio': bio,
    };
  }

  factory BioModel.fromMap(Map<String, dynamic> map) {
    return BioModel(
      bio: map['bio'] ?? '',
    );
  }
}
