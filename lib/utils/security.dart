import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

String encryptId(int id) {
  const secret = 'iertjskdsmfnsf';
  const iv = 'ffffffffffffffff';
  final key = sha256.convert(utf8.encode(secret)).bytes;

  final cipher = Encrypter(AES(Key(Uint8List.fromList(key)), mode: AESMode.cbc))
      .encrypt(id.toString(), iv: IV.fromUtf8(iv));
  return cipher.base16;
}

int decryptId(String encryptedId) {
  const secret = 'iertjskdsmfnsf';
  const iv = 'ffffffffffffffff';
  final key = sha256.convert(utf8.encode(secret)).bytes;

  final decrypted =
      Encrypter(AES(Key(Uint8List.fromList(key)), mode: AESMode.cbc))
          .decrypt16(encryptedId, iv: IV.fromUtf8(iv));
  return int.parse(decrypted);
}
