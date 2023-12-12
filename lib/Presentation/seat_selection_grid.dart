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
                offset:Offset(330,40),
                child: Text(
                  'เลือกที่นั่ง',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Transform.translate(
                offset:Offset(0,120),
                child: Container(
                  height: 2,
                  color: Colors.grey,
                ),
              ),
              Transform.translate(
                offset:Offset(140,160),
                child: Text(
                  '1           2          3         4         5',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(30, 280),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 70),
                    Text(
                      'B',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 70),
                    Text(
                      'C',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 60),
                    Text(
                      'D',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 60),
                    Text(
                      'E',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              Transform.translate(
                offset: Offset(100,90.0),
                child: Container(
                  width: 600,
                  child: Transform.translate(
                    offset: Offset(0, 80),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8,
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
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: seat.status == 'available' ? Colors.grey : Colors.orange,
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
                offset:Offset(0,950),
                child: Container(
                  height: 2,
                  color: Colors.grey,
                ),
              ),
              Transform.translate(
                offset:Offset(20,1000),
                child: Text(
                  'ที่นั่ง',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Transform.translate(
                  offset: Offset(10, 1050),
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

          SizedBox(height: 8.0),
          for (String seatNumber in selectedSeats)
            ElevatedButton(
              onPressed: () {
                // Handle cancel button pressed
                cancelSelectedSeat(seatNumber);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // สีพื้นหลังของปุ่ม
                foregroundColor: Colors.white, // สีของข้อความ
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(seatNumber+' ',style: TextStyle(fontSize: 20),),
                  Icon(Icons.clear),
                ],
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
