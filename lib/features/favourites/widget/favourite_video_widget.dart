import 'package:flutter/cupertino.dart';
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
          borderRadius: BorderRadius.circular(getSize(context) / 32),
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(context) / 32),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.8), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(getSize(context) / 32),
                    child: Image.network(
                      cubit.allFavourite!.data.allVideoFavorites![index].image,
                      height: getSize(context) * 0.35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "${cubit.allFavourite!.data.allVideoFavorites![index].name ?? ''}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: getSize(context) / 28,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getSize(context) / 66),
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
                            '${cubit.allFavourite!.data.allVideoFavorites![index].time ?? ''}  ',
                            style: TextStyle(
                              fontSize: getSize(context) / 28,
                              color: AppColors.blue2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getSize(context) / 8,
                        ),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
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
