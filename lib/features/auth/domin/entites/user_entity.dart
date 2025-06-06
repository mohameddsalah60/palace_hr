class UserEntity {
  final String name;
  final String email;
  final String phone;
  int countPermission;
  int countAnnualDays;
  String? faceIdUrl;
  String token;
  final String jobTitle;
  final String? offDay;

  UserEntity({
    required this.jobTitle,
    this.offDay,
    this.countPermission = 3,
    this.countAnnualDays = 22,
    this.faceIdUrl = '',
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });
}
