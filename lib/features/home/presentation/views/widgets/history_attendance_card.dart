import 'package:flutter/material.dart';

class SimpleHorizontalAttendanceItem extends StatelessWidget {
  final DateTime date;
  final DateTime checkIn;
  final DateTime checkOut;

  const SimpleHorizontalAttendanceItem({
    super.key,
    required this.date,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          // التاريخ
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_pad(date.day)} ${_monthName(date.month)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _weekdayName(date.weekday),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          // دخول
          _buildTimeColumn(
            label: 'دخول',
            time: _formatTime(checkIn),
            icon: Icons.login,
            color: Colors.green,
          ),
          const SizedBox(width: 20),
          // خروج
          _buildTimeColumn(
            label: 'خروج',
            time: _formatTime(checkOut),
            icon: Icons.logout,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn({
    required String label,
    required String time,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  String _formatTime(DateTime dt) =>
      '${_pad(dt.hour)}:${_pad(dt.minute)}:${_pad(dt.second)}';

  String _pad(int n) => n.toString().padLeft(2, '0');

  String _monthName(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return months[month - 1];
  }

  String _weekdayName(int day) {
    const days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return days[(day + 5) % 7]; // لضبط الترتيب حسب اللغة العربية
  }
}
