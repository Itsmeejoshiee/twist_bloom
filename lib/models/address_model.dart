class AddressModel {
  String regionCityDistrict;
  String streetBuilding;
  String unitFloor;

  AddressModel({
    required this.regionCityDistrict,
    required this.streetBuilding,
    required this.unitFloor,
  });

  Map<String, dynamic> toMap() {
    return {
      'regionCityDistrict': regionCityDistrict,
      'streetBuilding': streetBuilding,
      'unitFloor': unitFloor,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      regionCityDistrict: map['regionCityDistrict'],
      streetBuilding: map['streetBuilding'],
      unitFloor: map['unitFloor'],
    );
  }
}
