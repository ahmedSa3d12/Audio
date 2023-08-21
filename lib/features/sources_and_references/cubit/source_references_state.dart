part of 'source_references_cubit.dart';

@immutable
abstract class SourceReferencesState {}

class SourceReferencesInitial extends SourceReferencesState {}

class SourceReferencesLoading extends SourceReferencesState {}

class SourceReferencesLoaded extends SourceReferencesState {}

class SourceReferencesError extends SourceReferencesState {}

class SourceReferencesByIdLoading extends SourceReferencesState {}

class SourceReferencesByIdLoaded extends SourceReferencesState {}

class SourceReferencesByIdError extends SourceReferencesState {}

class PDFSourceReferencesByIdLoading extends SourceReferencesState {}

class PDFSourceReferencesByIdLoaded extends SourceReferencesState {}

class PDFSLessonourceReferencesByIdLoaded extends SourceReferencesState {}
class PDFSLessonourceReferencesByIdLoading extends SourceReferencesState {}
