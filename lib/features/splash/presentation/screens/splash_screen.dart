import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/splash/presentation/screens/pop_ads_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../examinstructions/screen/examinstructions.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../monthplan/screen/monthplan.dart';
import '../../../navigation_bottom/screens/navigation_bottom.dart';
import '../../../onboarding/screens/onboarding_screen.dart';
import '../cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    // Navigator.pushReplacement(
    //   context,
    //   PageTransition(
    //     type: PageTransitionType.fade,
    //     alignment: Alignment.center,
    //     duration: const Duration(milliseconds: 1300),
    //     child: NavigatorBar(),
    //   ),
    // );

    _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(milliseconds: 2500),
      () {
        // Preferences.instance.clearAllData();
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel userModel = await Preferences.instance.getUserModel();
    if (prefs.getString('onBoarding') != null) {
      // } else {
      // }

      if (prefs.getString('user') != null) {
        if (context.read<SplashCubit>().adsList.isNotEmpty) {
          Navigator.pushReplacementNamed(context, Routes.podAdsPageScreenRoute,
              arguments: context.read<SplashCubit>().adsList.first);
        } else {
          Navigator.pushReplacementNamed(
            context,
            Routes.homePageScreenRoute

          );
        }
      } else {
        // Navigator.pushReplacement(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade,
        //     alignment: Alignment.center,
        //     duration: const Duration(milliseconds: 1300),
        //     child: ExamInstructions(),
        //   ),
        // );
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginRoute,
          ModalRoute.withName(
            Routes.initialRoute,
          ),
        );
      }
    } else {
      Navigator.pushReplacementNamed(
        context,
        Routes.onboardingPageScreenRoute,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // context.read<SplashCubit>().getAdsOfApp();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state is SplashLoading) {}
        if (state is SplashLoaded) {
          _startDelay();
        }
        return Scaffold(
          body: Center(
            child: Hero(
              tag: 'logo',
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ),
        );
      },
    );
  }
}
