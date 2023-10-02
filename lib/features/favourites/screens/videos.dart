import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/favourites/cubit/favourite_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../video_details/cubit/video_details_cubit.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: GridView.builder(
              itemCount:
                  cubit.allFavourite!.data.allVideoFavorites!.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .72,
                mainAxisSpacing: getSize(context) / 66,
                crossAxisSpacing: getSize(context) / 32,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${cubit.allFavourite!.data.allVideoFavorites![index].name}",
                          style: TextStyle(
                              fontSize: getSize(context) / 28,
                              fontWeight: FontWeight.w700),
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
                                  '${cubit.allFavourite!.data.allVideoFavorites![index].time!}  ',
                                  style: TextStyle(
                                    fontSize: getSize(context) / 32,
                                    color: AppColors.blue2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ///type must be
                                  ///video_basic
                                  /// video_resource
                                  /// video_part
                                  cubit.removeFavourite(
                                      cubit.allFavourite!.data
                                          .allVideoFavorites![index].type,
                                      'un_favorite',
                                      cubit.allFavourite!.data
                                          .allVideoFavorites![index].id);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.delete_forever_outlined,
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
