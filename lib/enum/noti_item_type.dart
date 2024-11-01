enum NotiItemType { ingredient, stock, order }

NotiItemType notiItemTypeFromJson(String type) {
  switch (type) {
    case 'INGREDIENT':
      return NotiItemType.ingredient;
    case 'STOCK':
      return NotiItemType.stock;
    case 'ORDER':
      return NotiItemType.order;
    default:
      throw ArgumentError('Unknown NotiItemType: $type');
  }
}

String notiItemTypeToJson(NotiItemType type) {
  return type.toString().split('.').last;
}
