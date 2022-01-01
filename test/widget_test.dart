import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
  final response = await http.post(
    url,
    body: {
      "origin": "501",
      "destination": "114",
      "weight": "1700",
      "courier": "jne",
    },
    headers: {
      "key": "a76d61456e6590daf8173208032be001",
      "content-type": "application/x-www-form-urlencoded",
    },
  );

  print(response.body);
}
