import 'package:sss_mobile/models/refueling.dart';

class RefuelingModel extends Refueling {
  factory RefuelingModel.fromJson(Map<String, dynamic> json) =>
      Refueling.fromJson(json) as RefuelingModel;

  RefuelingModel() : super();
}
