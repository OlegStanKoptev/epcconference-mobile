
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'profile.g.dart';

@CopyWith()
@JsonSerializable()
class ProfileModel extends Equatable {
  ProfileModel({
    required this.parameter,
  });

  final int parameter;

  @override
  List<Object?> get props => [
    parameter,
  ];

  static ProfileModel fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}