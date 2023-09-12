import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/features/change_lang/cubit/lang_state.dart';

class ChangeLangCubit extends Cubit<ChangelanguageState> {
  ChangeLangCubit(this.api) : super(InitChangelanguageState());
  ServiceApi api;
}
