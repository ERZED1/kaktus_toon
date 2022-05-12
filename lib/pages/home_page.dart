import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:kaktus_toon/components/profile_sheet.dart';
import 'package:provider/provider.dart';
import '../service/book_provider.dart';
import '../pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<BookProvider>(context, listen: false).getAllBook();
    });
  }

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<BookProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 243, 240, 184),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Novel'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const HomePage(),
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const ProfileSheet(),
              );
            },
            icon: const Icon(Icons.account_circle),
            color: Colors.green,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        Colors.accents;
        return SafeArea(
          child: ListView.builder(
            itemCount: modelView.book.length,
            itemBuilder: (context, i) {
              final contact = modelView.book[i];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetilPage(
                        title: contact.title,
                        author: contact.author,
                        story: contact.story,
                        moral: contact.moral,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.image,
                    color: Colors.deepPurple[600],
                    size: 50,
                  ),
                  title: Text(
                    contact.title,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    contact.author,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
