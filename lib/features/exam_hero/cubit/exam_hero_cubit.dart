import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';

import '../../../core/models/exam_hero.dart';
import 'exam_hero_state.dart';

class ExamHeroCubit extends Cubit<ExamHeroState> {
  ExamHeroCubit(this.api) : super(ExamHeroInitial());
  ServiceApi api;
  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ExamHeroChangeCurrentIndexTap());
  }

  //get
  HeroExamModelData? allData;
  List<CurrentMonthModel> currentMonthHeroes = [];
  List<CurrentMonthModel> lastMonthHeroes = [];
  List<CurrentMonthModel> switchList = [];
  List<CurrentMonthModel> weekHeroes = [];
  List<CurrentMonthModel> dayHeroes = [];
  CurrentMonthModel? heroDay;
  CurrentMonthModel? heroWeek;
  CurrentMonthModel? heroMonth;
  CurrentMonthModel? heroMonthS;
  CurrentMonthModel? heroLastMonth;

  getExamHero(BuildContext context) async {
    emit(LoadingGetExamHeros());
    final response = await api.getExamHero();
    response.fold((l) => emit(ErrorGetExamHeros()), (r) {
      if (r.code == 200) {
        allData = r.data;
        currentMonthHeroes = r.data!.currentMonthHeroes!;
        heroMonth = r.data!.currentMonth;
        lastMonthHeroes = r.data!.lastMonthHeroes!;
        weekHeroes = r.data!.weekHeroes!;
        switchList = r.data!.currentMonthHeroes!;
        dayHeroes = r.data!.dayHeroes!;
        heroDay = r.data!.day;
        heroWeek = r.data!.week;
        heroMonth = r.data!.currentMonth;
        heroMonthS = r.data!.currentMonth;
        heroLastMonth = r.data!.lastMonth;
      } else if (r.code == 403) {
        errorGetBar(r.message);
        Navigator.pop(context);
      }
      emit(LoadedGetExamHeros());
    });
  }

  switchCurrentAndLast(String value) {
    if (value == 'current_month'.tr()) {
      num = 2;

      emit(ExamHeroChangeCurrentMonthTap());
    } else {
      num = 3;
      emit(ExamHeroChangeCurrentMonth2Tap());
    }
  }

  int num = 0;
}
