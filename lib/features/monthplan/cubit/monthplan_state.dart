


import 'package:flutter/material.dart';

@immutable
abstract class MonthPlanState {}

class MonthPlanInitial extends MonthPlanState {}

class MonthPlanLoading extends MonthPlanState {}
class MonthPlanLoaded extends MonthPlanState {}
class MonthPlanError extends MonthPlanState {}
