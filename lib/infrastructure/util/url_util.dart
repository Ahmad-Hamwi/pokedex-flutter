class UrlUtils {
  static String? extractLastUrlParam(String? url) {
    if (url == null || url.isEmpty) {
      return null;
    }

    final splits = url.split("/");

    if (splits.isEmpty) {
      return null;
    }

    return splits[splits.length - 1];
  }

  static int? extractLastUrlParamAsInt(String? url) {
    String? result = extractLastUrlParam(url);

    if (result == null) {
      return null;
    } else {
      return int.parse(result);
    }
  }
}
