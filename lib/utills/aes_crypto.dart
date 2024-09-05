import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/api.dart' as crypto;

class AESCrypto {
  final String secretKey;
  static const int ivLength = 16;

  AESCrypto(this.secretKey);

  // 키를 SHA-256으로 32바이트로 고정
  Uint8List _generateKey() {
    final key = utf8.encode(secretKey);
    final sha256 = Digest('SHA-256');
    return sha256.process(Uint8List.fromList(key));
  }

  // AES-256-CBC로 암호화
  String encrypt(String plaintext) {
    final key = _generateKey();
    final iv = _generateIV();

    final cipher = _initCipher(true, key, iv);

    final input = Uint8List.fromList(utf8.encode(plaintext));
    final encrypted = cipher.process(input);

    return base64Encode(iv + encrypted); // IV와 암호화된 데이터를 결합하여 Base64로 인코딩
  }

  // AES-256-CBC로 복호화
  String decrypt(String encryptedText) {
    final key = _generateKey();
    final data = base64Decode(encryptedText);

    final iv = data.sublist(0, ivLength); // IV 추출
    final encrypted = data.sublist(ivLength); // 암호화된 데이터 추출

    final cipher = _initCipher(false, key, iv);

    final decrypted = cipher.process(encrypted);
    return utf8.decode(decrypted);
  }

  // AES-256-CBC 암호화 및 복호화에 사용할 Cipher 객체 초기화
  BlockCipher _initCipher(bool forEncryption, Uint8List key, Uint8List iv) {
    final params = crypto.ParametersWithIV(crypto.KeyParameter(key), iv);
    final cipher = CBCBlockCipher(AESEngine())
      ..init(forEncryption, params);
    return cipher;
  }

  // 16바이트의 랜덤 IV 생성
  Uint8List _generateIV() {
    final random = Random.secure();
    final iv = List<int>.generate(ivLength, (_) => random.nextInt(256));
    return Uint8List.fromList(iv);
  }
}
