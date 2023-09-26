import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/getsize.dart';

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
      const Duration(milliseconds: 1000),
      () {
        // Preferences.instance.clearAllData();
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('onBoarding') != null) {
      if (prefs.getString('user') != null) {
        if (context.read<SplashCubit>().adsList.isNotEmpty) {
          Navigator.pushReplacementNamed(context, Routes.podAdsPageScreenRoute,
              arguments: context.read<SplashCubit>().adsList.first);
        } else {
          Navigator.pushReplacementNamed(context, Routes.homePageScreenRoute);
        }
      } else {
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
    Image image = Image.asset('assets/images/logo2.png');
    // return BlocBuilder<SplashCubit, SplashState>(
    //   builder: (context, state) {
    //     if (state is SplashLoading) {}
    //     if (state is SplashLoaded) {
    //       _startDelay();
    //     }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: SizedBox(
                child: Image.asset(
                  'assets/images/logo2.png',
                  height: getSize(context) / 1.5,
                  width: getSize(context) / 1.5,
                ),
              ),
            ),
          ),
          // Positioned(
          //     bottom: 0,
          //     child: Container(
          //       alignment: Alignment.bottomCenter,
          //       child: Image.asset(
          //         ImageAssets.copyRight,
          //         width: getSize(context) / 1.2,
          //       ),
          //     )),
        ],
      ),
    );
    //   },
    // );
  }
}
