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
      'region': regionCityDistrict,
      'street': streetBuilding,
      'unit': unitFloor,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      regionCityDistrict: map['region'],
      streetBuilding: map['street'],
      unitFloor: map['unit'],
    );
  }
}
