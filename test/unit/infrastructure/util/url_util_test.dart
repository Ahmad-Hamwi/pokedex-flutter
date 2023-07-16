import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/infrastructure/util/url_util.dart';

void main() {
  group("extractLastUrlParamAsInt", () {
    test("Returns null when url is null", () {
      final urlParam = UrlUtils.extractLastUrlParamAsInt(null);

      expect(urlParam, null);
    });

    test("Returns null when url is empty", () {
      final urlParam = UrlUtils.extractLastUrlParamAsInt("");

      expect(urlParam, null);
    });

    test("Returns null when url is empty", () {
      final urlParam = UrlUtils.extractLastUrlParamAsInt("not a url");

      expect(urlParam, null);
    });

    test("Returns null when url does not contain url param as an int with backslash", () {
      final urlParam =
          UrlUtils.extractLastUrlParamAsInt("https://pokeapi.co/api/v2/pokemon/1f/");

      expect(urlParam, null);
    });

    test("Returns null when url does not contain url param as an int without backslash", () {
      final urlParam =
      UrlUtils.extractLastUrlParamAsInt("https://pokeapi.co/api/v2/pokemon/1f");

      expect(urlParam, null);
    });

    test(
      "Returns a url param when url DOES contain the url param with slash ending",
      () {
        final urlParam = UrlUtils.extractLastUrlParamAsInt(
            "https://pokeapi.co/api/v2/pokemon/1/");

        expect(urlParam, 1);
      },
    );

    test(
      "Returns a url param when url contains the url param without slash ending",
      () {
        final urlParam = UrlUtils.extractLastUrlParamAsInt(
            "https://pokeapi.co/api/v2/pokemon/1");

        expect(urlParam, 1);
      },
    );
  });
}
