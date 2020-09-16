enum DialogAction {
  OKAY,
  CANCEL,
  LATER,
}

extension DialogActionExtension on DialogAction {

  //get the readable dialog action text
  String get type => formatString(toShortString());

  // get the value of the enum
  String toShortString() => this.toString().split('.').last;

  /// set all characters after first char of [short] to lowercase
  String formatString(String short) => short[0] + short.substring(1).toLowerCase();
}