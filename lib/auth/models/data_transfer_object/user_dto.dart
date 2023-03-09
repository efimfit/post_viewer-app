import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:it_product_client/auth/auth.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final dynamic id;
  final dynamic username;
  final dynamic email;
  final dynamic accessToken;
  final dynamic refreshToken;

  UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      email: email.toString(),
      username: username.toString(),
      id: id.toString(),
      accessToken: accessToken.toString(),
      refreshToken: refreshToken.toString(),
    );
  }
}
