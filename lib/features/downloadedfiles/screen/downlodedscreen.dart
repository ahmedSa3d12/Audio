import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/downloadedfilescubit.dart';
import '../cubit/downloadedfilesstate.dart';
import 'pdf_screen.dart';
import 'videos_screen.dart';

class DownloadedFilesScreen extends StatefulWidget {
  const DownloadedFilesScreen({super.key});

  @override
  State<DownloadedFilesScreen> createState() => _DownloadedFilesScreenState();
}

class _DownloadedFilesScreenState extends State<DownloadedFilesScreen>
    with TickerProviderStateMixin {
  List<String> titles = ['video'.tr(), 'pdf'.tr()];
  late TabController _tabController;
  @override
  void initState() {
    context.read<DownloadedFilesCubit>().getDownloadvideo();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(context.read<DownloadedFilesCubit>().currentIndex);
    super.initState();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadedFilesCubit, DownloadedFilesState>(
      listener: (context, state) {
        if (state is LoadingDownloadedFilesState) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<DownloadedFilesCubit>();

        return SafeArea(
          child: Scaffold(
              body: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 105),
                            TitleWithCircleBackgroundWidget(
                                title: 'downloads'.tr()),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    titles.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 8,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.selectTap(index);
                                          print(cubit.currentIndex);
                                          _tabController.animateTo(index);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 30,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: cubit.currentIndex == index
                                                ? AppColors.orangeThirdPrimary
                                                : AppColors.unselectedTabColor,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Center(
                                            child: Text(
                                              titles[index],
                                              style: TextStyle(
                                                color:
                                                    cubit.currentIndex == index
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  print(88888);
                                },
                                child: TabBarView(
                                  controller: _tabController,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    VideosDownloadedScreen(),
                                    PDFDownloadedScreen(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: HomePageAppBarWidget(isHome: false),
                        ),
                      ],
                    )
              // : ListView.builder(
              //     itemCount: cubit.localVideos.length,
              //     shrinkWrap: true,
              //     physics: const BouncingScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       print('...........................');
              //       print(cubit.localVideos.length);
              //       print('...........................');
              //       return IconButton(
              //           onPressed: () {
              //             Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => VideoPlayerScreen(
              //                   videoPath: cubit.localVideos[index]),
              //             ));
              //           },
              //           icon: Icon(Icons.play_arrow,
              //               color: AppColors.black, size: 50));
              //     },
              //   )
              ),
        );
      },
    );
  }
}
