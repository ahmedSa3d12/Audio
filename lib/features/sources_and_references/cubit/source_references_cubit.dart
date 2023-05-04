import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';

part 'source_references_state.dart';

class SourceReferencesCubit extends Cubit<SourceReferencesState> {
  SourceReferencesCubit(this.api) : super(SourceReferencesInitial());

  final ServiceApi api;

  sourcesAndReferencesData() async {
    emit(SourceReferencesLoading());
    final response = await api.sourcesAndReferencesData();
    response.fold(
      (l) => emit(SourceReferencesError()),
      (r) => emit(SourceReferencesLoaded()),
    );
  }
}
