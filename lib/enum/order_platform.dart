enum OrderPlatform {
  store,
  lineman,
  grab,
  facebook,
  website,
  other,
}

OrderPlatform platformFromJson(String platform) {
  switch (platform) {
    case 'STORE':
      return OrderPlatform.store;
    case 'LINEMAN':
      return OrderPlatform.store;
    case 'GRAB':
      return OrderPlatform.grab;
    case 'FACEBOOK':
      return OrderPlatform.facebook;
    case 'WEBSITE':
      return OrderPlatform.website;
    case 'OTHER':
      return OrderPlatform.other;
    default:
      throw ArgumentError('Unknown OrderPlatform: $platform');
  }
}

String platformToJson(OrderPlatform platform) {
  return platform.toString().split('.').last;
}

String convertOrderPlatformString(String orderPlatform) {
  switch (orderPlatform) {
    case 'Store':
      return 'STORE';
    case 'Line Man':
      return 'LINEMAN';
    case 'Grab':
      return 'GRAB';
    case 'Facebook':
      return 'FACEBOOK';
    case 'website':
      return 'WEBSITE';
    case 'other':
      return 'OTHER';
    default:
      throw ArgumentError('Unknown OrderPlatform: $orderPlatform');
  }
}
