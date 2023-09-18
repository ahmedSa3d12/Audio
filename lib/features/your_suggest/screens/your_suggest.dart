import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/features/your_suggest/cubit/your_suggest_cubit.dart';

import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/music_animation.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../../video_details/widget/choose_icon_dialog.dart';
import '../widget/custom_widget.dart';

class AddYourSuggest extends StatefulWidget {
  const AddYourSuggest({super.key});

  @override
  State<AddYourSuggest> createState() => _AddYourSuggestState();
}

class _AddYourSuggestState extends State<AddYourSuggest> {
  var key = GlobalKey<FormState>();
  UserModel? loginModel;

  @override
  void initState() {
    Preferences.instance.getUserModel().then((value) {
      setState(() {
        loginModel = value;
      });
    });
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    String lan = EasyLocalization.of(context)!.currentLocale!.languageCode;

    return BlocConsumer<YourSuggestCubit, YourSuggestState>(
      listener: (context, state) {
        if (state is LoadingAddNewYourSuggestInitial) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<YourSuggestCubit>();
        return SafeArea(
          child: Scaffold(
            body: loginModel == null
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: getSize(context) / 3.5),
                          Image.asset(
                            ImageAssets.suggest2Image,
                            width: getSize(context) / 4,
                            height: getSize(context) / 4,
                          ),
                          Form(
                              key: key,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.25,
                                padding: EdgeInsets.all(getSize(context) / 22),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: getSize(context) / 32),
                                      SuggestionInfoCard(
                                          title: loginModel!.data!.name,
                                          path: ImageAssets.vector),
                                      SizedBox(height: getSize(context) / 32),
                                      SuggestionInfoCard(
                                          title: lan == 'ar'
                                              ? loginModel!.data!.city!.nameAr
                                              : loginModel!.data!.city!.nameEn,
                                          path: ImageAssets.cityIcon),
                                      SizedBox(height: getSize(context) / 32),
                                      SuggestionInfoCard(
                                          title: loginModel!.data!.code,
                                          path: ImageAssets.codeIcon),
                                      SizedBox(height: getSize(context) / 32),
                                      Container(
                                        child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.multiline,
                                              validator: (String? value) {
                                                if (value!.isEmpty) {
                                                  return 'invalid_suggest'.tr();
                                                }
                                                return null;
                                              },
                                              controller:
                                                  cubit.suggestionController,
                                              minLines: 2,
                                              maxLines: 3,
                                              textAlignVertical:
                                                  TextAlignVertical.top,
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize:
                                                      getSize(context) / 24),
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  prefixIcon: Padding(
                                                    padding: EdgeInsets.all(
                                                        getSize(context) / 22),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      widthFactor: 1,
                                                      heightFactor: 5,
                                                      child: MySvgWidget(
                                                          path: ImageAssets
                                                              .addNoteIcon,
                                                          imageColor:
                                                              AppColors.black,
                                                          size:
                                                              getSize(context) /
                                                                  16),
                                                    ),
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color: AppColors.gray6,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: getSize(context) /
                                                          24),
                                                  labelText: "add_note".tr(),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              AppColors.gray6),
                                                      borderRadius: BorderRadius.circular(
                                                          getSize(context) /
                                                              44)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              AppColors.gray6),
                                                      borderRadius: BorderRadius.circular(
                                                          getSize(context) /
                                                              44)),
                                                  disabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: AppColors.gray6),
                                                      borderRadius: BorderRadius.circular(getSize(context) / 44))),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  getSize(context) / 66),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                          title: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Text(
                                                                'choose'.tr()),
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          content: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                60,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                ChooseIconDialog(
                                                                  title:
                                                                      'camera'
                                                                          .tr(),
                                                                  icon: Icons
                                                                      .camera_alt,
                                                                  onTap: () {
                                                                    cubit
                                                                        .pickImage(
                                                                      type:
                                                                          'camera',
                                                                    );
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                ChooseIconDialog(
                                                                  title: 'photo'
                                                                      .tr(),
                                                                  icon: Icons
                                                                      .photo,
                                                                  onTap: () {
                                                                    cubit
                                                                        .pickImage(
                                                                      type:
                                                                          'photo',
                                                                    );
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'cancel'
                                                                      .tr()),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          AppColors.purple1,
                                                      child: MySvgWidget(
                                                          path: ImageAssets
                                                              .attachmentIcon,
                                                          imageColor:
                                                              AppColors.white,
                                                          size:
                                                              getSize(context) /
                                                                  18),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: getSize(context) /
                                                          32),
                                                  InkWell(
                                                    onTap: () {
                                                      cubit.isRecording
                                                          ? cubit.stop(1)
                                                          : cubit.start();
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              AppColors.blue4),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            getSize(context) /
                                                                44),
                                                        child: Icon(
                                                          cubit.isRecording
                                                              ? Icons.stop
                                                              : Icons.mic,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: getSize(context) / 32),
                                      Visibility(
                                        visible: cubit.isRecording,
                                        child: SizedBox(
                                            height: getSize(context) / 4,
                                            child: MusicList()),
                                      ),
                                      SizedBox(height: getSize(context) / 32),
                                      CustomButton(
                                          isLoading: isLoading,
                                          text: 'send_your_suggest'.tr(),
                                          color: AppColors.orange,
                                          onClick: () {
                                            if (key.currentState!.validate()) {
                                              cubit.addNewSuggest(
                                                  'text', '', '');
                                            } else {}
                                          })
                                    ],
                                  ),
                                ),
                              )),
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
