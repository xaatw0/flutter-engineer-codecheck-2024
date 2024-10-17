enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'GithubBrowser(dev)';
      case Flavor.prod:
        return 'GithubBrowser';
      default:
        return 'title';
    }
  }

}
