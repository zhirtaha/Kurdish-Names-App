import 'package:http/http.dart' as http;
import 'package:kurdish_names/models/kurdish_names_model.dart';

class KurdishNamesServices {
  Future<KurdishNamesModel> getNames() async {
    Uri urlLink = Uri(
        scheme: "https",
        host: "nawikurdi.com",
        path: "/api",
        queryParameters: {"limit": "10", "offset": "0", "gender": "M"});

    http.Response response = await http.get(urlLink);
    KurdishNamesModel responseBody = KurdishNamesModel.fromJson(response.body);
    return responseBody;
  }
}
