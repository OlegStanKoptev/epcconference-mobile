// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileModelCWProxy {
  ProfileModel parameter(int parameter);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileModel call({
    int? parameter,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfileModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfileModel.copyWith.fieldName(...)`
class _$ProfileModelCWProxyImpl implements _$ProfileModelCWProxy {
  final ProfileModel _value;

  const _$ProfileModelCWProxyImpl(this._value);

  @override
  ProfileModel parameter(int parameter) => this(parameter: parameter);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileModel call({
    Object? parameter = const $CopyWithPlaceholder(),
  }) {
    return ProfileModel(
      parameter: parameter == const $CopyWithPlaceholder()
          ? _value.parameter
          // ignore: cast_nullable_to_non_nullable
          : parameter as int,
    );
  }
}

extension $ProfileModelCopyWith on ProfileModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass ProfileModel extends Equatable.name.copyWith(...)` or like so:`instanceOfclass ProfileModel extends Equatable.name.copyWith.fieldName(...)`.
  _$ProfileModelCWProxy get copyWith => _$ProfileModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      parameter: json['parameter'] as int,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'parameter': instance.parameter,
    };
