import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/favourites/cubit/favourite_cubit.dart';
import 'package:new_mazoon/features/favourites/screens/videos.dart';
import 'package:new_mazoon/features/homePage/widget/home_page_app_bar_widget.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import 'exams.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  List<String> titles = ["videos".tr(), "exams".tr()];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    context.read<FavouriteCubit>().getAllFavourite();
    tabController = TabController(length: 2, vsync: this);
    tabController.animateTo(context.read<FavouriteCubit>().currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteState>(
      listener: (context, state) {},
      builder: (context, state) {
        FavouriteCubit cubit = context.read<FavouriteCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondPrimary,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: Stack(
              // alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getSize(context) / 3),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getSize(context) / 32),
                      child: TitleWithCircleBackgroundWidget(
                        title: 'favourite'.tr(),
                        width: double.infinity,
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              titles.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8),
                                child: InkWell(
                                  onTap: () {
                                    cubit.selectTap(index);
                                    print('................................');
                                    print(cubit.currentIndex);
                                    print('................................');
                                    tabController.animateTo(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getSize(context) / 7,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: cubit.currentIndex == index
                                          ? AppColors.orangeThirdPrimary
                                          : AppColors.unselectedTabColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(
                                        titles[index],
                                        style: TextStyle(
                                          color: cubit.currentIndex == index
                                              ? AppColors.white
                                              : AppColors.black,
                                          fontSize: getSize(context) / 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Flexible(
                        child: TabBarView(
                      controller: tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [videosScreen(), ExamsScreen()],
                    ))
                  ],
                ),
                HomePageAppBarWidget(
                  isFavourite: true,
                  isHome: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
