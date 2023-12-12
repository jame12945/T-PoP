import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Domain/seat.dart';

class SeatRepository {

  Future<void> updateSeatStatus(String seatNumber, String status) async {
    final url =
        'https://storage.googleapis.com/tpop-app-dev.appspot.com/test/seating.json';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> seatLayout = data['seatLayout']['seats'];

        for (var seatData in seatLayout) {
          if (seatData['seatNumber'] == seatNumber) {
            seatData['status'] = status;
            break;
          }
        }

        final updateResponse = await http.put(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );

        if (updateResponse.statusCode == 200) {
          print('Seat status updated successfully');
        } else {
          print('Failed to update seat status');
        }
      } else {
        print('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
