import 'package:equatable/equatable.dart';
import 'package:sss_mobile/core/localization/generated/l10n.dart';

abstract class Failure extends Equatable {
  String toLocalizedString();

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  @override
  String toLocalizedString() {
    return S.current.errorCom;
  }
}

class SharedPreferencesFailure extends Failure {
  @override
  String toLocalizedString() {
    return S.current.errorSharedPrefs;
  }
}

class FailureAuthentication extends Failure {
  @override
  String toLocalizedString() {
    return S.current.errorAuthentication;
  }
}
