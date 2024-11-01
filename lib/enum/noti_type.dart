enum NotiType { info, warning, alert }

NotiType notiTypeFromJson(String type) {
  switch (type) {
    case 'INFO':
      return NotiType.info;
    case 'WARNING':
      return NotiType.warning;
    case 'ALERT':
      return NotiType.alert;
    default:
      throw ArgumentError('Unknown NotiType: $type');
  }
}

String notiTypeToJson(NotiType type) {
  return type.toString().split('.').last;
}
