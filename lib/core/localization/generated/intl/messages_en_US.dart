// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addMaintenance" : MessageLookupByLibrary.simpleMessage("Přidat servis"),
    "addRefueling" : MessageLookupByLibrary.simpleMessage("Přidat tankovaní"),
    "addTrip" : MessageLookupByLibrary.simpleMessage("Přidat jízdu"),
    "beginDate" : MessageLookupByLibrary.simpleMessage("Begin date"),
    "beginOdometer" : MessageLookupByLibrary.simpleMessage("Begin odometer"),
    "dateInterval" : MessageLookupByLibrary.simpleMessage("Date interval"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "description" : MessageLookupByLibrary.simpleMessage("Purpose of trip"),
    "edit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "endData" : MessageLookupByLibrary.simpleMessage("End date"),
    "endOdometer" : MessageLookupByLibrary.simpleMessage("End odometer"),
    "failedToSaveTrip" : MessageLookupByLibrary.simpleMessage("Error saving, is your End odometer greater than Begin odometer?"),
    "fuelLevel" : MessageLookupByLibrary.simpleMessage("Fuel level"),
    "loginButton" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginEmail" : MessageLookupByLibrary.simpleMessage("Email"),
    "loginEmailInvalid" : MessageLookupByLibrary.simpleMessage("Invalid email"),
    "loginPassword" : MessageLookupByLibrary.simpleMessage("Password"),
    "loginPasswordIsEmpty" : MessageLookupByLibrary.simpleMessage("Password is empty"),
    "loginTitle" : MessageLookupByLibrary.simpleMessage("Login into SSS"),
    "officialTrip" : MessageLookupByLibrary.simpleMessage("Business trip"),
    "parkingNote" : MessageLookupByLibrary.simpleMessage("Parking note"),
    "refresh" : MessageLookupByLibrary.simpleMessage("REFRESH"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "selectMapLocation" : MessageLookupByLibrary.simpleMessage("Parking spot"),
    "vehicleDetailNoLocation" : MessageLookupByLibrary.simpleMessage("No location recorded"),
    "vehicles" : MessageLookupByLibrary.simpleMessage("Vehicles"),
    "vehiclesCompanyVehicles" : MessageLookupByLibrary.simpleMessage("Company Vehicles"),
    "vehiclesPersonalVehicles" : MessageLookupByLibrary.simpleMessage("Personal Vehicles")
  };
}
