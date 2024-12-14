import 'package:bonus/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BirdDetails extends StatefulWidget {
  final String id;

  BirdDetails({super.key, required this.id});

  @override
  State<BirdDetails> createState() => _BirdDetailsState();
}

class _BirdDetailsState extends State<BirdDetails> {
  Map<String, dynamic>? bird;
  bool isLoading = true;
  bool isEditing = false; // Flag to switch between view and edit mode

  // Controllers for the form fields
  TextEditingController nameController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBirdDetails();
  }

  Future<void> fetchBirdDetails() async {
    final url = Uri.parse('http://10.0.2.2:5214/api/birds/${widget.id}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          bird = json.decode(response.body);
          // Initialize the controllers with the current bird details
          nameController.text = bird!['name'];
          speciesController.text = bird!['species'];
          descriptionController.text = bird!['description'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showError("Bird not found");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showError("Failed to load bird details");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> updateBird() async {
    final url = Uri.parse('http://10.0.2.2:5214/api/birds/${widget.id}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'name': nameController.text,
        'species': speciesController.text,
        'description': descriptionController.text,
      },
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      showError("Bird updated successfully");
      setState(() {
        isEditing = false; // Switch back to view mode after update
        fetchBirdDetails();
      });
    } else {
      showError("Failed to update bird");
    }
  }

  Future<void> deleteBird() async {
    final url = Uri.parse('http://10.0.2.2:5214/api/birds/${widget.id}');
    final response = await http.delete(url);
    if (response.statusCode == 204) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      showError("Bird deleted successfully");
    } else {
      showError("Failed to delete bird");
    }
  }

  Widget card(String label, String value) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: const Color.fromARGB(255, 78, 12, 103),
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              Text(
                value,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget editForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: TextField(
            controller: speciesController,
            decoration: const InputDecoration(labelText: 'Species'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: ElevatedButton(
            onPressed: updateBird,
            child: const Text("Update Bird"),
          ),
        ),
      ],
    );
  }

  Widget continueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: double.infinity,
          color: const Color.fromARGB(255, 78, 12, 103),
          child: TextButton(
            onPressed: () {
              if (bird != null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Bird Details"),
                      content: Text(
                          "Name: ${bird!['name']}\nSpecies: ${bird!['species']}"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Done"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text(
              "More Info",
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : bird == null
            ? const Center(
          child: Text("Bird not found"),
        )
            : ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 8, 9, 10),
                  ),
                ),
              ],
            ),
            Image.network(
              'http://10.0.2.2:5214/api/getImage?imgUrl=${bird!['imageUrl']}',
              height: 300,
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                bird!['name'],
                style: const TextStyle(
                    fontSize: 32, color: Color.fromARGB(255, 8, 9, 10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  card("Species", bird!['species']),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Text(
                bird!['description'],
                style: const TextStyle(fontSize: 16),
              ),
            ),
            continueButton(),
            // Edit Button (switches to edit mode)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(isEditing ? "Cancel Edit" : "Edit Bird"),
              ),
            ),
            if (isEditing) editForm(),
            if (!isEditing)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: ElevatedButton(
                  onPressed: deleteBird,
                  child: const Text("Delete Bird"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
