import 'dart:math';

/// Generates the UUIDs used as primary keys (spec section 3).
abstract interface class IdGenerator {
  String next();
}

/// RFC 4122 version 4 UUID generator.
///
/// Implemented locally (30 lines) instead of adding the `uuid` package: the
/// dependency list stays as agreed in the spec, and the generator is
/// injectable,
/// which the tests rely on for deterministic identifiers.
class UuidGenerator implements IdGenerator {
  UuidGenerator({Random? random}) : _random = random ?? Random.secure();

  final Random _random;

  @override
  String next() {
    final List<int> bytes =
        List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // variant 10xx

    String hex(int index) => bytes[index].toRadixString(16).padLeft(2, '0');

    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < 16; i++) {
      if (i == 4 || i == 6 || i == 8 || i == 10) {
        buffer.write('-');
      }
      buffer.write(hex(i));
    }
    return buffer.toString();
  }
}
