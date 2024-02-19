import 'package:http/http.dart' as http;
import 'dart:convert';

get() async {
  final uri = Uri.parse("");
  try {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
    } else {
      throw Exception("could not fetch");
    }
  } catch (e) {
    print(e);
  }
}

post() async {
  Map<String, dynamic> data = {"name": "safwan", "age": "19"};
  final uri = Uri.parse("");
  final response = await http.post(uri, body: data);
  if (response.statusCode == 201) {
    final result = json.decode(response.body);
  } else {
    throw Exception("could not fetch");
  }
}

put() async {
  Map<String, dynamic> data = {"name": "hey", "age": "10"};
  final uri = Uri.parse("" " _add_id_as_well");
  final response = await http.post(uri, body: data);
  if (response.statusCode == 201) {
    final result = json.decode(response.body);
  } else {
    throw Exception("could not fetch");
  }
}

delete() async {
  final uri = Uri.parse("" " _add_id_as_well");
  final response = await http.delete(uri);
  if (response.statusCode == 200) {
    final result = json.decode(response.body);
  } else {
    throw Exception("could not delete");
  }
}

patch() async {
  final uri = Uri.parse("" " _add_id_as_well");
  Map<String, dynamic> data = {"name": "updated_name", "age": "updated_age"};
  try {
    final response = await http.patch(uri, body: data);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
    } else {
      throw Exception("could not update");
    }
  } catch (e) {
    print("erorr occured during patch : $e");
    throw Exception("could not update");
  }
}
