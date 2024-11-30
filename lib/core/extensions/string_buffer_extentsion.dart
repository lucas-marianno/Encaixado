extension StringBufferExtentsion on StringBuffer {
  /// Returns the last character from a buffer
  ///
  /// ```
  /// final buffer = StringBuffer('buffer');
  /// buffer.lastChar; // 'r'
  /// ```
  String get lastChar {
    final s = toString();

    return s.isEmpty ? '' : s[s.length - 1];
  }

  /// Removes the last character from a buffer
  ///
  /// ```
  /// final buffer = StringBuffer('buffer');
  /// buffer.removeLast(); // 'buffe'
  /// ```
  void removeLast() {
    final s = toString();
    clear();
    write(s.substring(0, s.length - 1));
  }
}
