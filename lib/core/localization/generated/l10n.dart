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