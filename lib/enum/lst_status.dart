enum LSTStatus {
  black,
  red,
  yellow,
  green,
}

int convertLSTStatus(LSTStatus lstStatus) {
  switch (lstStatus) {
    case LSTStatus.black:
      return LSTStatus.black.index;
    case LSTStatus.red:
      return LSTStatus.red.index;
    case LSTStatus.yellow:
      return LSTStatus.yellow.index;
    case LSTStatus.green:
      return LSTStatus.green.index;
    default:
      return LSTStatus.black.index;
  }
}
