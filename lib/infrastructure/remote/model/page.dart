import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/domain/entity/entity.dart';
import 'package:pokedex/domain/entity/page.dart';
import 'package:pokedex/infrastructure/remote/model/remote_model.dart';
import 'package:pokedex/infrastructure/util/json_util.dart';

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
  PageEntity<R> mapToEntity<R extends Entity>() {
    final totalPages = (count / results.length).ceil();
    final mappedItems = results.map((e) => e.mapToEntity() as R).toList();

    final Uri? nextUrl = Uri.tryParse(next ?? '');
    final String? nextOffset = nextUrl?.queryParameters["offset"];
    if (nextUrl != null && nextOffset != null) {
      final nextPageNumber = (int.parse(nextOffset) / results.length) + 1;
      return PageEntity(nextPageNumber - 1, totalPages, mappedItems);
    }

    final Uri? prevUrl = Uri.tryParse(previous ?? '');
    final String? prevOffset = prevUrl?.queryParameters["offset"];
    if (prevUrl != null && prevOffset != null) {
      final nextPageNumber = (int.parse(prevOffset) / results.length) - 1;
      return PageEntity(nextPageNumber, totalPages, mappedItems);
    }

    return PageEntity(1, totalPages, mappedItems);
  }
}
