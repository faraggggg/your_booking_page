import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyBookingScreen(),
  ));
}

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
   createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  List<BookingInfo> bookings = [
    BookingInfo(day: 'Monday', time: '14:00', duration: '2 hours', people: 'Ahmed, Farag'),
    BookingInfo(day: 'Wednesday', time: '16:00', duration: '1 hour', people: 'John, Mary'),
    BookingInfo(day: 'Friday', time: '18:00', duration: '3 hours', people: 'Alice, Bob'),
    BookingInfo(day: 'Saturday', time: '12:00', duration: '2 hours', people: 'David, Emma'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your booking courts',
                style: TextStyle(
                  color: Color.fromARGB(255, 59, 224, 64),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              // List of booked courts
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  return BookingContainer(
                    booking: bookings[index],
                    onCancel: () {
                      cancelBooking(index);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void cancelBooking(int index) {
    setState(() {
      bookings[index].isCancelled = true;
    });
  }
}

class BookingInfo {
  final String day;
  final String time;
  final String duration;
  final String people;
  bool isCancelled;

  BookingInfo({
    required this.day,
    required this.time,
    required this.duration,
    required this.people,
    this.isCancelled = false,
  });
}

class BookingContainer extends StatelessWidget {
  final BookingInfo booking;
  final VoidCallback onCancel;

  const BookingContainer({
    Key? key,
    required this.booking,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: booking.isCancelled ? Colors.red : Colors.green,
          width: 2.0,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Add an Image widget with a border radius
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://th.bing.com/th/id/OIP.VdOEQFgIklMe_R4jqiO4UQHaFj?rs=1&pid=ImgDetMain', // Replace with the URL of your court image
              width: 200.0,
              height: 130.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          // Column for texts and button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Day: ${booking.day}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Time: ${booking.time}'),
                Text('Duration: ${booking.duration}'),
                Text('People: ${booking.people}'),
                const SizedBox(height: 8.0),
                if (!booking.isCancelled)
                  ElevatedButton(
                    onPressed: onCancel,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: const Text('Cancel'),
                  ),
                if (booking.isCancelled)
                  const Text(
                    'Cancelled',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
