import 'package:bloc/bloc.dart';
import 'package:flutter_posresto_app/data/datasource/product_local_datasource.dart';
import 'package:flutter_posresto_app/presentation/home/models/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_report_event.dart';
part 'transaction_report_state.dart';
part 'transaction_report_bloc.freezed.dart';

class TransactionReportBloc
    extends Bloc<TransactionReportEvent, TransactionReportState> {
  final ProductLocalDatasource productLocalDatasource;
  TransactionReportBloc(this.productLocalDatasource)
      : super(
          _Initial(),
        ) {
    on<_GetReport>(
      (event, emit) async {
        emit(_Loading());
        final result = await productLocalDatasource.getAllOrder(
          event.startDate,
          event.endtDate,
        );

        emit(_Loaded(result));
      },
    );
  }
}
