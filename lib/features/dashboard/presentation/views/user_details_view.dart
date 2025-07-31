import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palace_hr/core/utils/app_colors.dart';
import 'package:palace_hr/core/utils/app_text_styles.dart';
import 'package:palace_hr/core/widgets/custom_app_bar.dart';
import 'package:palace_hr/features/auth/domin/entites/user_entity.dart';

import 'widgets/user_details_card.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      appBar: buildAppBar(context, title: 'Employee Details'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.r),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 8.h)),
            SliverToBoxAdapter(child: UserDetailsCard(user: user)),
            SliverToBoxAdapter(child: SizedBox(height: 8.h)),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = _activityData[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _ActivityItem(data: item),
                );
              }, childCount: _activityData.length),
            ),
          ],
        ),
      ),
    );
  }
}

/* ──────────────────────────────────────────
 * Activity Section
 *─────────────────────────────────────────*/
class _ActivityItem extends StatelessWidget {
  const _ActivityItem({required this.data});

  final _ActivityData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: AppColors.wheit,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 16.r),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt_outlined,
                  size: 24.r,
                  color: AppColors.mainBlue,
                ),
                SizedBox(width: 12.w),
                Text(
                  '25 Sep 2025',
                  style: AppTextStyles.fontWeight600Size16.copyWith(
                    color: AppColors.black,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.more_horiz,
                  size: 24.r,
                  color: AppColors.greyCheckBox,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 1.5, color: AppColors.greyDiveder),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.wheitDark,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 16.w),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Check  IN',
                        style: AppTextStyles.fontWeight400Size14.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '10:08 PM',
                        style: AppTextStyles.fontWeight600Size16.copyWith(
                          color: AppColors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Check OUT',
                        style: AppTextStyles.fontWeight400Size14.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '10:08 PM',
                        style: AppTextStyles.fontWeight600Size16.copyWith(
                          color: AppColors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ──────────────────────────────────────────
 * Static mock data (replace with real data from backend)
 *─────────────────────────────────────────*/
class _ActivityData {
  const _ActivityData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;
}

const _activityData = [
  _ActivityData(
    icon: Icons.beach_access,
    title: 'Vacation Request',
    subtitle: 'Pending approval',
    time: 'Today · 10:30 AM',
    color: AppColors.warning,
  ),
  _ActivityData(
    icon: Icons.schedule,
    title: 'Shift Changed',
    subtitle: 'Approved by Manager',
    time: 'Yesterday · 3:45 PM',
    color: AppColors.success,
  ),
  _ActivityData(
    icon: Icons.login,
    title: 'Checked In',
    subtitle: 'On time at 8:55 AM',
    time: '01 Jul 2025',
    color: AppColors.mainBlue,
  ),
];
