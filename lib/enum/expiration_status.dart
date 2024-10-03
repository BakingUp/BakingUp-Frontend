enum ExpirationStatus {
  black,
  red,
  yellow,
  green,
}

int convertExpirationDate(String expirationDate) {
  switch (expirationDate.toLowerCase()) {
    case "black":
      return ExpirationStatus.black.index;
    case "red":
      return ExpirationStatus.red.index;
    case "yellow":
      return ExpirationStatus.yellow.index;
    case "green":
      return ExpirationStatus.green.index;
    default:
      return ExpirationStatus.black.index;
  }
}
