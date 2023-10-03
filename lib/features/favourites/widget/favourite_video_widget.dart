import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/favourites/cubit/favourite_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/my_svg_widget.dart';

class FavoriteVideoWidget extends StatelessWidget {
  final int index;

  const FavoriteVideoWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        FavouriteCubit cubit = context.read<FavouriteCubit>();
        return Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(getSize(context) / 44),
                  child: Image.network(
                    cubit.allFavourite!.data.allVideoFavorites![index]
                        .image,
                    // width: getSize(context)*0.45,
                    height: getSize(context) * 0.35,
                    fit: BoxFit.fill,
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "${cubit.allFavourite!.data.allVideoFavorites![index]
                        .name ?? '' }",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: getSize(context) / 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getSize(context) / 66),
                  child: Row(
                    children: [
                      MySvgWidget(
                        path: ImageAssets.clockIcon,
                        imageColor: AppColors.blue2,
                        size: getSize(context) / 44,
                      ),
                      SizedBox(width: getSize(context) / 88),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(

                          '${cubit.allFavourite!.data.allVideoFavorites![index]
                              .time ?? ''}  ',
                          style: TextStyle(
                            fontSize: getSize(context) / 24,

                            color: AppColors.blue2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: getSize(context) / 8,),
                      InkWell(
                        onTap: () {
                          ///type must be
                          ///video_basic
                          /// video_resource
                          /// video_part
                          cubit.removeFavouriteVideo(
                              cubit.allFavourite!.data
                                  .allVideoFavorites![index].type,
                              'un_favorite',
                              cubit.allFavourite!.data
                                  .allVideoFavorites![index].videoId);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
