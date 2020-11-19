import 'package:sss_mobile/features/vehicles/data/models/refueling_model.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/currency.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/fuel_type.dart';
import 'package:sss_mobile/features/vehicles/domain/entities/vat_rate.dart';

// ignore: must_be_immutable
class RefuelingModelCreateDTO extends RefuelingModel {
  VatRate vatRateObject;
  FuelType fuelTypeObject;
  Currency currencyObject;
  String base64Image;

  @override
  Map<String, dynamic> toJson() {
    var payload = super.toJson();
    payload['CurrencyId'] = currencyObject.id;
    payload['FuelTypeId'] = fuelTypeObject.id;
    payload['VatRateId'] = vatRateObject.id;
    payload['Scan'] = 'data:image/png;base64,$base64Image';
    return payload;
  }

  RefuelingModelCreateDTO();
}
