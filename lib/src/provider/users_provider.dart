import 'dart:convert';
import 'dart:io';

import 'package:delivery_flutter/src/api/environment.dart';
import 'package:delivery_flutter/src/models/response_api.dart';
import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';


  class UsersProvider{

    final String _url = Environment.API_DELIVERY;
    final String _api = '/api/users';

    BuildContext? context;
    String? token;

    Future? init(BuildContext context, {String ?token}) async{
      this.context = context;
      this.token = token;
      return null;
    }

    ///////////////////////////////////////////////////////////////
    
    Future<User?>? getById(String id) async{
      try {
        Uri url = Uri.http(_url, '$_api/findById/$id');
        Map<String, String> headers = {
          'Content-type': 'application/json',
          'Authorization': ?token
        };
        final res = await http.get(url, headers: headers);

        if(res.statusCode == 401){
          Fluttertoast.showToast(msg: 'Tu sesion expiro');
          SharedPref().logout(context!);
        }


        final data = json.decode(res.body);
        User user = User.fromJson(data);
        return user;
      } 
      catch (e) {
        print('Error: $e');
        return null;
      }
    }

    ////////////////////////////////////////////////////////////////

    Future<Stream?> createWithImage(User user, File image) async{
      try {
        Uri url = Uri.http(_url, '$_api/create');
        final request = http.MultipartRequest('POST', url);

        //if (image != null) {
        request.files.add(http.MultipartFile(
          'image', 
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path)
        ));
        //}
        request.fields['user'] = json.encode(user);
        final response = await request.send();
        return response.stream.transform(utf8.decoder);

      } 
      catch (e) {
        print('Error: $e');
        //return null;
      }
    }

    //////////////////////////////////////////////////////////////////
    
    Future<Stream?> update(User user, File image) async{
      try {
        Uri url = Uri.http(_url, '$_api/update');
        final request = http.MultipartRequest('PUT', url);
        request.headers['Authorization'] = token!;

        //if (image != null) {
        request.files.add(http.MultipartFile(
          'image', 
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path)
        ));
        //}
        request.fields['user'] = json.encode(user);
        final response = await request.send();

        if (response.statusCode == 401) {
          Fluttertoast.showToast(msg: 'Tu sesion expiro');
          SharedPref().logout(context!);
        }
        return response.stream.transform(utf8.decoder);

      } 
      catch (e) {
        print('Error: $e');
        return null;
      }
    }

    //////////////////////////////////////////////////////////////////
    
    Future<Stream?> updateNoImage(User user) async {
      try {
        Uri uri = Uri.http(_url, '$_api/updateWithoutImage'); // endpoint en tu backend
        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };

        final body = json.encode(user.toJson());
        final request = http.Request('PUT', uri);
        request.headers.addAll(headers);
        request.body = body;

        final response = await request.send();
        return response.stream.transform(utf8.decoder);
      } catch (e) {
        print('Error en update sin imagen: $e');
        return null;
      }
    }



    ///////////////////////////////////////////////////////////////////

    Future<ResponseApi?> create(User user) async {
      
      try {
        Uri url = Uri.http(_url, '$_api/create');
        String bodyParams = json.encode(user);
        Map<String, String> headers = {
          'Content-type': 'application/json'
        };
        final response = await http.post(url, headers: headers, body: bodyParams);
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        return responseApi;
      } catch (e) {
        //print('Error: $e');
        return null;
      }

    }

    //////////////////////////////////////////////////////////////////
    
    Future<ResponseApi?> login(String email, String password) async{
      try {
        Uri url = Uri.http(_url, '$_api/login');
        String bodyParams = json.encode({
          'email': email,
          'password': password
        });
        Map<String, String> headers = {
          'Content-type': 'application/json'
        };
        final response = await http.post(url, headers: headers, body: bodyParams);
        final data = json.decode(response.body);
        ResponseApi responseApi = ResponseApi.fromJson(data);
        return responseApi;
      } catch (e) {
        //print('Error: $e');
        return null;
      }
    }




  }

  