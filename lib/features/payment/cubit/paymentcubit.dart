import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote/service.dart';
import './paymentstate.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.api) : super(InitPaymentState());

  ServiceApi api;

  ///
}
