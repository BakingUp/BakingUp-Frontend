enum OrderType {
  BULK_ORDER,
  PERSONAL,
  SPECIAL_DAY,
  FESTIVAL,
  OTHER,
}

OrderType typeFromJson(String type) {
  switch (type) {
    case 'BULK_ORDER':
      return OrderType.BULK_ORDER;
    case 'PERSONAL':
      return OrderType.PERSONAL;
    case 'SPECIAL_DAY':
      return OrderType.SPECIAL_DAY;
    case 'FESTIVAL':
      return OrderType.FESTIVAL;
    case 'OTHER':
      return OrderType.OTHER;
    default:
      throw ArgumentError('Unknown OrderType: $type');
  }
}

String typeToJson(OrderType type) {
  return type.toString().split('.').last;
}

