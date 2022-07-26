import 'package:json_annotation/json_annotation.dart';

import 'contact_model.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  @JsonKey(defaultValue: '')
  final String imageUrl;
  @JsonKey(defaultValue: '')
  final String password;
  @JsonKey(defaultValue: [])
  final List<Contact> contacts;
  UserModel(this.name, this.password, this.email, this.phoneNumber,
      this.contacts, this.imageUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
