import 'package:campus_connects/constants/app_export.dart';
import 'package:campus_connects/viewModel/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';

class EventCalenderScreen extends StatefulWidget {
  const EventCalenderScreen({super.key});

  @override
  State<EventCalenderScreen> createState() => _EventCalenderScreenState();
}

class _EventCalenderScreenState extends State<EventCalenderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isInit = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _loadEvents();
      _isInit = true;
    }
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<EventViewModel>(context, listen: false).getAllEventsCalling(context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Calendar"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: (day) => eventProvider.eventsForDay(day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      width: 7,
                      height: 7,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          Expanded(
            child: eventProvider.eventsForDay(_selectedDay ?? _focusedDay).isEmpty
                ? const Center(child: Text('No events for this day'))
                : ListView(
              children: eventProvider
                  .eventsForDay(_selectedDay ?? _focusedDay)
                  .map((event) => ListTile(
                title: Text(event.eventTitle ?? 'No Title'),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

