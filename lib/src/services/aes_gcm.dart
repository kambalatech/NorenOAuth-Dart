import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

class AESGCM {
  late String factor1;
  late String factor2;

  AESGCM({String? key, String? iv}) {
    factor1 = key ?? 'qincrunxivnfzmi6qincrunxivnfzmi6';
    factor2 = iv ?? 'abhcdonerfinjina';
  }
  String encrypt(String? plaintext) {
    final key = Uint8List.fromList(utf8.encode(factor1));
    final iv = Uint8List.fromList(utf8.encode(factor2));

    final plaintextBytes = Uint8List.fromList(utf8.encode(plaintext ?? ""));

    // Initialize cipher for encryption
    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        true, // true = encryption mode
        AEADParameters(
          KeyParameter(key),
          128,
          iv,
          Uint8List(0),
        ), // Tag length: 128 bits
      );

    String encrypted = base64.encode(
      Uint8List.fromList(cipher.process(plaintextBytes)),
    ); // Encrypt
    return encrypted;
  }

  // Decrypt method
  String decrypt(String ciphertext) {
    final key = Uint8List.fromList(utf8.encode(factor1));
    final iv = Uint8List.fromList(utf8.encode(factor2));
    Uint8List encryptedData = base64.decode(ciphertext);

    // Initialize cipher for decryption
    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        false, // false = decryption mode
        AEADParameters(
          KeyParameter(key),
          128,
          iv,
          Uint8List(0),
        ), // Tag length: 128 bits
      );

    final decryptedBytes = cipher.process(encryptedData); // Decrypt
    return utf8.decode(decryptedBytes); // Convert back to string
  }
}
