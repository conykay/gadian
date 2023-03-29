import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  final String id;
  final String name;
  final String phoneNumber;
  @JsonKey(defaultValue: false)
  bool selected;

  ContactModel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.selected});

  ContactModel copyWith(
      {String? id, String? name, String? phoneNumber, bool? selected}) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selected: selected ?? this.selected,
    );
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
