import 'package:pokedex/infrastructure/util/json_util.dart';

class PaginationRequestParams {
  final num limit;
  final num offset;

  PaginationRequestParams(
    num pageNumber,
    num pageSize,
  )   : limit = pageSize,
        offset = (pageNumber - 1) * pageSize;

  JSON get queryParams => {
        "limit": limit,
        "offset": offset,
      };
}
