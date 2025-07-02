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
  final bool? isAdmin;

  UserEntity({
    required this.jobTitle,
    this.offDay,
    this.countPermission = 3,
    this.countAnnualDays = 22,
    this.faceIdUrl = '',
    this.isAdmin = false,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
  });
}
