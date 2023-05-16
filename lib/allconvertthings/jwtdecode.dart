import 'package:jwt_decode/jwt_decode.dart';


jwtdecode(String x) {
  // Sample token
  String token = x;
  // To decode the token
  Map<String, dynamic> payload = Jwt.parseJwt(token);
  // Print the payload
  //print(payload);
  return payload['sub'];
}