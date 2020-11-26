class EnvConfig {
  static const String API_URL =
      String.fromEnvironment('API_URL', defaultValue: 'https://sss.suma.guru/api');
  static String SENTRY_ENV = API_URL.replaceAll('https://', '').replaceAll('/api', '');
}
