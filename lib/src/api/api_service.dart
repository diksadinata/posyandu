import 'package:posyandu/src/model/profile.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "https://627ce0febf2deb7174e31c71.mockapi.io/ibu";
  Client client = Client();

  Future<List<Profile>> getProfiles() async {
    final response = await client
        .get(Uri.parse('https://627ce0febf2deb7174e31c71.mockapi.io/ibu'));
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<bool> createProfile(Profile data) async {
    final response = await client.post(
      Uri.parse('https://627ce0febf2deb7174e31c71.mockapi.io/ibu'),
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(Profile data) async {
    final response = await client.put(
      Uri.parse('https://627ce0febf2deb7174e31c71.mockapi.io/ibu/' +
          data.id.toString()),
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProfile(int id) async {
    final response = await client.delete(
      Uri.parse(
          'https://627ce0febf2deb7174e31c71.mockapi.io/ibu/' + id.toString()),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
