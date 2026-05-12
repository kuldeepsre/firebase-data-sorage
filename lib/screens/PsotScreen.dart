import 'package:dpl/provider/postPRovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostResponseState();
}
class _PostResponseState extends State<PostScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(()=>Provider.of<PostProvider>(context,listen: false).fetchPost());
  }
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<PostProvider>(context);
    return  Scaffold(
      body: Builder(
        builder: (context) {
          if(provider.isLoading){
            return LinearProgressIndicator();
          }
          if(provider.Error!=null)
            {

              return Text(provider.Error.toString());
            }

          return ListView.builder(
              itemCount: provider.list.length,
              itemBuilder: (context,index){
              final data=provider.list[index];
              return Text(data.title.toString(),style: TextStyle(color:Colors.black ),);

          }
          );
        }
      ),
    );
  }
}
