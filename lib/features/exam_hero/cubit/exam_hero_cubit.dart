import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exam_hero_state.dart';

class ExamHeroCubit extends Cubit<ExamHeroState> {
  ExamHeroCubit() : super(ExamHeroInitial());


  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ExamHeroChangeCurrentIndexTap());
  }

}
