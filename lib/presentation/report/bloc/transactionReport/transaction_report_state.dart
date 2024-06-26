part of 'transaction_report_bloc.dart';

@freezed
class TransactionReportState with _$TransactionReportState {
  const factory TransactionReportState.initial() = _Initial;
  const factory TransactionReportState.loading() = _Loading;
  const factory TransactionReportState.errpr(String message) = _Error;
  const factory TransactionReportState.laoded(
      List<OrderModel> transactionReport) = _Loaded;
}
