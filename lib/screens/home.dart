import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_app/database/trip.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/screens/journey.dart';
import 'package:travel_app/screens/planning.dart';
import 'package:travel_app/screens/updatetrip.dart';

class Home extends StatefulWidget {
  final TripModel? trip;

  const Home({
    this.trip,
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String searchQuery = '';

  late TabController _tabController;

  List<TripModel> ongoingtrips = [];
  List<TripModel> completedtrips = [];

  @override
  void initState() {
    TripDb().getUser().then((value) {
      filterTrips();
    });

    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: ScaffoldMessenger(
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 231, 229, 229),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  (3.0),
                ),
                child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.green.shade600,
                  bottom: TabBar(
                    tabAlignment: TabAlignment.center,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    unselectedLabelColor: Colors.white70,
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'All Trips'),
                      Tab(text: 'Ongoing Trips'),
                      Tab(text: 'Completed Trips'),
                    ],
                  ),
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.green.shade600,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.black,
                      hintText: 'Search your Trip...',
                      hintStyle: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.green.shade600,
                          width: 3.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.green.shade600,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10.0),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      filterTrips();
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // All Trips tab

                      ValueListenableBuilder(
                        valueListenable: tripnotifier,
                        builder: (context, trips, _) {
                          List<TripModel> filteredList =
                              filter(searchQuery, tripnotifier.value);

                          return filteredList.isEmpty
                              ? LottieBuilder.asset(
                                  'assets/animation/man-travelling.json',
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, index) {
                                    ValueNotifier visible =
                                        ValueNotifier(false);
                                    var trip = filteredList[index];

                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            visible.value = !visible.value;
                                          },
                                          onTap: () {
                                            visible.value = false;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => JourneySs(
                                                  tripModel: trip,
                                                ),
                                              ),
                                            ).then((value) {
                                              if (value != null) {
                                                trip = value;
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              height: 250,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: trip.image == ''
                                                      ? const AssetImage(
                                                          'assets/trip-non.jpg',
                                                        ) as ImageProvider
                                                      : FileImage(
                                                          File(
                                                            trip.image,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              child: Container(
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.black,
                                                    ],
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    15.0,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            trip.place,
                                                            style: GoogleFonts
                                                                .lato(
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              width: 14,
                                                            ),
                                                            Text(
                                                              'Expense: ₹',
                                                              style: GoogleFonts
                                                                  .lato(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              trip.budget,
                                                              style: GoogleFonts
                                                                  .lato(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: visible,
                                          builder: (context, value, _) {
                                            return Visibility(
                                              maintainAnimation: true,
                                              maintainState: true,
                                              visible: value,
                                              child: AnimatedOpacity(
                                                curve: Curves.ease,
                                                duration: const Duration(
                                                  milliseconds: 800,
                                                ),
                                                opacity: value ? 1 : 0,
                                                child: Container(
                                                  color: const Color.fromARGB(
                                                    178,
                                                    221,
                                                    221,
                                                    221,
                                                  ),
                                                  width: double.infinity,
                                                  height: 280,
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(25),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                        10,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          UpdateTrip(
                                                                    edittripmodel:
                                                                        trip,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.edit,
                                                            ),
                                                            color: Colors.black,
                                                          ),
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  content: Text(
                                                                    'Are you sure that you want to delete this trip',
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Cancel',
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color: Colors
                                                                              .green
                                                                              .shade600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          TripDb
                                                                              cd =
                                                                              TripDb();
                                                                          await cd
                                                                              .deleteUser(trip.key)
                                                                              .then(
                                                                            (value) {
                                                                              filterTrips();
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          );
                                                                        } catch (error) {
                                                                          log(
                                                                            error.toString(),
                                                                          );
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Yes',
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color: Colors
                                                                              .green
                                                                              .shade600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                            ),
                                                            color: Colors.black,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                        },
                      ),

                      // ONGOING TRIPS

                      ValueListenableBuilder(
                        valueListenable: tripnotifier,
                        builder: (context, trips, _) {
                          ongoingtrips = filter(searchQuery, ongoingtrips);
                          return ongoingtrips.isEmpty
                              ? LottieBuilder.asset(
                                  'assets/animation/man-travelling.json',
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: ongoingtrips.length,
                                  itemBuilder: (context, index) {
                                    ValueNotifier visible =
                                        ValueNotifier(false);
                                    var trip = ongoingtrips[index];

                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            visible.value = !visible.value;
                                          },
                                          onTap: () {
                                            visible.value = false;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => JourneySs(
                                                  tripModel: trip,
                                                ),
                                              ),
                                            ).then((value) {
                                              if (value != null) {
                                                trip = value;
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              height: 250,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: trip.image == ''
                                                      ? const AssetImage(
                                                          'assets/trip-non.jpg',
                                                        ) as ImageProvider
                                                      : FileImage(
                                                          File(
                                                            trip.image,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              child: Container(
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.black
                                                    ],
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    20.0,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            trip.place,
                                                            style: GoogleFonts
                                                                .lato(
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          trailing:
                                                              const SizedBox(
                                                            width: 100,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              width: 14,
                                                            ),
                                                            Text(
                                                              'Expense:₹',
                                                              style: GoogleFonts
                                                                  .lato(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              trip.budget,
                                                              style: GoogleFonts
                                                                  .lato(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: visible,
                                          builder: (context, value, _) {
                                            return Visibility(
                                              maintainAnimation: true,
                                              maintainState: true,
                                              visible: value,
                                              child: AnimatedOpacity(
                                                curve: Curves.ease,
                                                duration: const Duration(
                                                  milliseconds: 800,
                                                ),
                                                opacity: value ? 1 : 0,
                                                child: Container(
                                                  color: const Color.fromARGB(
                                                    178,
                                                    221,
                                                    221,
                                                    221,
                                                  ),
                                                  width: double.infinity,
                                                  height: 280,
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(25),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                        10,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          UpdateTrip(
                                                                    edittripmodel:
                                                                        trip,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  content: Text(
                                                                    'Are you sure that you want to delete this trip',
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Cancel',
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color: Colors
                                                                              .green
                                                                              .shade600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          TripDb
                                                                              cd =
                                                                              TripDb();
                                                                          await cd
                                                                              .deleteUser(trip.key)
                                                                              .then(
                                                                            (value) {
                                                                              filterTrips();
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          );
                                                                        } catch (error) {
                                                                          log(
                                                                            error.toString(),
                                                                          );
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Yes',
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color: Colors
                                                                              .green
                                                                              .shade600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                        },
                      ),

                      // COMPLETED TRIPS

                      ValueListenableBuilder(
                        valueListenable: tripnotifier,
                        builder: (context, trips, _) {
                          completedtrips = filter(searchQuery, completedtrips);
                          return completedtrips.isEmpty
                              ? LottieBuilder.asset(
                                  'assets/animation/man-travelling.json',
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: completedtrips.length,
                                  itemBuilder: (context, index) {
                                    ValueNotifier visible =
                                        ValueNotifier(false);
                                    var trip = completedtrips[index];

                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        GestureDetector(
                                          onLongPress: () {
                                            visible.value = !visible.value;
                                          },
                                          onTap: () {
                                            visible.value = false;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => JourneySs(
                                                  tripModel: trip,
                                                ),
                                              ),
                                            ).then((value) {
                                              if (value != null) {
                                                trip = value;
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                              height: 250,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: trip.image == ''
                                                      ? const AssetImage(
                                                          'assets/trip-non.jpg',
                                                        ) as ImageProvider
                                                      : FileImage(
                                                          File(
                                                            trip.image,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              child: Container(
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.black,
                                                    ],
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    20.0,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            trip.place,
                                                            style: GoogleFonts
                                                                .outfit(
                                                              fontSize: 30,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          trailing:
                                                              const SizedBox(
                                                            width: 100,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              width: 14,
                                                            ),
                                                            Text(
                                                              'Expense:₹',
                                                              style: GoogleFonts
                                                                  .lato(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              trip.budget,
                                                              style: GoogleFonts
                                                                  .lato(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: visible,
                                          builder: (context, value, _) {
                                            return Visibility(
                                              maintainAnimation: true,
                                              maintainState: true,
                                              visible: value,
                                              child: AnimatedOpacity(
                                                curve: Curves.ease,
                                                duration: const Duration(
                                                  milliseconds: 800,
                                                ),
                                                opacity: value ? 1 : 0,
                                                child: Container(
                                                  color: const Color.fromARGB(
                                                    178,
                                                    221,
                                                    221,
                                                    221,
                                                  ),
                                                  width: double.infinity,
                                                  height: 280,
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .center,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(25),
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                        10,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          UpdateTrip(
                                                                    edittripmodel:
                                                                        trip,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  content: Text(
                                                                    'Are you sure that you want to delete this trip ?',
                                                                    style:
                                                                        GoogleFonts
                                                                            .lato(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Cancel',
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color: Colors
                                                                              .green
                                                                              .shade600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          TripDb
                                                                              cd =
                                                                              TripDb();
                                                                          await cd
                                                                              .deleteUser(trip.key)
                                                                              .then(
                                                                            (value) {
                                                                              filterTrips();
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          );
                                                                        } catch (error) {
                                                                          log(
                                                                            error.toString(),
                                                                          );
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Yes',
                                                                        style: GoogleFonts
                                                                            .lato(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color: Colors
                                                                              .green
                                                                              .shade600,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              label: Text(
                'Add trip',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              backgroundColor: Colors.green.shade600,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JourneyPlan(),
                  ),
                ).then((value) {
                  filterTrips();
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  filterTrips() {
    final now = DateTime.now();
    final allTrips = tripnotifier.value;

    completedtrips =
        allTrips.where((trip) => trip.enddate!.isBefore(now)).toList();
    log(completedtrips.length.toString());

    ongoingtrips =
        allTrips.where((trip) => trip.startdate!.isAfter(now)).toList();
    setState(() {});
  }
}

List<TripModel> filter(String searchQuery, List<TripModel> trips) {
  return trips.where((trips) => trips.place.contains(searchQuery)).toList();
}
