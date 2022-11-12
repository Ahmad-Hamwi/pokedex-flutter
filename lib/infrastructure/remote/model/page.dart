import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/domain/entity/entity.dart';
import 'package:pokedex/domain/entity/page.dart';
import 'package:pokedex/infrastructure/remote/model/remote_model.dart';
import 'package:pokedex/infrastructure/util/json_util.dart';
import 'package:pokedex/infrastructure/util/url_util.dart';

part 'page.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PageRemoteModel<T> {
  num count;
  String? next;
  String? previous;
  List<T> results;

  PageRemoteModel(this.count, this.next, this.previous, this.results);

  factory PageRemoteModel.fromJson(
    JSON json,
    T Function(Object? tJson) tFactory,
  ) =>
      _$PageRemoteModelFromJson(json, tFactory);
}

extension MappingExtension<T extends RemoteModel> on PageRemoteModel<T> {
  Page<R> mapToEntity<R extends Entity>() {
    final totalPages = (count / results.length).ceil();
    final mappedItems = results.map((e) => e.mapToEntity() as R).toList();

    final int? nextPageNumber = UrlUtils.extractLastUrlParamAsInt(next);
    if (nextPageNumber != null) {
      return Page(nextPageNumber - 1, totalPages, mappedItems);
    }

    final int? previousPageNumber = UrlUtils.extractLastUrlParamAsInt(previous);
    if (previousPageNumber != null) {
      return Page(previousPageNumber + 1, totalPages, mappedItems);
    }

    return Page(1, totalPages, mappedItems);
  }
}
