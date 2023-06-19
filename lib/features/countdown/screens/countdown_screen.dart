import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/countdown_cubit.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<CountdownCubit,CountdownState>(
              builder: (context, state) {
                CountdownCubit cubit = context.read<CountdownCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    TitleWithCircleBackgroundWidget(title: 'countdown',),
                    SizedBox(height: 10),
                    Image.asset(ImageAssets.countdownImage,width: 310,height: 125,),
                    SizedBox(height: 10),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: AppColors.gray7,width: 1,),
                    //   ),
                    //   child: ,
                    // )

                  ],
                );
              },
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(isHome: false),
            ),
          ],
        ),
      ),
    );
  }
}
