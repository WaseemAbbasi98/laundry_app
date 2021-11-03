class MyUser {
  final String userId;
  final String name;
  final String cnic;
  final String email;
  final String address;
  final String picture;
  final String mobileNo;
  final String password;
  final String type;

  MyUser(
      {required this.name,
      required this.cnic,
      required this.email,
      required this.mobileNo,
      required this.picture,
      required this.address,
      required this.password,
      required this.type,
      required this.userId});

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
        name: json['name'] ?? 'your name',
        cnic: json['cnic'] ?? 'your cnic',
        email: json['email'] ?? 'your email',
        mobileNo: json['mobileno'] ?? 'your phone',
        picture: json['picture'] ??
            'https://w7.pngwing.com/pngs/639/452/png-transparent-computer-icons-avatar-user-profile-people-icon-child-face-heroes.png',
        address: json['address'] ?? 'your location',
        password: json['password'] ?? 'your password',
        type: json['type'] ?? 'user type',
        userId: json['userid']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cnic': cnic,
      'email': email,
      'mobileno': mobileNo,
      'picture': picture,
      'address': address,
      'password': password,
      'type': type,
      'userid': userId,
    };
  }
}
