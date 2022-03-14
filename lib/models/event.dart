import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class EventModel {
  EventModel({
    required this.title,
  });

  final String title;

  static EventModel fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}