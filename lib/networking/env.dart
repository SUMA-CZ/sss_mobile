const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {
  'baseUrl': 'https://sss.sumanet.cz/api',
};

const productionConfig = {
  'baseUrl': 'some-url.com',
};

final environment = isProduction ? productionConfig : testConfig;