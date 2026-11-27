
import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF2563EB);
const Color backgroundColor = Color(0xFFF5F7FC);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController departureController =
      TextEditingController();

  final TextEditingController destinationController =
      TextEditingController();

  @override
  void dispose() {
    departureController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  void searchRoute() {
    if (departureController.text.trim().isEmpty ||
        destinationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez saisir le départ et la destination.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Recherche : ${departureController.text} → '
          '${destinationController.text}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // EN-TETE
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.directions_bus,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transport App',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Votre déplacement simplifié',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const CircleAvatar(
                    backgroundColor: Color(0xFFE5EDFF),
                    child: Icon(
                      Icons.person,
                      color: primaryBlue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // BIENVENUE
              const Text(
                'Bonjour 👋',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Où souhaitez-vous aller aujourd’hui ?',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              // CARTE DE RECHERCHE
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Rechercher un itinéraire',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // DEPART
                    LocationField(
                      controller: departureController,
                      label: 'Point de départ',
                      icon: Icons.my_location,
                      color: Colors.green,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Container(
                        height: 25,
                        width: 2,
                        color: Colors.grey.shade300,
                      ),
                    ),

                    // DESTINATION
                    LocationField(
                      controller: destinationController,
                      label: 'Destination',
                      icon: Icons.location_on,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 22),

                    // BOUTON RECHERCHE
                    SizedBox(
                      width: double.infinity,
                      height: 53,
                      child: ElevatedButton.icon(
                        onPressed: searchRoute,
                        icon: const Icon(Icons.search),
                        label: const Text(
                          'Rechercher un itinéraire',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // MOYENS DE TRANSPORT
              const Text(
                'Moyens de transport',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Row(
                children: [
                  TransportType(
                    icon: Icons.directions_bus,
                    label: 'Bus',
                  ),
                  SizedBox(width: 10),
                  TransportType(
                    icon: Icons.tram,
                    label: 'Métro',
                  ),
                  SizedBox(width: 10),
                  TransportType(
                    icon: Icons.train,
                    label: 'Train',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // FONCTIONNALITES
              const Text(
                'Nos fonctionnalités',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const FeatureCard(
                icon: Icons.route,
                title: 'Meilleur itinéraire',
                description: 'Trouvez le chemin le plus rapide.',
              ),

              const FeatureCard(
                icon: Icons.compare_arrows,
                title: 'Comparer les trajets',
                description: 'Comparez les durées et les correspondances.',
              ),

              const FeatureCard(
                icon: Icons.map_outlined,
                title: 'Carte interactive',
                description: 'Visualisez les stations et les lignes.',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// CHAMPS DE LOCALISATION

class LocationField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color color;

  const LocationField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: color),
          hintText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

// MOYENS DE TRANSPORT

class TransportType extends StatelessWidget {
  final IconData icon;
  final String label;

  const TransportType({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primaryBlue,
              size: 29,
            ),
            const SizedBox(height: 9),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CARTES DES FONCTIONNALITES

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF0FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: primaryBlue,
              size: 25,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
