/// Форматирует число в стиле "14 999".
String formatRub(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final left = s.length - i;
    buf.write(s[i]);
    if (left > 1 && left % 3 == 1) buf.write(' ');
  }
  return buf.toString();
}
