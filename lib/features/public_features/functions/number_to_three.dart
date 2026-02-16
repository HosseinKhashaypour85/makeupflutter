String formatPrice(dynamic price) {
  if (price == null) return 'قیمت نامعلوم';

  // فرمت کردن قیمت به صورت ۱۲,۵۰۰,۰۰۰ تومان
  String priceStr = price.toString();
  String formattedPrice = '';

  int counter = 0;
  for (int i = priceStr.length - 1; i >= 0; i--) {
    formattedPrice = priceStr[i] + formattedPrice;
    counter++;
    if (counter == 3 && i != 0) {
      formattedPrice = ',$formattedPrice';
      counter = 0;
    }
  }

  return '$formattedPrice تومان';
}