enum Flavor {
  prod,
  dev,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'DraperWeb';
      case Flavor.dev:
        return 'DraperWeb (Dev)';
      default:
        return 'DraperWeb';
    }
  }
}
