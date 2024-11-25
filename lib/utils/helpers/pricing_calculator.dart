class TPricingCalculator {

  static String calculateTotalPrice(double productPrice, String location) {
   /*
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate; // Sửa tên biến từ taxtAmount thành taxAmount
*/
    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice  + shippingCost; // Sửa tên biến từ taxtAmount thành taxAmount
    return totalPrice.toStringAsFixed(0);
  }

  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(0);
  }
/*
  static String calculateTax(double productPrice, String location) { // Sửa từ caculateTax thành calculateTax
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate; // Sửa phép toán từ productPrice + taxRate thành productPrice * taxRate
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    return 0.10; // Giả sử tỷ lệ thuế là 10%
  }
*/
  static double getShippingCost(String location) {
    return 10000; // Giả sử chi phí vận chuyển là 5.00
  }
}
