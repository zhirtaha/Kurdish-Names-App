import 'package:http/http.dart' as http;
import 'package:kurdish_names/models/kurdish_names_model.dart';

class KurdishNamesServices {
  Future<KurdishNamesModel> getNames(
      {required String gender,
      required String limit,
      required String sort}) async {
    Uri urlLink = Uri(
        scheme: "https",
        host: "nawikurdi.com",
        path: "/api",
        queryParameters: {
          "limit": limit,
          "offset": "0",
          "gender": gender,
          "sort": sort
        });

    http.Response response = await http.get(urlLink);
    KurdishNamesModel responseBody = KurdishNamesModel.fromJson(response.body);
    return responseBody;
  }
}
