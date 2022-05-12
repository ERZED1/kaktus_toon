import 'package:flutter/Material.dart';

class DetilPage extends StatefulWidget {
  const DetilPage(
      {Key? key,
      required this.title,
      required this.author,
      required this.story,
      required this.moral})
      : super(key: key);
  final String title, author, story, moral;
  @override
  State<DetilPage> createState() => _DetilPageState();
}

class _DetilPageState extends State<DetilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 251, 179),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        color: Color.fromARGB(255, 188, 255, 171),
        height: 800,
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.author,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.story,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  widget.moral,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    wordSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
