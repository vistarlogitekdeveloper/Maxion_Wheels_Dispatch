/// Shared value types for the platform bridge, so the web and native
/// implementations agree on shapes without either importing the other.
class PickedFile {
  const PickedFile({required this.name, required this.bytes, this.text});

  final String name;
  final List<int> bytes;

  /// Set only when the platform handed back text directly. Callers that need a
  /// string should prefer `decodeAsText(bytes)`, which works either way.
  final String? text;
}

/// Raised when a platform genuinely cannot do something, rather than doing it
/// badly. The message is shown to the operator, so it says what to do instead —
/// SSR T-09: "Every rejection says what is wrong and what to do next, in plain
/// words. Codes alone are not acceptable."
class PlatformUnsupported implements Exception {
  const PlatformUnsupported(this.message);
  final String message;

  @override
  String toString() => message;
}
