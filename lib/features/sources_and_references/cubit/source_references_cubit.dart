import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_mazoon/core/remote/service.dart';

import '../../../core/models/sources_references_model.dart';
import '../../../core/models/sources_referenes_by_id_model.dart';

part 'source_references_state.dart';

class SourceReferencesCubit extends Cubit<SourceReferencesState> {
  SourceReferencesCubit(this.api) : super(SourceReferencesInitial()) {
    sourcesAndReferencesData();
  }

  final ServiceApi api;
  List<SourcesReferencesDatum> sourcesReferencesList = [];
  List<SourcesReferencesByIdDatum> sourcesReferencesByIdList = [];
  late SourcesReferencesDatum referenceModel ;

  sourcesAndReferencesData() async {
    emit(SourceReferencesLoading());
    final response = await api.sourcesAndReferencesData();
    response.fold(
      (l) => emit(SourceReferencesError()),
      (r) {
        sourcesReferencesList = r.data!;
        emit(SourceReferencesLoaded());
      },
    );
  }

  sourcesAndReferencesDataById( int classId) async {
    emit(SourceReferencesByIdLoading());
    final response =
        await api.sourcesAndReferencesByIdData(referenceModel.id!, classId);
    response.fold(
      (l) => emit(SourceReferencesByIdError()),
      (r) {
        sourcesReferencesByIdList = r.data!;
        emit(SourceReferencesByIdLoaded());
      },
    );
  }
}
