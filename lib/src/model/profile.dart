import 'dart:convert';

class Profile {
  String id;
  String nama;
  // ignore: non_constant_identifier_names
  int NIK;
  // ignore: non_constant_identifier_names
  String tanggal_lahir;
  int umur;
  // ignore: non_constant_identifier_names
  int berat_badan;
  // ignore: non_constant_identifier_names
  int tinggi_badan;
  // ignore: non_constant_identifier_names
  int lingkar_pinggang;
  // ignore: non_constant_identifier_names
  int lingkar_bokong;
  // ignore: non_constant_identifier_names
  int lingkar_lengan;

  Profile({
    required this.id,
    required this.nama,
    // ignore: non_constant_identifier_names
    required this.NIK,
    // ignore: non_constant_identifier_names
    required this.tanggal_lahir,
    required this.umur,
    // ignore: non_constant_identifier_names
    required this.berat_badan,
    // ignore: non_constant_identifier_names
    required this.tinggi_badan,
    // ignore: non_constant_identifier_names
    required this.lingkar_pinggang,
    // ignore: non_constant_identifier_names
    required this.lingkar_bokong,
    // ignore: non_constant_identifier_names
    required this.lingkar_lengan,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      nama: json['nama'],
      NIK: json['NIK'],
      tanggal_lahir: json['tanggal_lahir'],
      umur: json['umur'],
      berat_badan: json['berat_badan'],
      tinggi_badan: json['tinggi_badan'],
      lingkar_pinggang: json['lingkar_pinggang'],
      lingkar_bokong: json['lingkar_bokong'],
      lingkar_lengan: json['lingkar_lengan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "NIK": NIK,
      "tanggal_lahir": tanggal_lahir,
      "umur": umur,
      "berat_badan": berat_badan,
      "tinggi_badan": tinggi_badan,
      "lingkar_pinggang": lingkar_pinggang,
      "lingkar_bokong": lingkar_bokong,
      "lingkar_tangan": lingkar_lengan
    };
  }

  @override
  String toString() {
    return 'Profile{id: $id, nama: $nama, NIK: $NIK, tanggal_lahir: $tanggal_lahir, umur: $umur, berat_badan: $berat_badan, tinggi_badan: $tinggi_badan, lingkar_pinggang: $lingkar_pinggang, lingkar_bokong: $lingkar_bokong, lingkar_tangan: $lingkar_lengan}';
  }
}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
