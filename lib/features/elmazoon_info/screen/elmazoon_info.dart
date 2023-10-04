import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/elmazoon_info/cubit/state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/cubit.dart';
import '../widgets/mazooninfo.dart';

class ElMazoonInfo extends StatefulWidget {
  const ElMazoonInfo({super.key});

  @override
  State<ElMazoonInfo> createState() => _ElMazoonInfoState();
}

class _ElMazoonInfoState extends State<ElMazoonInfo>
    with TickerProviderStateMixin {
  List<String> titles = [
    'my_qualifications'.tr(),
    'my_experiences'.tr(),
    'my_skills'.tr(),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(context.read<ElMazoonCubit>().currentIndex);
    context.read<ElMazoonCubit>().aboutMeMethod();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ElMazoonCubit, ElMazoonState>(
      listener: (context, state) {
        if (state is LoadingGetAboutMe) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        ElMazoonCubit cubit = context.read<ElMazoonCubit>();
        return SafeArea(
          child: Scaffold(
            body: (isLoading || cubit.data == null)
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: getSize(context) / 3.5,
                                  ),
                                  height: getSize(context) / 3.5,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            getSize(context) / 12),
                                        bottomRight: Radius.circular(
                                            getSize(context) / 12),
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x3F000000),
                                            blurRadius: 4,
                                            offset: Offset(
                                                -getSize(context) / 22, 0),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      padding: EdgeInsets.only(
                                        right: getSize(context) / 8,
                                        left: getSize(context) / 44,
                                      ),
                                      child: CircleAvatar(
                                        radius: getSize(context) / 9,
                                        backgroundColor: AppColors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              getSize(context) / 88),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                getSize(context)),
                                            child: Image.network(
                                              cubit.data!.image,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    ImageAssets.userImage);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.data!.teacherName,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: getSize(context) / 22,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: getSize(context) / 22),
                                        Text(
                                          cubit.data!.department,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: AppColors.gray1,
                                            fontSize: getSize(context) / 24,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Positioned(
                                    left: 0,
                                    top: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: AppColors.white,
                                        ))),
                              ],
                            ),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    titles.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getSize(context) / 32,
                                        vertical: 2,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.selectTap(index);
                                          print(cubit.currentIndex);
                                          _tabController.animateTo(index);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: getSize(context) / 16,
                                            vertical: getSize(context) / 52,
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
                          ],
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                              padding: EdgeInsets.all(getSize(context) / 22),
                              margin: EdgeInsets.symmetric(
                                vertical: getSize(context) / 12,
                                horizontal: getSize(context) / 22,
                              ),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 25,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  cubit.aboutMeMethod();
                                },
                                child: MazoonInfoWidget(
                                    allData: cubit.data!,
                                    data: cubit.currentIndex == 0
                                        ? cubit.qualifications
                                        : cubit.currentIndex == 1
                                            ? cubit.experiences
                                            : cubit.skills),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await _launchUrl(cubit.data!.facebookLink);
                                },
                                icon: FaIcon(FontAwesomeIcons.facebook,
                                    color: AppColors.blueColor3,
                                    size: getSize(context) / 12)),
                            IconButton(
                                onPressed: () async {
                                  await _launchUrl(cubit.data!.youtubeLink);
                                },
                                icon: FaIcon(FontAwesomeIcons.youtube,
                                    color: AppColors.red,
                                    size: getSize(context) / 12)),
                            IconButton(
                                onPressed: () async {
                                  await _launchUrl(cubit.data!.instagramLink);
                                },
                                icon: SvgPicture.asset(
                                  ImageAssets.instgramIcon,
                                  width: getSize(context) / 12,
                                  height: getSize(context) / 12,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
