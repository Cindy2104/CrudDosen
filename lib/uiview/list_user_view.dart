import 'dart:convert';
import 'package:api_user/models/model_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageListUserView extends StatefulWidget {
  const PageListUserView({super.key});

  @override
  State<PageListUserView> createState() => _PageListUserViewState();
}

class _PageListUserViewState extends State<PageListUserView> {
  bool isLoading = false;
  List<ModelUser> listUser = [];

  Future getUser() async {
    try {
      setState(() {
        isLoading = true;
      });

      // URL diperbarui ke IP lokal yang diminta
      http.Response res = await http.get(Uri.parse('http://10.126.32.56:8000/users'));
      var data = res.body;

      setState(() {
        var decodedData = json.decode(data);
        for (var i in decodedData) {
          listUser.add(ModelUser.fromJson(i));
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
    }
  }

  @override 
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List User"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        listUser[index].name ?? "",
                        style: const TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listUser[index].username ?? ""),
                          Text(listUser[index].email ?? ""),
                          Text(listUser[index].address?.city ?? ""),
                          Text("Email : ${listUser[index].email}"),
                          Text("Company: ${listUser[index].company.name}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
