import 'package:sss_mobile/features/vehicles/domain/entities/maintenance.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/refueling.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/trip.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vehicle.dart';

Comparator<Maintenance> maintenanceDateDescending = (a, b) => b.date.compareTo(a.date);
Comparator<Refueling> refuelingOdoDescending = (a, b) => b.date.compareTo(a.date);
Comparator<Trip> tripOdoDescending = (a, b) => b.endOdometer.compareTo(a.endOdometer);
Comparator<Vehicle> name = (a, b) => a.name.compareTo(b.name);
