import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SellerDashboardController extends GetxController {

  // Sample data for the ActivityMonitor widget
List<double> yourWeeklySalesData = [150.0, 200.0, 180.0, 250.0, 300.0, 280.0, 200.0];

// Sample labels for the x-axis (assuming days of the week)
List<String> yourXAxisLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

// Sample labels for the y-axis
List<String> yourYAxisLabels = ['0', '50', '100', '150', '200', '250', '300'];

  

  String formatNumber(int number) {
    final format = NumberFormat.compact();
    return format.format(number);
  }
}
