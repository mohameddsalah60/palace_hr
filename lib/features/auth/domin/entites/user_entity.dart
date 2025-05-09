class UserEntity {
  final String name;
  final String email;
  final String phone;
  int countPermission;
  int countAnnualDays;
  String? faceIdUrl;
  final String token;

  UserEntity({
    this.countPermission = 3,
    this.countAnnualDays = 22,
    this.faceIdUrl = '',
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });
}
