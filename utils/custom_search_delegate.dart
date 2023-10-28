import 'package:flutter/material.dart';
import '../apis/api_client.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return Column(
      children: <Widget>[
        // FutureBuilder(
        //   future: ApiClient.getProductListApi(),
        //   builder: (context, snapshot) {
        //     if (!snapshot.hasData) {
        //       Map map = snapshot.data as Map;
        //       List data = map['product_list']['data'];
        //       return Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: const <Widget>[
        //           Center(child: CircularProgressIndicator()),
        //         ],
        //       );
        //     } else {
        //       Map map = snapshot.data as Map;
        //       List data = map['product_list']['data'];
        //       return ListView.builder(
        //         itemCount: data.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             title: Text(data[index]['title']),
        //           );
        //         },
        //       );
        //     }
        //   },
        // ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
