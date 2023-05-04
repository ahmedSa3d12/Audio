import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/restart_app_class.dart';
import '../../../core/widgets/network_image.dart';
import '../cubit/navigation_cubit.dart';
import 'list_tile_menu_widget.dart';

class MenuScreenWidget extends StatelessWidget {
  const MenuScreenWidget({Key? key, required this.closeClick})
      : super(key: key);

  final VoidCallback closeClick;

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: lang == 'en' ? Radius.circular(60) : Radius.zero,
        bottomLeft: lang == 'ar' ? Radius.circular(60) : Radius.zero,
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.primary,
            body: SafeArea(
              child: ListView(
                children: [
                  BlocBuilder<NavigationCubit, NavigationState>(
                    builder: (context, state) {
                      NavigationCubit cubit = context.read<NavigationCubit>();
                      return state is NavigationGetUserLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                ManageNetworkImage(
                                  imageUrl: cubit.userModel!.data!.image,
                                  width: 80,
                                  height: 80,
                                  borderRadius: 90,
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: lang == 'ar'
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
                                        child: Text(
                                          cubit.userModel!.data!.name,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                lang == 'ar'
                                                    ? cubit.userModel!.data!
                                                        .season.nameAr
                                                    : cubit.userModel!.data!
                                                        .season.nameEn,
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            // SizedBox(width: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                lang == 'ar'
                                                    ? cubit.userModel!.data!
                                                        .term.nameAr
                                                    : cubit.userModel!.data!
                                                        .term.nameEn,
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
                  SizedBox(height: 30),
                  MenuListTileWidget(
                    title: 'language'.tr(),
                    iconPath: ImageAssets.languageIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'profile'.tr(),
                    iconPath: ImageAssets.profileIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'register_paper_exam'.tr(),
                    iconPath: ImageAssets.userEditIcon,
                    onclick: () {
                      context.read<NavigationCubit>().getTimes(context);
                    },
                  ),
                  MenuListTileWidget(
                    title: 'mygards_rate'.tr(),
                    iconPath: ImageAssets.degreeIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'exam_hero'.tr(),
                    iconPath: ImageAssets.cupIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'month_plan'.tr(),
                    iconPath: ImageAssets.calenderIcon,
                    onclick: () {
                      Navigator.pushNamed(context, Routes.monthplanPageScreenRoute);
                      Navigator.pushNamed(
                          context, Routes.monthplanPageScreenRoute);
                    },
                  ),
                  MenuListTileWidget(
                    title: 'live'.tr(),
                    iconPath: ImageAssets.liveIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'suggest'.tr(),
                    iconPath: ImageAssets.suggestIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'reports'.tr(),
                    iconPath: ImageAssets.reportsIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'downloads'.tr(),
                    iconPath: ImageAssets.downloadsIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'invite_friends'.tr(),
                    iconPath: ImageAssets.shareIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'rate_app'.tr(),
                    iconPath: ImageAssets.rateIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'call_us'.tr(),
                    iconPath: ImageAssets.callUsIcon,
                    onclick: () {},
                  ),
                  MenuListTileWidget(
                    title: 'logout'.tr(),
                    iconPath: ImageAssets.logoutIcon,
                    onclick: () {
                      Preferences.instance.clearUserData().then(
                            (value) =>
                            HotRestartController.performHotRestart(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 7,
            right: lang == 'en' ? -40 : null,
            left: lang == 'ar' ? -40 : null,
            child: Container(
              width: 130,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: closeClick,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: AppColors.orangeThirdPrimary,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
