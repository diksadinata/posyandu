// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:posyandu/src/api/api_service.dart';
import 'package:posyandu/src/model/profile.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

// ignore: must_be_immutable
class FormAddScreen extends StatefulWidget {
  Profile profile;

  FormAddScreen({Key? key, required this.profile}) : super(key: key);

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  final ApiService _apiService = ApiService();
  late bool _isFieldNamaValid;
  late bool _isFieldNIKValid;
  // ignore: non_constant_identifier_names
  late bool _isFieldTanggal_lahirValid;
  late bool _isFieldUmurValid;
  // ignore: non_constant_identifier_names
  late bool _isFieldBerat_badanValid;
  // ignore: non_constant_identifier_names
  late bool _isFieldTinggi_badanValid;
  // ignore: non_constant_identifier_names
  late bool _isFieldLingkar_pinggangValid;
  // ignore: non_constant_identifier_names
  late bool _isFieldLingkar_bokongValid;
  // ignore: non_constant_identifier_names
  late bool _isFieldLingkar_lenganValid;

  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerNIK = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _controllerTanggal_lahir =
      TextEditingController();
  final TextEditingController _controllerUmur = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _controllerBerat_badan = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _controllerTinggi_badan = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _controllerLingkar_pinggang =
      TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _controllerLingkar_bokong =
      TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _controllerLingkar_lengan =
      TextEditingController();

  @override
  void initState() {
    _isFieldNamaValid = true;
    _controllerNama.text = widget.profile.nama;
    _isFieldNIKValid = true;
    _controllerNIK.text = widget.profile.NIK.toString();
    _isFieldTanggal_lahirValid = true;
    _controllerTanggal_lahir.text = widget.profile.tanggal_lahir.toString();
    _isFieldUmurValid = true;
    _controllerUmur.text = widget.profile.umur.toString();
    _isFieldBerat_badanValid = true;
    _controllerBerat_badan.text = widget.profile.berat_badan.toString();
    _isFieldTinggi_badanValid = true;
    _controllerTinggi_badan.text = widget.profile.tinggi_badan.toString();
    _isFieldLingkar_pinggangValid = true;
    _controllerLingkar_pinggang.text =
        widget.profile.lingkar_pinggang.toString();
    _isFieldLingkar_bokongValid = true;
    _controllerLingkar_bokong.text = widget.profile.lingkar_bokong.toString();
    _isFieldLingkar_lenganValid = true;
    _controllerLingkar_lengan.text = widget.profile.lingkar_lengan.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          // ignore: unnecessary_null_comparison
          widget.profile == null ? "Form Add" : "Change Data",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldNama(),
                _buildTextFieldNIK(),
                _buildTextFieldTanggal_lahir(),
                _buildTextFieldUmur(),
                _buildTextFieldBerat_badan(),
                _buildTextFieldTinggi_badan(),
                _buildTextFieldLingkar_pinggang(),
                _buildTextFieldLingkar_bokong(),
                _buildTextFieldLingkar_lengan(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      widget.profile == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (!_isFieldNamaValid ||
                          !_isFieldNIKValid ||
                          !_isFieldTanggal_lahirValid ||
                          !_isFieldUmurValid ||
                          !_isFieldBerat_badanValid ||
                          !_isFieldTinggi_badanValid ||
                          !_isFieldLingkar_pinggangValid ||
                          !_isFieldLingkar_bokongValid ||
                          !_isFieldLingkar_lenganValid) {
                        _scaffoldState.currentState!.showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String nama = _controllerNama.text.toString();
                      // ignore: non_constant_identifier_names
                      int NIK = int.parse(_controllerNIK.text.toString());
                      String tanggalLahir =
                          _controllerTanggal_lahir.text.toString();
                      int umur = int.parse(_controllerUmur.text.toString());
                      int beratBadan =
                          int.parse(_controllerBerat_badan.text.toString());
                      int tinggiBadan =
                          int.parse(_controllerTinggi_badan.text.toString());
                      int lingkarPinggang = int.parse(
                          _controllerLingkar_pinggang.text.toString());
                      int lingkarBokong =
                          int.parse(_controllerLingkar_bokong.text.toString());
                      int lingkarLengan =
                          int.parse(_controllerLingkar_lengan.text.toString());
                      Profile profile = Profile(
                          nama: nama,
                          NIK: NIK,
                          tanggal_lahir: tanggalLahir,
                          umur: umur,
                          berat_badan: beratBadan,
                          tinggi_badan: tinggiBadan,
                          lingkar_pinggang: lingkarPinggang,
                          lingkar_bokong: lingkarBokong,
                          lingkar_lengan: lingkarLengan,
                          id: widget.profile.id);
                      // ignore: unnecessary_null_comparison
                      if (widget.profile == null) {
                        _apiService.createProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState!.context, true);
                          } else {
                            _scaffoldState.currentState!
                                .showSnackBar(const SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        profile.id = widget.profile.id;
                        _apiService.updateProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState!.context, true);
                          } else {
                            _scaffoldState.currentState
                                ?.showSnackBar(const SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: const <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldNama() {
    return TextField(
      controller: _controllerNama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Full name",
        errorText: _isFieldNamaValid ? null : "Nama lengkap harus diisi",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaValid) {
          setState(() => _isFieldNamaValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNIK() {
    return TextField(
      controller: _controllerNIK,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "NIK",
        errorText: _isFieldNIKValid ? null : "NIK is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNIKValid) {
          setState(() => _isFieldNIKValid = isFieldValid);
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildTextFieldTanggal_lahir() {
    return TextField(
      controller: _controllerTanggal_lahir,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: "Tanggal Lahir",
        errorText:
            _isFieldTanggal_lahirValid ? null : "Tanggal Lahir is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTanggal_lahirValid) {
          setState(() => _isFieldTanggal_lahirValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldUmur() {
    return TextField(
      controller: _controllerUmur,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Umur",
        errorText: _isFieldUmurValid ? null : "Umur is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldUmurValid) {
          setState(() => _isFieldUmurValid = isFieldValid);
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildTextFieldBerat_badan() {
    return TextField(
      controller: _controllerBerat_badan,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Berat Badan",
        errorText: _isFieldBerat_badanValid ? null : "Berat Badan is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldBerat_badanValid) {
          setState(() => _isFieldBerat_badanValid = isFieldValid);
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildTextFieldTinggi_badan() {
    return TextField(
      controller: _controllerTinggi_badan,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Tinggi Badan",
        errorText:
            _isFieldTinggi_badanValid ? null : "Tinggi Badan is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTinggi_badanValid) {
          setState(() => _isFieldTinggi_badanValid = isFieldValid);
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildTextFieldLingkar_pinggang() {
    return TextField(
      controller: _controllerLingkar_pinggang,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Lingkar Pinggang",
        errorText: _isFieldLingkar_pinggangValid
            ? null
            : "Lingkar Pinggang is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLingkar_pinggangValid) {
          setState(() => _isFieldLingkar_pinggangValid = isFieldValid);
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildTextFieldLingkar_bokong() {
    return TextField(
      controller: _controllerLingkar_bokong,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Lingkar Pinggul",
        errorText:
            _isFieldLingkar_bokongValid ? null : "Lingkar Pinggul is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLingkar_bokongValid) {
          setState(() => _isFieldLingkar_bokongValid = isFieldValid);
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget _buildTextFieldLingkar_lengan() {
    return TextField(
      controller: _controllerLingkar_lengan,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Lingkar Pinggul",
        errorText:
            _isFieldLingkar_lenganValid ? null : "Lingkar Pinggul is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLingkar_lenganValid) {
          setState(() => _isFieldLingkar_lenganValid = isFieldValid);
        }
      },
    );
  }
}
