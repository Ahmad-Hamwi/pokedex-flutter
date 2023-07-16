import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/infrastructure/util/url_util.dart';

void main() {
  group("UrlUtils tests", () {
    test("extractLastUrlParamAsInt when url is null", () {
      final urlParam = UrlUtils.extractLastUrlParamAsInt(null);

      expect(urlParam, null);
    });

    test("extractLastUrlParamAsInt when url is empty", () {
      final urlParam = UrlUtils.extractLastUrlParamAsInt("");

      expect(urlParam, null);
    });

    test("extractLastUrlParamAsInt when url is empty", () {
      final urlParam = UrlUtils.extractLastUrlParamAsInt("not a url");

      expect(urlParam, null);
    });

    test("extractLastUrlParamAsInt when url does not contain url param as an int with backslash", () {
      final urlParam =
          UrlUtils.extractLastUrlParamAsInt("https://pokeapi.co/api/v2/pokemon/1f/");

      expect(urlParam, null);
    });

    test("extractLastUrlParamAsInt when url does not contain url param as an int without backslash", () {
      final urlParam =
      UrlUtils.extractLastUrlParamAsInt("https://pokeapi.co/api/v2/pokemon/1f");

      expect(urlParam, null);
    });

    test(
      "extractLastUrlParamAsInt when url DOES contain a url param with slash ending",
      () {
        final urlParam = UrlUtils.extractLastUrlParamAsInt(
            "https://pokeapi.co/api/v2/pokemon/1/");

        expect(urlParam, 1);
      },
    );

    test(
      "extractLastUrlParamAsInt when url contains a url param without slash ending",
      () {
        final urlParam = UrlUtils.extractLastUrlParamAsInt(
            "https://pokeapi.co/api/v2/pokemon/1");

        expect(urlParam, 1);
      },
    );
  });
}
