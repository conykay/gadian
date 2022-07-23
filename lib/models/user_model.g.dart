// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['name'] as String,
      json['password'] as String,
      json['email'] as String,
      json['phoneNumber'] as String,
      (json['contacts'] as List<dynamic>?)
              ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'contacts': instance.contacts.map((e) => e.toJson()).toList(),
    };
