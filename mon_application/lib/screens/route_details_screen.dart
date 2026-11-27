
import 'package:flutter/material.dart';

// Modèle représentant une étape du trajet
class RouteStep {
  final String mode;
  final String line;
  final String departure;
  final String arrival;
  final String duration;

  const RouteStep({
    required this.mode,
    required this.line,
    required this.departure,
    required this.arrival,
    required this.duration,
  });
}

// Modèle représentant un itinéraire complet
class TransportRoute {
  final String title;
  final String duration;
  final String distance;
  final int transfers;
  final String price;
  final List<RouteStep> steps;

  const TransportRoute({
    required this.title,
    required this.duration,
    required this.distance,
    required this.transfers,
    required this.price,
    required this.steps,
  });
}

class RouteDetailsScreen extends StatelessWidget {
  final TransportRoute route;
  final String departure;
  final String destination;

  const RouteDetailsScreen({
    super.key,
    required this.route,
    required this.departure,
    required this.destination,
  });

  IconData getTransportIcon(String mode) {
    switch (mode.toLowerCase()) {
      case 'bus':
        return Icons.directions_bus;
      case 'métro':
      case 'metro':
        return Icons.subway;
      case 'train':
        return Icons.train;
      case 'marche':
        return Icons.directions_walk;
      default:
        return Icons.directions_transit;
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2563EB);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text(
          'Détails du trajet',
          style: TextStyle(fontWeight: FontWeight.bold),
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
            // Résumé du trajet
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Votre itinéraire',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    departure,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    destination,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.white54, height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      summaryItem(Icons.access_time, route.duration),
                      summaryItem(Icons.swap_horiz,
                          '${route.transfers} correspondance(s)'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  summaryItem(Icons.straighten, route.distance),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Étapes du trajet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            // Liste des étapes
            ...route.steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryBlue,
                        child: Icon(
                          getTransportIcon(step.mode),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      if (index != route.steps.length - 1)
                        Container(
                          width: 2,
                          height: 90,
                          color: primaryBlue.withOpacity(0.03),
                        ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${step.mode} - ${step.line}',
                            style: const TextStyle(
                              color: primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Départ : ${step.departure}'),
                          const SizedBox(height: 5),
                          Text('Arrivée : ${step.arrival}'),
                          const SizedBox(height: 8),
                          Text(
                            'Durée : ${step.duration}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Prix estimé',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    route.price,
                    style: const TextStyle(
                      color: primaryBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
