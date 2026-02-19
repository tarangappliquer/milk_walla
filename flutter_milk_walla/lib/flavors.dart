enum Flavor { development, staging, production, none }

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Development App';
      case Flavor.staging:
        return 'Staging App';
      case Flavor.production:
        return 'Production App';
      default:
        return 'title';
    }
  }

  static String get memeUrl {
    switch (appFlavor) {
      case Flavor.development:
        return "https://media.giphy.com/media/XknChYwfPnp04/giphy.gif";
      case Flavor.staging:
        return "https://media.giphy.com/media/s9ijJ0AI4JKko/giphy.gif";
      case Flavor.production:
        return "https://media.giphy.com/media/zrCSvFfl2fP7W/giphy.gif";
      default:
        throw Exception("Unknown flavor for memeUri");
    }
  }
}
