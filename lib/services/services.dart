import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optacloud_task/features/auth/manager/auth_cubit/auth_cubit.dart';

class Services {
  static Future<void> storeHeartRate(
      BuildContext context, int heartRate) async {
    try {
      final authCubit = BlocProvider.of<AuthCubit>(context);
      final userId = await authCubit.getUserId();
      await FirebaseFirestore.instance.collection('health_data').add({
        'userId': userId,
        'heartRate': heartRate,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error storing heart rate: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllHeartRateData(
      BuildContext context) async {
    List<Map<String, dynamic>> heartRateData = [];
    try {
      final authCubit = BlocProvider.of<AuthCubit>(context);
      final userId = await authCubit.getUserId();
      final querySnapshot = await FirebaseFirestore.instance
          .collection('health_data')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      for (var doc in querySnapshot.docs) {
        log(doc.data().toString());
        heartRateData.add(doc.data());
      }

      print('Fetched heart rate data: $heartRateData');
    } catch (e) {
      print('Error fetching heart rate data: $e');
    }
    return heartRateData;
  }
}
