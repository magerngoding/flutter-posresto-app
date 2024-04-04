// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_posresto_app/data/datasource/product_local_datasource.dart';

import '../../../../data/models/response/product_response_model.dart';

part 'local_product_bloc.freezed.dart';
part 'local_product_event.dart';
part 'local_product_state.dart';

class LocalProductBloc extends Bloc<LocalProductEvent, LocalProductState> {
  final ProductLocalDatasource productLocalDatasource;
  LocalProductBloc(
    this.productLocalDatasource,
  ) : super(_Initial()) {
    on<_GetLocalProduct>((event, emit) async {
      emit(_Loading());
      final result = await productLocalDatasource.getProducts();
      emit(_Loaded(result));
    });
  }
}
