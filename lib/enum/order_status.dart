enum OrderStatus {
  done,
  inProcess,
  cancel,
}

OrderStatus statusFromJson(String status) {
  switch (status) {
    case 'DONE':
      return OrderStatus.done;
    case 'IN_PROCESS':
      return OrderStatus.inProcess;
    case 'CANCEL':
      return OrderStatus.cancel;
    default:
      throw ArgumentError('Unknown OrderStatus: $status');
  }
}

String statusToJson(OrderStatus status) {
  return status.toString().split('.').last;
}