import 'package:json_annotation/json_annotation.dart';

part 'cancel_sub_model.g.dart';

@JsonSerializable(createFactory: false)
class CancelSubModel {
  const CancelSubModel();

  Map<String, dynamic> toJson() => _$CancelSubModelToJson(this);

  Map<String, dynamic> toMap() => toJson();
}
