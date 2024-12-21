import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optacloud_task/core/utils/styles.dart';
import 'package:optacloud_task/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:optacloud_task/features/home_view/home_view_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:optacloud_task/services/mock_bluetooth_sdk.dart';
import 'package:optacloud_task/services/services.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? username;
  String? userEmail;
  int _currentIndex = 0;
  final sdk = MockBluetoothSDK();

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadEmail();
  }

  Future<void> _loadUsername() async {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final name = await authCubit.getUsername();
    setState(() => username = name);
  }

  Future<void> _loadEmail() async {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final email = await authCubit.getEmail();
    setState(() => userEmail = email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:
              _currentIndex == 0 ? _heartRateScreen() : const HistoryScreen(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.favorite),
            label: 'Heart Rate',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }

  Widget _heartRateScreen() {
    return Column(
      children: [
        const HomeScreenAppBar(),
        Row(
          children: [
            Text(
              " $username - ",
              style: Styles.style23(context),
            ),
            Text(
              userEmail ?? 'No Email',
              style: Styles.style23(context),
            ),
          ],
        ),
        const Spacer(),
        StreamBuilder<int>(
          stream: sdk.getHeartRateStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              final heartRate = snapshot.data!;
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await Services.storeHeartRate(context, heartRate);
              });

              return Text(
                'Heart Rate: $heartRate',
                style: Styles.style30(context),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const Spacer(),
      ],
    );
  }
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<Map<String, dynamic>> data;
  bool _isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    setState(() => _isLoading = true);
    final fetchedData = await Services.getAllHeartRateData(context);
    setState(() {
      data = fetchedData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeScreenAppBar(),
        const Gap(20),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final record = data[index];
                        final heartRate = record['heartRate'] ?? 'Unknown';
                        final timestamp = (record['timestamp'] as Timestamp?)
                                ?.toDate()
                                .toString() ??
                            'No Timestamp';
                        return ListTile(
                          title: Text('Heart Rate: $heartRate'),
                          subtitle: Text('Timestamp: $timestamp'),
                          leading: const Icon(Icons.favorite),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No heart rate records available.'),
                    ),
        ),
      ],
    );
  }
}
