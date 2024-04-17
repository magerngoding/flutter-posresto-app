// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_posresto_app/data/datasource/discount_remote_datasource.dart';

import '../../../../data/models/response/discount_response_model.dart';

part 'discount_bloc.freezed.dart';
part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;
  DiscountBloc(
    this.discountRemoteDatasource,
  ) : super(_Initial()) {
    on<_GetDiscount>((event, emit) async {
      emit(_Loading());
      final result = await discountRemoteDatasource.getDiscounts();
      result.fold(
        (l) => (_Erro(l)),
        (r) => emit(_Loaded(r.data!)),
      );
    });
  }
}
