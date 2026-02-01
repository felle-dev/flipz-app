import 'dart:math';
import 'package:flipz/models/identity_data.dart';
import 'package:flipz/config/identity_constants.dart';

class IdentityGeneratorController {
  final Random _random = Random();

  IdentityData generateIdentity(String country, String gender) {
    // Determine actual gender if random
    final actualGender = gender == 'Random'
        ? (_random.nextBool() ? 'Male' : 'Female')
        : gender;

    switch (country) {
      case 'United States':
        return _generateUSIdentity(actualGender);
      case 'Germany':
        return _generateGermanyIdentity(actualGender);
      case 'Indonesia':
        return _generateIndonesiaIdentity(actualGender);
      default:
        return _generateUSIdentity(actualGender);
    }
  }

  IdentityData _generateUSIdentity(String gender) {
    // Generate name
    final firstName = gender == 'Male'
        ? IdentityConstants.usMaleFirstNames[_random.nextInt(
            IdentityConstants.usMaleFirstNames.length,
          )]
        : IdentityConstants.usFemaleFirstNames[_random.nextInt(
            IdentityConstants.usFemaleFirstNames.length,
          )];
    final lastName = IdentityConstants
        .usLastNames[_random.nextInt(IdentityConstants.usLastNames.length)];
    final fullName = '$firstName $lastName';

    // Generate date of birth (age 18-50)
    final age = 18 + _random.nextInt(33);
    final birthYear = DateTime.now().year - age;
    final birthMonth = 1 + _random.nextInt(12);
    final birthDay = 1 + _random.nextInt(28);
    final dob =
        '${birthMonth.toString().padLeft(2, '0')}/${birthDay.toString().padLeft(2, '0')}/$birthYear';

    // Generate address
    final streetNumber = 100 + _random.nextInt(9900);
    final streetName = IdentityConstants
        .usStreetNames[_random.nextInt(IdentityConstants.usStreetNames.length)];
    final streetTypes = ['Street', 'Avenue', 'Road', 'Lane', 'Drive'];
    final streetType = streetTypes[_random.nextInt(streetTypes.length)];
    final address = '$streetNumber $streetName $streetType';

    // Generate city, state, zip
    final state = IdentityConstants.usStateZips.keys
        .toList()[_random.nextInt(IdentityConstants.usStateZips.length)];
    final city = IdentityConstants
        .usCities[_random.nextInt(IdentityConstants.usCities.length)];
    final zipCodes = IdentityConstants.usStateZips[state]!;
    final zipCode = zipCodes[_random.nextInt(zipCodes.length)];

    // Generate phone number
    final areaCode = 200 + _random.nextInt(800);
    final prefix = 200 + _random.nextInt(800);
    final lineNumber = 1000 + _random.nextInt(9000);
    final phone = '($areaCode) $prefix-$lineNumber';

    // Generate email
    final emailName =
        '${firstName.toLowerCase()}.${lastName.toLowerCase()}${_random.nextInt(999)}';
    final emailDomain = IdentityConstants
        .emailDomains[_random.nextInt(IdentityConstants.emailDomains.length)];
    final email = '$emailName$emailDomain';

    // Generate username
    final username =
        '${firstName.toLowerCase()}${lastName[0].toLowerCase()}${_random.nextInt(9999)}';

    // Generate additional details
    final bloodType = IdentityConstants
        .bloodTypes[_random.nextInt(IdentityConstants.bloodTypes.length)];
    final occupation = IdentityConstants
        .occupations[_random.nextInt(IdentityConstants.occupations.length)];

    // Generate height
    final heightFeet = gender == 'Male' ? 5 + _random.nextInt(2) : 5;
    final heightInches = _random.nextInt(12);
    final height = '$heightFeet\'$heightInches"';

    // Generate weight
    final weight = gender == 'Male'
        ? 140 + _random.nextInt(100)
        : 110 + _random.nextInt(80);

    // Generate eye and hair color
    final eyeColor = IdentityConstants
        .usEyeColors[_random.nextInt(IdentityConstants.usEyeColors.length)];
    final hairColor = IdentityConstants
        .usHairColors[_random.nextInt(IdentityConstants.usHairColors.length)];

    // Generate SSN
    final ssn1 = 100 + _random.nextInt(900);
    final ssn2 = 10 + _random.nextInt(90);
    final ssn3 = 1000 + _random.nextInt(9000);
    final ssn = '$ssn1-$ssn2-$ssn3';

    // Generate Driver's License
    final dlState = state.substring(0, 2).toUpperCase();
    final dlNumber = List.generate(7, (_) => _random.nextInt(9)).join();
    final driverLicense = '$dlState-$dlNumber';

    // Generate Passport
    final passportNumber = List.generate(9, (_) => _random.nextInt(9)).join();

    // Generate Credit Card
    final ccNumber = '4${List.generate(15, (_) => _random.nextInt(10)).join()}';
    final cvv = List.generate(3, (_) => _random.nextInt(9)).join();
    final expMonth = (1 + _random.nextInt(12)).toString().padLeft(2, '0');
    final expYear = (DateTime.now().year + 1 + _random.nextInt(5))
        .toString()
        .substring(2);

    return IdentityData(
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      dateOfBirth: dob,
      age: age.toString(),
      height: height,
      weight: '$weight lbs',
      bloodType: bloodType,
      eyeColor: eyeColor,
      hairColor: hairColor,
      occupation: occupation,
      address: address,
      city: city,
      stateOrProvince: state,
      postalCode: zipCode,
      phone: phone,
      email: email,
      username: username,
      country: 'United States',
      additionalFields: {
        'SSN': ssn,
        'Driver License': driverLicense,
        'Passport': passportNumber,
        'Credit Card': ccNumber,
        'CVV': cvv,
        'Card Exp': '$expMonth/$expYear',
      },
    );
  }

  IdentityData _generateGermanyIdentity(String gender) {
    // Generate name
    final firstName = gender == 'Male'
        ? IdentityConstants.deMaleFirstNames[_random.nextInt(
            IdentityConstants.deMaleFirstNames.length,
          )]
        : IdentityConstants.deFemaleFirstNames[_random.nextInt(
            IdentityConstants.deFemaleFirstNames.length,
          )];
    final lastName = IdentityConstants
        .deLastNames[_random.nextInt(IdentityConstants.deLastNames.length)];
    final fullName = '$firstName $lastName';

    // Generate date of birth (age 18-50)
    final age = 18 + _random.nextInt(33);
    final birthYear = DateTime.now().year - age;
    final birthMonth = 1 + _random.nextInt(12);
    final birthDay = 1 + _random.nextInt(28);
    final dob =
        '${birthDay.toString().padLeft(2, '0')}.${birthMonth.toString().padLeft(2, '0')}.$birthYear';

    // Generate address
    final streetName = IdentityConstants
        .deStreetNames[_random.nextInt(IdentityConstants.deStreetNames.length)];
    final streetNumber = 1 + _random.nextInt(200);
    final address = '${streetName}straße $streetNumber';

    // Generate city, state, zip
    final state = IdentityConstants.deStateZips.keys
        .toList()[_random.nextInt(IdentityConstants.deStateZips.length)];
    final city = IdentityConstants
        .deCities[_random.nextInt(IdentityConstants.deCities.length)];
    final zipCodes = IdentityConstants.deStateZips[state]!;
    final zipCode = zipCodes[_random.nextInt(zipCodes.length)];

    // Generate phone number
    final areaCode = 30 + _random.nextInt(970);
    final mainNumber = 10000000 + _random.nextInt(90000000);
    final phone = '+49 $areaCode $mainNumber';

    // Generate email
    final emailName =
        '${firstName.toLowerCase()}.${lastName.toLowerCase()}${_random.nextInt(999)}';
    final emailDomain = IdentityConstants
        .emailDomains[_random.nextInt(IdentityConstants.emailDomains.length)];
    final email = '$emailName$emailDomain';

    // Generate username
    final username =
        '${firstName.toLowerCase()}${lastName[0].toLowerCase()}${_random.nextInt(9999)}';

    // Generate additional details
    final bloodType = IdentityConstants
        .bloodTypes[_random.nextInt(IdentityConstants.bloodTypes.length)];
    final occupation = IdentityConstants
        .occupations[_random.nextInt(IdentityConstants.occupations.length)];

    // Generate height (in cm)
    final height = gender == 'Male'
        ? 165 + _random.nextInt(25)
        : 155 + _random.nextInt(20);

    // Generate weight (in kg)
    final weight = gender == 'Male'
        ? 65 + _random.nextInt(40)
        : 50 + _random.nextInt(35);

    // Generate eye and hair color
    final eyeColor = IdentityConstants
        .deEyeColors[_random.nextInt(IdentityConstants.deEyeColors.length)];
    final hairColor = IdentityConstants
        .deHairColors[_random.nextInt(IdentityConstants.deHairColors.length)];

    // Generate ID Number
    final idNumber = 'L${List.generate(9, (_) => _random.nextInt(9)).join()}';

    // Generate Tax ID
    final taxId = List.generate(11, (_) => _random.nextInt(10)).join();

    // Generate Passport
    final passportNumber =
        'C${List.generate(8, (_) => _random.nextInt(10)).join()}';

    // Generate IBAN
    final iban =
        'DE${_random.nextInt(99).toString().padLeft(2, '0')} ${_random.nextInt(9999).toString().padLeft(4, '0')} ${_random.nextInt(9999).toString().padLeft(4, '0')} ${_random.nextInt(9999).toString().padLeft(4, '0')} ${_random.nextInt(9999).toString().padLeft(4, '0')} ${_random.nextInt(99).toString().padLeft(2, '0')}';

    return IdentityData(
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      dateOfBirth: dob,
      age: age.toString(),
      height: '$height cm',
      weight: '$weight kg',
      bloodType: bloodType,
      eyeColor: eyeColor,
      hairColor: hairColor,
      occupation: occupation,
      address: address,
      city: city,
      stateOrProvince: state,
      postalCode: zipCode,
      phone: phone,
      email: email,
      username: username,
      country: 'Germany',
      additionalFields: {
        'ID Number': idNumber,
        'Tax ID': taxId,
        'Passport': passportNumber,
        'IBAN': iban,
      },
    );
  }

  IdentityData _generateIndonesiaIdentity(String gender) {
    // Generate name
    final firstName = gender == 'Male'
        ? IdentityConstants.idMaleFirstNames[_random.nextInt(
            IdentityConstants.idMaleFirstNames.length,
          )]
        : IdentityConstants.idFemaleFirstNames[_random.nextInt(
            IdentityConstants.idFemaleFirstNames.length,
          )];
    final lastName = IdentityConstants
        .idLastNames[_random.nextInt(IdentityConstants.idLastNames.length)];
    final fullName = '$firstName $lastName';

    // Generate date of birth (age 18-50)
    final age = 18 + _random.nextInt(33);
    final birthYear = DateTime.now().year - age;
    final birthMonth = 1 + _random.nextInt(12);
    final birthDay = 1 + _random.nextInt(28);
    final dob =
        '${birthDay.toString().padLeft(2, '0')}-${birthMonth.toString().padLeft(2, '0')}-$birthYear';

    // Generate address
    final streetName = IdentityConstants
        .idStreetNames[_random.nextInt(IdentityConstants.idStreetNames.length)];
    final streetNumber = 1 + _random.nextInt(200);
    final address = '$streetName No. $streetNumber';

    // Generate city, province, zip
    final province = IdentityConstants.idProvinceZips.keys
        .toList()[_random.nextInt(IdentityConstants.idProvinceZips.length)];
    final city = IdentityConstants
        .idCities[_random.nextInt(IdentityConstants.idCities.length)];
    final zipCodes = IdentityConstants.idProvinceZips[province]!;
    final zipCode = zipCodes[_random.nextInt(zipCodes.length)];

    // Generate phone number
    final operators = ['812', '813', '821', '822', '851', '852'];
    final operator = operators[_random.nextInt(operators.length)];
    final mainNumber = 10000000 + _random.nextInt(90000000);
    final phone = '+62 $operator-$mainNumber';

    // Generate email
    final emailName =
        '${firstName.toLowerCase()}.${lastName.toLowerCase()}${_random.nextInt(999)}';
    final emailDomain = IdentityConstants
        .emailDomains[_random.nextInt(IdentityConstants.emailDomains.length)];
    final email = '$emailName$emailDomain';

    // Generate username
    final username =
        '${firstName.toLowerCase()}${lastName[0].toLowerCase()}${_random.nextInt(9999)}';

    // Generate additional details
    final bloodType = IdentityConstants
        .bloodTypes[_random.nextInt(IdentityConstants.bloodTypes.length)];
    final occupation = IdentityConstants
        .occupations[_random.nextInt(IdentityConstants.occupations.length)];

    // Generate height (in cm)
    final height = gender == 'Male'
        ? 160 + _random.nextInt(25)
        : 150 + _random.nextInt(20);

    // Generate weight (in kg)
    final weight = gender == 'Male'
        ? 55 + _random.nextInt(40)
        : 45 + _random.nextInt(35);

    // Generate religion
    final religion = IdentityConstants
        .idReligions[_random.nextInt(IdentityConstants.idReligions.length)];

    // Generate marital status
    final maritalStatus =
        IdentityConstants.idMaritalStatuses[_random.nextInt(
          IdentityConstants.idMaritalStatuses.length,
        )];

    // Generate NIK
    final nik = List.generate(16, (_) => _random.nextInt(10)).join();

    // Generate NPWP
    final npwp =
        '${List.generate(2, (_) => _random.nextInt(10)).join()}.${List.generate(3, (_) => _random.nextInt(10)).join()}.${List.generate(3, (_) => _random.nextInt(10)).join()}.${_random.nextInt(9)}-${List.generate(3, (_) => _random.nextInt(10)).join()}.${List.generate(3, (_) => _random.nextInt(10)).join()}';

    // Generate Passport
    final passportNumber =
        '${String.fromCharCode(65 + _random.nextInt(26))}${List.generate(7, (_) => _random.nextInt(10)).join()}';

    // Generate Driver's License
    final simNumber =
        '${List.generate(4, (_) => _random.nextInt(10)).join()} ${List.generate(4, (_) => _random.nextInt(10)).join()} ${List.generate(4, (_) => _random.nextInt(10)).join()}';

    return IdentityData(
      fullName: fullName,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      dateOfBirth: dob,
      age: age.toString(),
      height: '$height cm',
      weight: '$weight kg',
      bloodType: bloodType,
      eyeColor: '', // Not applicable
      hairColor: '', // Not applicable
      occupation: occupation,
      address: address,
      city: city,
      stateOrProvince: province,
      postalCode: zipCode,
      phone: phone,
      email: email,
      username: username,
      country: 'Indonesia',
      additionalFields: {
        'Religion': religion,
        'Marital Status': maritalStatus,
        'NIK': nik,
        'NPWP': npwp,
        'Passport': passportNumber,
        'Driver License': simNumber,
      },
    );
  }
}
