import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> birds = [];
  List<String> facts = [
    "Birds are the only animals with feathers.",
    "Some birds can mimic human speech, like parrots.",
    "The ostrich is the largest bird in the world.",
    "Hummingbirds are the only birds that can fly backward.",
    "Penguins are birds that cannot fly but are excellent swimmers."
  ];
  @override
  void initState() {
    super.initState();
    fetchBirds();
  }

  Future<void> fetchBirds() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5214/api/birds'));
      if (response.statusCode == 200) {
        setState(() {
          birds = json.decode(response.body);
        });
      } else {
        // Handle non-200 response codes
        throw Exception('Failed to load birds');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching birds: $e');
    }
  }

  Widget PaddingAll(Widget widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: widget,
    );
  }

  Widget FactSlider() {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: PageView.builder(
        //chatgpt
        controller: PageController(viewportFraction: 0.85),
        itemCount: facts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 78, 12, 103),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    facts[index],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget CustomAppBar() {
    return Container(
      height: 60,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Hello, hello",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 8, 9, 10)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget PageHeader() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        height: 180,
        width: double.infinity,
        color: const Color.fromARGB(255, 78, 12, 103),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Explore the World of Birds",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Discover fascinating bird species from around the globe.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget BirdCard(Map<String, dynamic> bird) {
    final String imageUrl = bird['imageUrl'] ?? '';
    final String fullImageUrl =
        'http://10.0.2.2:5214/api/getImage?imgUrl=$imageUrl';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(fullImageUrl),
              radius: 30,
              onBackgroundImageError: (exception, stackTrace) {
                print('Error loading image: $exception');
              },
              // child: const Icon(Icons.broken_image),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bird['name'] ?? 'Unknown',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  bird['species'] ?? 'Unknown species',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(), //Searched and found this
          children: [
            CustomAppBar(),
            PageHeader(),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Facts",
                style: TextStyle(fontSize: 32),
              ),
            ),
            FactSlider(),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Birds",
                style: TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 16),
            if (birds.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              ...birds.map((bird) => BirdCard(bird)).toList(),
          ],
        ),
      ),
    );
  }
}
