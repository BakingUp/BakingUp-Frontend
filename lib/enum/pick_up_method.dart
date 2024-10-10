enum PickUpMethod {
  inStore,
  delivery,
  other,
}

PickUpMethod methodFromJson(String method) {
  switch (method) {
    case 'IN_STORE':
      return PickUpMethod.inStore;
    case 'DELIVERY':
      return PickUpMethod.delivery;
    case 'OTHER':
      return PickUpMethod.other;
    default:
      throw ArgumentError('Unknown PickUpMethod: $method');
  }
}

String methodToJson(PickUpMethod method) {
  return method.toString().split('.').last;
}
