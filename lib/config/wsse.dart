import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert'; // for the utf8.encode method

class Wsse {


  /// Hashs the given password with given salt.
  static String hashPassword(String password, String salt) {
    //combine plain password with salt
    final saltedPassword = password + '{' + salt + '}';

    //hash the saltedPassword with sha512 for first time
    final saltedPasswordBytes = utf8.encode(saltedPassword);
    var digest = sha512.convert(saltedPasswordBytes);

    //repeat the hashing 4999 times. Each time append the saltedPassword to the calculated digest
    for (var i = 1; i < 5000; i++) {
      digest = sha512.convert(digest.bytes + saltedPasswordBytes);
    }

    // return the digest as bas64 encoded string
    return base64.encode(digest.bytes);
  }

  /// Generates the WSSE header based on [username] and the [hashedPassword]
  static String generateWsseHeader(String username, String hashedPassword) {
    var uuid = const Uuid();
    var key = uuid.v4();
    final Hmac hmacSha512 = Hmac(sha512, utf8.encode(key));
    final nonce = hmacSha512.convert(utf8.encode(key));
    DateTime now = DateTime.now().toUtc();
    String isoDate = now.toIso8601String();
    var digest = sha512.convert(
        nonce.bytes + utf8.encode(isoDate) + utf8.encode(hashedPassword));

    //Generate the WSSE Header
    String wsse = '''
    UsernameToken Username="$username", PasswordDigest="${base64.encode(digest.bytes)}", Nonce="${base64.encode(nonce.bytes)}", Created="$isoDate" ''';

    return wsse;
  }
  static String generatewssfromstorage(  String username,
  String hashedPassword){
    // String username;
    // String hashedPassword;
    String   wsse = generateWsseHeader(username, hashedPassword);
    return wsse ;

  }
}
