class IdentityData {
  final String fullName;
  final String firstName;
  final String lastName;
  final String gender;
  final String dateOfBirth;
  final String age;
  final String height;
  final String weight;
  final String bloodType;
  final String eyeColor;
  final String hairColor;
  final String occupation;
  final String address;
  final String city;
  final String stateOrProvince;
  final String postalCode;
  final String phone;
  final String email;
  final String username;
  final String country;
  final Map<String, String> additionalFields;

  IdentityData({
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.age,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.eyeColor,
    required this.hairColor,
    required this.occupation,
    required this.address,
    required this.city,
    required this.stateOrProvince,
    required this.postalCode,
    required this.phone,
    required this.email,
    required this.username,
    required this.country,
    this.additionalFields = const {},
  });

  Map<String, String> toMap() {
    final map = {
      'Full Name': fullName,
      'First Name': firstName,
      'Last Name': lastName,
      'Gender': gender,
      'Date of Birth': dateOfBirth,
      'Age': age,
      'Height': height,
      'Weight': weight,
      'Blood Type': bloodType,
      'Eye Color': eyeColor,
      'Hair Color': hairColor,
      'Occupation': occupation,
      'Address': address,
      'City': city,
    };

    // Add state or province based on country
    if (country == 'Indonesia') {
      map['Province'] = stateOrProvince;
    } else {
      map['State'] = stateOrProvince;
    }

    map['Postal Code'] = postalCode;
    map['Phone'] = phone;
    map['Email'] = email;
    map['Username'] = username;

    // Add additional fields
    map.addAll(additionalFields);

    map['Country'] = country;

    return map;
  }
}
