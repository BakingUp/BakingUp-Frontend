enum LSTStatus {
  black,
  red,
  yellow,
  green,
}

int convertLSTStatus(String expirationDate) {
  switch (expirationDate.toLowerCase()) {
    case "black":
      return LSTStatus.black.index;
    case "red":
      return LSTStatus.red.index;
    case "yellow":
      return LSTStatus.yellow.index;
    case "green":
      return LSTStatus.green.index;
    default:
      return LSTStatus.black.index;
  }
}
