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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomePageAppBarWidget(
                      isFavourite: true,
                      isHome: false,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              ...List.generate(
                                titles.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    // vertical: 8,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      cubit.selectTap(index);
                                      print(cubit.currentIndex);
                                      tabController.animateTo(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 50,
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
                                            fontSize: getSize(context) / 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () async {
                        print(55555555);
                      },
                      child: TabBarView(
                        controller: tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [videosScreen(), ExamsScreen()],
                      ),
                    ))
                  ],
                ),
                Positioned(
                  top: getSize(context) * 0.27,
                  child: TitleWithCircleBackgroundWidget(
                    title: 'favourite',
                    width: double.infinity,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
