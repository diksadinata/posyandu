// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:posyandu/src/api/api_service.dart';
import 'package:posyandu/src/model/profile.dart';
import 'package:posyandu/src/ui/formadd/form_add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late BuildContext context;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getProfiles(),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Profile>? profiles = snapshot.data;
            return _buildListView(profiles!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Profile> profiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Profile profile = profiles[index];
          // ignore: prefer_typing_uninitialized_variables
          // ignore: prefer_typing_uninitialized_variables
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      profile.nama,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      profile.NIK.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      profile.tanggal_lahir,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      profile.umur.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      profile.berat_badan.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      profile.tinggi_badan.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      profile.lingkar_pinggang.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      profile.lingkar_bokong.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      profile.lingkar_lengan.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Warning"),
                                    content: Text(
                                        "Are you sure want to delete data profile ${profile.nama}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService
                                              .deleteProfile(profile.NIK)
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Delete data success")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Delete data failed")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var result = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormAddScreen(profile: profile);
                            }));
                            if (result != null) {
                              setState(() {});
                            }
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: profiles.length,
      ),
    );
  }
}
