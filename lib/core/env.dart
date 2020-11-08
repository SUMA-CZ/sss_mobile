const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {
  'baseUrl': 'https://sss.suma.guru/api',
};

const productionConfig = {
  'baseUrl': 'some-url.com',
};

final environment = isProduction ? productionConfig : testConfig;
