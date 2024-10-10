enum PickUpMethod {
  IN_STORE,
  DELIVERY,
  OTHER,
}

PickUpMethod methodFromJson(String method) {
  switch (method) {
    case 'IN_STORE':
      return PickUpMethod.IN_STORE;
    case 'DELIVERY':
      return PickUpMethod.DELIVERY;
    case 'OTHER':
      return PickUpMethod.OTHER;
    default:
      throw ArgumentError('Unknown PickUpMethod: $method');
  }
}

String methodToJson(PickUpMethod method) {
  return method.toString().split('.').last;
}