import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/favourites/cubit/favourite_cubit.dart';
import 'package:new_mazoon/features/video_details/screens/video_details.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/video_widget.dart';
import '../../video_details/cubit/video_details_cubit.dart';
import '../widget/favourite_video_widget.dart';

class videosScreen extends StatelessWidget {
  const videosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        FavouriteCubit cubit = context.read<FavouriteCubit>();
        if (state is LoadingGetFavourite) {
          return ShowLoadingIndicator();
        }
        if (state is FailureGetFavourite) {
          return NoDataWidget(
              onclick: () async {
                cubit.getAllFavourite();
              },
              title: "No Data");
        }
        return RefreshIndicator(
          onRefresh: () async {
            cubit.getAllFavourite();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getSize(context) / 22,
                vertical: getSize(context) / 32),
            child: GridView.builder(
              itemCount: cubit.allFavourite!.data.allVideoFavorites!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .82,
                  mainAxisSpacing: getSize(context) / 20,
                  crossAxisSpacing: getSize(context) / 32,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoDetails(
                                  type: cubit.allFavourite!.data
                                      .allVideoFavorites![index].type,
                                  videoId: cubit.allFavourite!.data
                                      .allVideoFavorites![index].videoId,
                                )));
                    ////////
                  },
                  child: FavoriteVideoWidget(
                    index: index,
                  ),
                );
                //   SizedBox(height: 10,)
                //   ],
                // );
              },
            ),
          ),
        );
      },
    );
  }
}
