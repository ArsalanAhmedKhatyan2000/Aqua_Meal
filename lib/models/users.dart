class Users {
  static String? _id;
  static String? _profileImage;
  static String? _name;
  static String? _email;
  static String? _password;
  static String? _phoneNumber;
  static DateTime? _userCreatedDate;
  static int? _status;
  static String? _address;

  Users({
    String? id,
    String? profileImage,
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    DateTime? userCreatedDate,
    String? address,
    int? status,
  }) {
    _id = id;
    _profileImage = profileImage;
    _name = name;
    _email = email;
    _password = password;
    _phoneNumber = phoneNumber;
    _userCreatedDate = userCreatedDate;
    _status = status;
    _address = address;
  }

  factory Users.fromMap({
    required Map<String, dynamic> map,
  }) {
    return Users(
      id: map['id'],
      name: map["name"],
      email: map["email"],
      password: map["password"],
      phoneNumber: map["phoneNumber"],
      profileImage: map["profileImage"],
      userCreatedDate: map["createdDate"].toDate(),
      status: map['status'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userID": _id,
      "name": _name,
      "email": _email,
      "password": _password,
      "phoneNumber": _phoneNumber,
      "profileImage": _profileImage,
      "createdDate": _userCreatedDate,
      "status": _status,
      "address": _address,
    };
  }

  factory Users.setAllFieldsNull() {
    return Users(
      name: "",
      email: "",
      password: "",
      phoneNumber: "",
      profileImage: "",
      userCreatedDate: null,
      status: 0,
      id: "",
      address: "",
    );
  }

  static String? get getUserId => _id;
  static String? get getName => _name;
  static String? get getEmail => _email;
  static String? get getPassword => _password;
  static String? get getPhoneNumber => _phoneNumber;
  static String? get getProfileImageURL => _profileImage;
  static int? get getStatus => _status;
  static String? get getAddress => _address;

  static setprofileImage({required String? newProfileImage}) {
    _profileImage = newProfileImage;
  }

  static setName({required String? newName}) {
    _name = newName;
  }

  static setEmail({required String? newEmail}) {
    _email = newEmail;
  }

  static setPhoneNumber({required String? newPhoneNumber}) {
    _phoneNumber = newPhoneNumber;
  }

  static setPassword({required String? newPassword}) {
    _password = newPassword;
  }

  static setAddress({required String? newAddress}) {
    _address = newAddress;
  }
}
