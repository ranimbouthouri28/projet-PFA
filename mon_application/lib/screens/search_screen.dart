
import 'package:flutter/material.dart';
import 'results_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController departureController =
      TextEditingController();

  final TextEditingController destinationController =
      TextEditingController();

  String selectedMode = 'Tous';

  final Color primaryBlue = const Color(0xFF2563EB);

  void searchRoute() {
    final departure = departureController.text.trim();
    final destination = destinationController.text.trim();

    if (departure.isEmpty || destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez saisir le départ et la destination'),
        ),
      );
      return;
    }

    if (departure.toLowerCase() == destination.toLowerCase()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le départ et la destination doivent être différents'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          departure: departure,
          destination: destination,
          selectedMode: selectedMode,
        ),
      ),
    );
  }

  @override
  void dispose() {
    departureController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  Widget locationField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: primaryBlue),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text(
          'Rechercher un trajet',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Où souhaitez-vous aller ?',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Trouvez le meilleur itinéraire pour votre déplacement.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Départ
            locationField(
              hint: 'Lieu de départ',
              icon: Icons.my_location,
              controller: departureController,
            ),

            const SizedBox(height: 15),

            // Destination
            locationField(
              hint: 'Destination',
              icon: Icons.location_on,
              controller: destinationController,
            ),

            const SizedBox(height: 30),

            const Text(
              'Moyen de transport',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              children: ['Tous', 'Bus', 'Métro', 'Train'].map((mode) {
                final isSelected = selectedMode == mode;

                return ChoiceChip(
                  label: Text(mode),
                  selected: isSelected,
                  selectedColor: primaryBlue,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      selectedMode = mode;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // Bouton de recherche
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: searchRoute,
                icon: const Icon(Icons.search),
                label: const Text(
                  'Rechercher un trajet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
