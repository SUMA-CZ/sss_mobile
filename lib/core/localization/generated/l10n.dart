// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Přihlášení do SSS`
  String get loginTitle {
    return Intl.message(
      'Přihlášení do SSS',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Přihlásit se`
  String get loginButton {
    return Intl.message(
      'Přihlásit se',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginEmail {
    return Intl.message(
      'Email',
      name: 'loginEmail',
      desc: '',
      args: [],
    );
  }

  /// `Neplatný email`
  String get loginEmailInvalid {
    return Intl.message(
      'Neplatný email',
      name: 'loginEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Heslo`
  String get loginPassword {
    return Intl.message(
      'Heslo',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  /// `Prázdné heslo`
  String get loginPasswordIsEmpty {
    return Intl.message(
      'Prázdné heslo',
      name: 'loginPasswordIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Firemní vozy`
  String get vehiclesCompanyVehicles {
    return Intl.message(
      'Firemní vozy',
      name: 'vehiclesCompanyVehicles',
      desc: '',
      args: [],
    );
  }

  /// `Soukromé vozy`
  String get vehiclesPersonalVehicles {
    return Intl.message(
      'Soukromé vozy',
      name: 'vehiclesPersonalVehicles',
      desc: '',
      args: [],
    );
  }

  /// `Zkusit znovu`
  String get refresh {
    return Intl.message(
      'Zkusit znovu',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `K tomuto vozidlu nebyly uloženy žádné souřadnice`
  String get vehicleDetailNoLocation {
    return Intl.message(
      'K tomuto vozidlu nebyly uloženy žádné souřadnice',
      name: 'vehicleDetailNoLocation',
      desc: '',
      args: [],
    );
  }

  /// `Přidat tankovaní`
  String get addRefueling {
    return Intl.message(
      'Přidat tankovaní',
      name: 'addRefueling',
      desc: '',
      args: [],
    );
  }

  /// `Přidat jízdu`
  String get addTrip {
    return Intl.message(
      'Přidat jízdu',
      name: 'addTrip',
      desc: '',
      args: [],
    );
  }

  /// `Přidat servis`
  String get addMaintenance {
    return Intl.message(
      'Přidat servis',
      name: 'addMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Počáteční datum`
  String get beginDate {
    return Intl.message(
      'Počáteční datum',
      name: 'beginDate',
      desc: '',
      args: [],
    );
  }

  /// `Konečné datum`
  String get endData {
    return Intl.message(
      'Konečné datum',
      name: 'endData',
      desc: '',
      args: [],
    );
  }

  /// `Počáteční stav km`
  String get beginOdometer {
    return Intl.message(
      'Počáteční stav km',
      name: 'beginOdometer',
      desc: '',
      args: [],
    );
  }

  /// `Konečný stav km`
  String get endOdometer {
    return Intl.message(
      'Konečný stav km',
      name: 'endOdometer',
      desc: '',
      args: [],
    );
  }

  /// `Pracovní cesta`
  String get officialTrip {
    return Intl.message(
      'Pracovní cesta',
      name: 'officialTrip',
      desc: '',
      args: [],
    );
  }

  /// `Poznámka k parkování`
  String get parkingNote {
    return Intl.message(
      'Poznámka k parkování',
      name: 'parkingNote',
      desc: '',
      args: [],
    );
  }

  /// `Účel cesty`
  String get description {
    return Intl.message(
      'Účel cesty',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Časový interval`
  String get dateInterval {
    return Intl.message(
      'Časový interval',
      name: 'dateInterval',
      desc: '',
      args: [],
    );
  }

  /// `Množství paliva v nádrži`
  String get fuelLevel {
    return Intl.message(
      'Množství paliva v nádrži',
      name: 'fuelLevel',
      desc: '',
      args: [],
    );
  }

  /// `Vozidla`
  String get vehicles {
    return Intl.message(
      'Vozidla',
      name: 'vehicles',
      desc: '',
      args: [],
    );
  }

  /// `Misto parkování`
  String get selectMapLocation {
    return Intl.message(
      'Misto parkování',
      name: 'selectMapLocation',
      desc: '',
      args: [],
    );
  }

  /// `Jízdu se nepodařilo uložit, je konečný stav km větší než počáteční?`
  String get failedToSaveTrip {
    return Intl.message(
      'Jízdu se nepodařilo uložit, je konečný stav km větší než počáteční?',
      name: 'failedToSaveTrip',
      desc: '',
      args: [],
    );
  }

  /// `Záznam se nepodařilo smazat`
  String get failedDelete {
    return Intl.message(
      'Záznam se nepodařilo smazat',
      name: 'failedDelete',
      desc: '',
      args: [],
    );
  }

  /// `Uložit`
  String get save {
    return Intl.message(
      'Uložit',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Upravit`
  String get edit {
    return Intl.message(
      'Upravit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Smazat`
  String get delete {
    return Intl.message(
      'Smazat',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Chyba komunikace se SSS`
  String get errorCom {
    return Intl.message(
      'Chyba komunikace se SSS',
      name: 'errorCom',
      desc: '',
      args: [],
    );
  }

  /// `Datum`
  String get date {
    return Intl.message(
      'Datum',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Odometer`
  String get odometer {
    return Intl.message(
      'Odometer',
      name: 'odometer',
      desc: '',
      args: [],
    );
  }

  /// `Cena`
  String get price {
    return Intl.message(
      'Cena',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Poznámka`
  String get note {
    return Intl.message(
      'Poznámka',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Ano`
  String get yes {
    return Intl.message(
      'Ano',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Ne`
  String get no {
    return Intl.message(
      'Ne',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Množství litrů`
  String get litres {
    return Intl.message(
      'Množství litrů',
      name: 'litres',
      desc: '',
      args: [],
    );
  }

  /// `Typ paliva`
  String get fuelType {
    return Intl.message(
      'Typ paliva',
      name: 'fuelType',
      desc: '',
      args: [],
    );
  }

  /// `DPH`
  String get vat {
    return Intl.message(
      'DPH',
      name: 'vat',
      desc: '',
      args: [],
    );
  }

  /// `Měna`
  String get currency {
    return Intl.message(
      'Měna',
      name: 'currency',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'cs', countryCode: 'CZ'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}