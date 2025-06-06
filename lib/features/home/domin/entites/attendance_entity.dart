class AttendanceEntity {
  final DateTime dateTime;
  final String checkIn;
  String? checkOut;
  final bool isLate;
  final Map<String, double> location;

  AttendanceEntity({
    required this.dateTime,
    required this.checkIn,
    this.checkOut,
    required this.isLate,
    required this.location,
  });
}
