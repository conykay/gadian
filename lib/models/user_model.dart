import 'package:json_annotation/json_annotation.dart';

import 'contact_model.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String? name;
  final String? email;
  final String? phoneNumber;
  @JsonKey(defaultValue: '')
  final String? imageUrl;
  @JsonKey(defaultValue: '')
  final String? password;
  @JsonKey(defaultValue: [])
  final List<ContactModel>? contacts;
  UserModel(
    this.name,
    this.password,
    this.email,
    this.phoneNumber,
    this.contacts,
    this.imageUrl,
  );

  UserModel copyWith({String? name,
    String? password,
    String? email,
    String? phoneNumber,
    List<ContactModel>? contacts,
    String? imageUrl,}){
    return UserModel(name = name ?? this.name,
        password = password ?? this.password,
        email = email ?? this.email,
        phoneNumber = phoneNumber ?? this.phoneNumber,
        contacts = contacts ?? this.contacts,
        imageUrl = imageUrl ?? this.imageUrl,);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
