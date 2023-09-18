import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';

import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class InviteFreiendsScreen extends StatefulWidget {
  const InviteFreiendsScreen({super.key});

  @override
  State<InviteFreiendsScreen> createState() => _InviteFreiendsScreenState();
}

class _InviteFreiendsScreenState extends State<InviteFreiendsScreen> {
  @override
  void initState() {
    context.read<IniviteFreiendsCubit>().getInviteFreiend();
    super.initState();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IniviteFreiendsCubit, InviteFreiendsState>(
      listener: (context, state) {
        if (state is LoadingInitInviteFreiends) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<IniviteFreiendsCubit>();
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                isLoading
                    ? ListView(
                        children: [
                          SizedBox(height: getSize(context) / 3.5),
                          Container(
                              child: NoDataWidget(
                                  onclick: () {
                                    context
                                        .read<IniviteFreiendsCubit>()
                                        .getInviteFreiend();
                                  },
                                  title: 'loading'.tr())),
                        ],
                      )
                    : ListView(
                        children: [
                          SizedBox(height: getSize(context) / 3.5),
                          Container(
                            padding: EdgeInsets.only(
                                left: getSize(context) / 8,
                                right: getSize(context) / 8,
                                top: getSize(context) / 8,
                                bottom: getSize(context) / 20),
                            child: Text(
                              'invite_freiends'.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: getSize(context) / 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: getSize(context) / 88),
                            child: Image.asset(
                              ImageAssets.inviteImage,
                              width: getSize(context) / 2.5,
                              height: getSize(context) / 2.5,
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.inviteFreiend!.share.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      EdgeInsets.all(getSize(context) / 100),
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getSize(context) / 22),
                                          child: CircleAvatar(
                                            backgroundColor:
                                                cubit.colors[index % 3],
                                            radius: getSize(context) / 24,
                                            child: Text(
                                              '${index + 1}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: getSize(context) / 24,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          )),
                                      Flexible(
                                        child: Text(
                                          cubit.inviteFreiend!.share[index],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: getSize(context) / 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: getSize(context) / 12),
                          InkWell(
                            onTap: () {
                              cubit.shareApp();

                              ///share
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getSize(context) / 8),
                              width: getSize(context) / 4,
                              height: getSize(context) / 8,
                              decoration: ShapeDecoration(
                                color: AppColors.blue5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Icon(
                                      Icons.share,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          'share'.tr(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: getSize(context) / 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )),
                                  Expanded(child: Container())
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
