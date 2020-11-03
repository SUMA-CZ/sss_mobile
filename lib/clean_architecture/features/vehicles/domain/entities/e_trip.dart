import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ETrip extends Equatable {
  final int id;
  final int beginOdometer;
  final int endOdometer;
  final bool officialTrip;
  final String parkingNote;
  final String note;
  final double latitude;
  final double longitude;
  final int fuelStatus;
  final DateTime beginDate;
  final DateTime endDate;

  ETrip(
      {@required this.id,
      @required this.beginOdometer,
      @required this.endOdometer,
      @required this.officialTrip,
      this.parkingNote,
      this.note,
      this.latitude,
      this.longitude,
      this.fuelStatus,
      this.beginDate,
      this.endDate});

  @override
  List<Object> get props => [id];
}
