import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:palace_hr/features/dashboard/presentation/cubits/employee_shift_changer_cubit/employee_shift_changer_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarShiftChanger extends StatelessWidget {
  const TableCalendarShiftChanger({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: .3,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: TableCalendar(
          firstDay: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
          lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
          focusedDay: context.watch<EmployeeShiftChangerCubit>().focusedDay,
          selectedDayPredicate:
              (day) => isSameDay(
                day,
                context.read<EmployeeShiftChangerCubit>().selectedDay,
              ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.saturday,
          onDaySelected: (selectedDay, focusedDay) {
            context.read<EmployeeShiftChangerCubit>().setSelectedDay(
              selectedDay,
            );
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: .8),
              shape: BoxShape.circle,
            ),
            selectedDecoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            markerDecoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
