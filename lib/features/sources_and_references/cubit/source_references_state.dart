part of 'source_references_cubit.dart';

@immutable
abstract class SourceReferencesState {}

class SourceReferencesInitial extends SourceReferencesState {}

class SourceReferencesLoading extends SourceReferencesState {}
class SourceReferencesLoaded extends SourceReferencesState {}
class SourceReferencesError extends SourceReferencesState {}
