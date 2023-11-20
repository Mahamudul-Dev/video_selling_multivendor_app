import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SellerDashboardController extends GetxController {

  // Sample data for the ActivityMonitor widget
List<double> weeklySalesData = [150.0, 200.0, 180.0, 250.0, 300.0, 280.0, 200.0];
// Sample labels for the x-axis (assuming days of the week)
List<String> yourXAxisLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  // Sample data for the ActivityMonitor widget
List<double> weeklyClicksData = [27, 67, 12, 88, 100, 200, 126];


  

  String formatNumber(int number) {
    final format = NumberFormat.compact();
    return format.format(number);
  }
}
