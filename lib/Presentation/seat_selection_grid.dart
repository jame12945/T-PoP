import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Domain/seat.dart';
import '../Data/seat_repository.dart';

class SeatSelectionGrid extends StatefulWidget {
  @override
  _SeatSelectionGridState createState() => _SeatSelectionGridState();
}

class _SeatSelectionGridState extends State<SeatSelectionGrid> {
  final SeatRepository seatRepository = SeatRepository();

  List<List<Seat>> seats = List.generate(
    5,(row) => List.generate(
    5,(col) => Seat(
        String.fromCharCode(row + 65) + (col + 1).toString(),
        'available',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Transform.translate(
                offset:Offset(330,50),
                child: Text(
                  'เลือกที่นั่ง',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Transform.translate(
                offset:Offset(0,150),
                child: Container(
                  height: 2,
                  color: Colors.black12,
                ),
              ),
              Transform.translate(
                offset:Offset(120,200),
                child: Text(
                  '1         2       3        4        5',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(40, 270),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'B',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 34),
                    Text(
                      'C',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 34),
                    Text(
                      'D',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'E',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              Transform.translate(
                offset: Offset(100,90.0),
                child: Container(
                  width: 360,
                  child: Transform.translate(
                    offset: Offset(0, 80),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        int row = index ~/ 5;
                        int col = index % 5;
                        Seat seat = seats[row][col];

                        return GestureDetector(
                          onTap: () async {
                            if (seat.status == 'available') {
                              await seatRepository.updateSeatStatus(seat.name, 'not available');
                              setState(() {
                                seat.status = 'not available';
                              });
                            }
                          },
                          child: Transform.translate(
                            offset: Offset(0, 60*1 ),
                            child: Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: seat.status == 'available' ? Colors.black26 : Colors.orange,
                              ),
                            ),
                          ),
                        );

                      },
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset:Offset(0,1050),
                child: Container(
                  height: 2,
                  color: Colors.black12,
                ),
              ),
              Transform.translate(
                offset:Offset(32,1080),
                child: Text(
                  'ที่นั่ง',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                  ),
                ),
              ),
              Transform.translate(
                  offset: Offset(10, 1130),
                  child: buildSelectedSeatsDetails()),
            ],


          ),
        ),

      ],
    );
  }
  Widget buildSelectedSeatsDetails() {
    List<String> selectedSeats = [];
    List<String> selectedSeatNumbers = [];

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (seats[i][j].status == 'not available') {
          selectedSeats.add(seats[i][j].name);
          selectedSeatNumbers.add(seats[i][j].name);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          for (String seatNumber in selectedSeats)
            Transform.translate(
              offset: Offset(12, 0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle cancel button pressed
                  cancelSelectedSeat(seatNumber);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),

                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(seatNumber,style: TextStyle(fontSize: 20),),

                    Transform.translate(
                        offset: Offset(10, 0),
                        child: Icon(Icons.clear)
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void cancelSelectedSeat(String seatNumber) {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (seats[i][j].name == seatNumber) {
          setState(() {
            seats[i][j].status = 'available';
          });
        }
      }
    }
  }


}
