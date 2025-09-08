import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/is_english_locale_funcation.dart';
import '../../cubits/fetch_employees_requests_cubit/fetch_employees_requests_cubit.dart';
import 'request_catogry.dart';

class RequestCatogryList extends StatefulWidget {
  const RequestCatogryList({super.key});
  @override
  State<RequestCatogryList> createState() => _RequestCatogryListState();
}

class _RequestCatogryListState extends State<RequestCatogryList> {
  int count = 0;
  List<String> statusEn = ['pending', 'approved', 'rejected'];
  List<String> statusAr = ['قيد الانتظار', 'مقبول', 'مرفوض'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(statusEn.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              count = index;
            });
            context.read<FetchEmployeesRequestsCubit>().fetchRequestsBySort(
              status: isEnglishLocale() ? statusEn[index] : statusAr[index],
            );
          },
          child: RequestCatogry(
            text: isEnglishLocale() ? statusEn[index] : statusAr[index],
            isSelected: count == index,
          ),
        );
      }),
    );
  }
}
