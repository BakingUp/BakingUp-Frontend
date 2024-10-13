enum OrderType {
  bulkOrder,
  personal,
  specialDay,
  festival,
  other,
}

OrderType typeFromJson(String type) {
  switch (type) {
    case 'BULK_ORDER':
      return OrderType.bulkOrder;
    case 'PERSONAL':
      return OrderType.personal;
    case 'SPECIAL_DAY':
      return OrderType.specialDay;
    case 'FESTIVAL':
      return OrderType.festival;
    case 'OTHER':
      return OrderType.other;
    default:
      throw ArgumentError('Unknown OrderType: $type');
  }
}

String typeToJson(OrderType type) {
  return type.toString().split('.').last;
}

String convertOrderTypeString(String orderType) {
  switch (orderType) {
    case 'Bulk Order':
      return 'BULK_ORDER';
    case 'Personal':
      return 'PERSONAL';
    case 'Special Day':
      return 'SPECIAL_DAY';
    case 'Festival':
      return 'FESTIVAL';
    case 'Other':
      return 'OTHER';
    default:
      throw ArgumentError('Unknown OrderType: $orderType');
  }
}
