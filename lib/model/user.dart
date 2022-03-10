import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  late int id;

  @JsonKey(name: "email")
  late String email;

  @JsonKey(name: "first_name")
  late String firstName;

  @JsonKey(name: "last_name")
  late String lastName;

  @JsonKey(name: "avatar")
  late String avatar;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
