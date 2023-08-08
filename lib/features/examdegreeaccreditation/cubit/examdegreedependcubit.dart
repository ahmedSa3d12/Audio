import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote/service.dart';
import 'examdegreedependstate.dart';

class ExamDegreeAccreditationCubit extends Cubit<ExamDegreeAccreditationState> {
  final ServiceApi api;
  ExamDegreeAccreditationCubit(this.api) : super(InitExamDegreeAccreditation());

  int currentIndex = 0;

  selectTap(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndexTap());
  }

  List homeworks = [];
}
