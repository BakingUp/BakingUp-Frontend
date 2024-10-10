enum OrderStatus {
  DONE,
  IN_PROCESS,
  CANCEL,
}

OrderStatus statusFromJson(String status) {
  switch (status) {
    case 'DONE':
      return OrderStatus.DONE;
    case 'IN_PROCESS':
      return OrderStatus.IN_PROCESS;
    case 'CANCEL':
      return OrderStatus.CANCEL;
    default:
      throw ArgumentError('Unknown OrderStatus: $status');
  }
}

String statusToJson(OrderStatus status) {
  return status.toString().split('.').last;
}