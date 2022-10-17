bool isNumber(String p) {
  if (p.isEmpty) return false;
  final n = num.tryParse(p);

  return (n == null) ? false : true;
}