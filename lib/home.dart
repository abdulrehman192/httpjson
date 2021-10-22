
import 'package:flutter/material.dart';
import 'package:httpjson/network.dart';

class HTTPJson extends StatefulWidget {
  const HTTPJson({Key? key}) : super(key: key);

  @override
  _HTTPJsonState createState() => _HTTPJsonState();
}

class _HTTPJsonState extends State<HTTPJson> {
  late Future<dynamic> data;

  @override
  initState()
  {
    var network = Network("https://jsonplaceholder.typicode.com/posts");
    data = network.fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Json'),
      ),
      body: Center(
        child: FutureBuilder(
          future: data,
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
              {
                dynamic posts = snapshot.data;
                return customCard(posts);
              }
            else
              {
                return CircularProgressIndicator();
              }
          }
          ,
        ),
      ),
    );
  }

  Widget customCard(posts)
  {
    return ListView.builder(
      itemCount: posts.length,
        itemBuilder: (context, index)
            {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${posts[index]['id']}'),
                  ),
                  title: Text('${posts[index]['title']}'),
                  subtitle: Text('${posts[index]['body']}'),
                ),
              );
            }
    );
  }
}
