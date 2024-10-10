enum OrderPlatform {
  STORE,
  LINEMAN,
  GRAB,
  FACEBOOK,
  WEBSITE,
  OTHER,
}

OrderPlatform platformFromJson(String platform) {
  switch (platform) {
    case 'STORE':
      return OrderPlatform.STORE;
    case 'LINEMAN':
      return OrderPlatform.LINEMAN;
    case 'GRAB':
      return OrderPlatform.GRAB;
    case 'FACEBOOK':
      return OrderPlatform.FACEBOOK;
    case 'WEBSITE':
      return OrderPlatform.WEBSITE;
    case 'OTHER':
      return OrderPlatform.OTHER;
    default:
      throw ArgumentError('Unknown OrderPlatform: $platform');
  }
}

String platformToJson(OrderPlatform platform) {
  return platform.toString().split('.').last;
}
