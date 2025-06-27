import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/helpers/is_english_locale_funcation.dart';

import '../../../../../core/helpers/get_user.dart';
import 'user_request_info.dart';

class UserRequestInfoList extends StatefulWidget {
  const UserRequestInfoList({super.key});

  @override
  State<UserRequestInfoList> createState() => _UserRequestInfoListState();
}

class _UserRequestInfoListState extends State<UserRequestInfoList> {
  List<String> titlesEn = ['Permissions', 'Annoul Leave', 'Sick Leave'];
  List<String> titlesAr = ['اذونات', 'إجازة سنوية', "إجازة مرضية"];
  List<int> values = [getUser().countPermission, getUser().countAnnualDays, 30];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return Padding(
            padding:
                index == 1
                    ? EdgeInsets.symmetric(horizontal: 12.0.r)
                    : EdgeInsets.all(0),
            child: UserRequestInfo(
              title: isEnglishLocale() ? titlesEn[index] : titlesAr[index],
              count: values[index].toString(),
            ),
          );
        }),
      ),
    );
  }
}
