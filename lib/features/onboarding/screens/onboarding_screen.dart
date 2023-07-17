// import 'dart:developer';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intro_slider/intro_slider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../config/routes/app_routes.dart';
// import '../../../core/preferences/preferences.dart';
// import '../../../core/utils/app_colors.dart';
// import '../../../core/widgets/no_data_widget.dart';
// import '../../../core/widgets/show_loading_indicator.dart';
// import '../../splash/presentation/cubit/splash_cubit.dart';
// import '../cubit/on_boarding_cubit.dart';

// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({Key? key}) : super(key: key);

//   @override
//   State<OnBoardingScreen> createState() => OnBoardingScreenState();
// }

// class OnBoardingScreenState extends State<OnBoardingScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<OnBoardingCubit>().getOnBoardingData();
//   }

//   Future<void> onDonePress() async {
//     log("End of slides");
//     Preferences.instance.setFirstInstall();
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     if (prefs.getString('user') != null) {
//       if (context.read<SplashCubit>().adsList.isNotEmpty) {
//         Navigator.pushReplacementNamed(context, Routes.podAdsPageScreenRoute,
//             arguments: context.read<SplashCubit>().adsList.first);
//       } else {
//         Navigator.pushReplacementNamed(
//           context,
//           Routes.homePageScreenRoute,
//         );
//       }
//     } else {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         Routes.loginRoute,
//         ModalRoute.withName(
//           Routes.initialRoute,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<OnBoardingCubit, OnBoardingState>(
//       builder: (context, state) {
//         OnBoardingCubit cubit = context.read<OnBoardingCubit>();
//         if (state is OnBoardingLoading) {
//           return ShowLoadingIndicator();
//         }
//         if (state is OnBoardingError) {
//           return NoDataWidget(
//             onclick: () => cubit.getOnBoardingData(),
//             title: 'no_date'.tr(),
//           );
//         }
//         return IntroSlider(
//           key: UniqueKey(),
//           listContentConfig: cubit.listContentConfig,
//           onDonePress: onDonePress,
//           renderNextBtn: Container(
//             width: 80,
//             height: 35,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: AppColors.primary,
//             ),
//             child: Text(
//               'next'.tr(),
//               textAlign: TextAlign.center,
//               style: TextStyle(color: AppColors.white),
//             ),
//           ),
//           renderDoneBtn: Container(
//             width: 80,
//             height: 35,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: AppColors.primary,
//             ),
//             child: Text(
//               'done'.tr(),
//               textAlign: TextAlign.center,
//               style: TextStyle(color: AppColors.white),
//             ),
//           ),
//           renderSkipBtn: Text(
//             'skip'.tr(),
//             style: TextStyle(color: AppColors.descriptionBoardingColor),
//           ),
//           nextButtonStyle: ButtonStyle(
//             padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
//               EdgeInsets.all(0),
//             ),
//           ),
//           doneButtonStyle: ButtonStyle(
//             padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
//               EdgeInsets.all(0),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
