import 'package:dpl/model/post_responnse.dart';
import 'package:dpl/services/api_services.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier{
  final ApiServices _apiServices=ApiServices();
  List<PostResponse> _list=[];

  List<PostResponse> get list => _list;
  bool _isLoading=false;
  String ? _Error;

  bool get isLoading => _isLoading;

  String ? get Error => _Error;

  Future<void> fetchPost() async{
    _isLoading=true;
    _Error=null;
    notifyListeners();

    try{
      _list=await _apiServices.fetchPost();
    }

    catch(e){
      _Error=e.toString();
    }
     _isLoading=false;
    notifyListeners();
  }

}