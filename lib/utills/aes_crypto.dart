import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:pointycastle/export.dart';
import 'package:crypto/crypto.dart';

// IV의 길이 설정 (16바이트)
const int IV_LENGTH = 16;

// 키 길이를 보장하는 함수 (SHA-256 사용)
Uint8List ensureKeyLength(String key) {
  return Uint8List.fromList(sha256.convert(utf8.encode(key)).bytes);
}

// 암호화 함수
String encrypt(String text, String secretKey) {
  final key = ensureKeyLength(secretKey);
  final iv = _generateRandomBytes(IV_LENGTH);

  final encrypter = PaddedBlockCipher('AES/CBC/PKCS7');
  encrypter.init(
    true, // true면 암호화, false면 복호화
    PaddedBlockCipherParameters<CipherParameters, CipherParameters>(
      ParametersWithIV<KeyParameter>(KeyParameter(key), iv),
      null,
    ),
  );

  final encryptedBytes = encrypter.process(Uint8List.fromList(utf8.encode(text)));
  final encryptedHex = _bytesToHex(encryptedBytes);
  final ivHex = _bytesToHex(iv);

  return '$ivHex:$encryptedHex';
}

// 난수 생성 함수 (IV 생성에 사용)
Uint8List _generateRandomBytes(int length) {
  final random = Random.secure();
  final bytes = List<int>.generate(length, (_) => random.nextInt(256));
  return Uint8List.fromList(bytes);
}

// 바이트 배열을 16진수 문자열로 변환하는 함수
String _bytesToHex(Uint8List bytes) {
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
