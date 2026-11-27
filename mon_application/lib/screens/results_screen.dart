
import 'package:flutter/material.dart';
import 'route_details_screen.dart';

class ResultsScreen extends StatelessWidget {
  final String departure;
  final String destination;
  final String selectedMode;

  const ResultsScreen({
    super.key,
    required this.departure,
    required this.destination,
    required this.selectedMode,
  });

  // Données temporaires pour tester l'interface
  // Elles seront remplacées ensuite par les résultats de l'API Django.
  List<TransportRoute> getRoutes() {
    return [
      TransportRoute(
        title: 'Itinéraire le plus rapide',
        duration: '25 min',
        distance: '8,5 km',
        transfers: 1,
        price: '1,200 DT',
        steps: [
          RouteStep(
            mode: 'Bus',
            line: 'Ligne 12',
            departure: departure,
            arrival: 'Station Centrale',
            duration: '15 min',
          ),
          RouteStep(
            mode: 'Métro',
            line: 'Ligne 2',
            departure: 'Station Centrale',
            arrival: destination,
            duration: '10 min',
          ),
        ],
      ),
      TransportRoute(
        title: 'Itinéraire avec moins de correspondances',
        duration: '35 min',
        distance: '10 km',
        transfers: 0,
        price: '1,000 DT',
        steps: [
          RouteStep(
            mode: 'Bus',
            line: 'Ligne 18',
            departure: departure,
            arrival: destination,
            duration: '35 min',
          ),
        ],
      ),
      TransportRoute(
        title: 'Itinéraire alternatif',
        duration: '30 min',
        distance: '9 km',
        transfers: 1,
        price: '1,500 DT',
        steps: [
          RouteStep(
            mode: 'Train',
            line: 'Ligne T1',
            departure: departure,
            arrival: 'Gare Centrale',
            duration: '20 min',
          ),
          RouteStep(
            mode: 'Bus',
            line: 'Ligne 5',
            departure: 'Gare Centrale',
            arrival: destination,
            duration: '10 min',
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2563EB);
    final routes = getRoutes();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text(
          'Résultats de recherche',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Départ et destination
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.my_location,
                        color: primaryBlue, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        departure,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Colors.red, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        destination,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Moyen de transport : $selectedMode',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              '${routes.length} itinéraires proposés',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: routes.length,
              itemBuilder: (context, index) {
                final route = routes[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F0FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'RECOMMANDÉ',
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      Text(
                        route.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          resultInfo(
                            Icons.access_time,
                            route.duration,
                          ),
                          resultInfo(
                            Icons.straighten,
                            route.distance,
                          ),
                          resultInfo(
                            Icons.swap_horiz,
                            '${route.transfers} transfert(s)',
                          ),
                        ],
                      ),

                      const Divider(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            route.price,
                            style: const TextStyle(
                              color: primaryBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RouteDetailsScreen(
                                    route: route,
                                    departure: departure,
                                    destination: destination,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Voir détails'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget resultInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 17),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
