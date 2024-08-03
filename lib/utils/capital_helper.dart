String uppercaseToCamelCase(String input) {
  List<String> words = input.split(' '); // Memisahkan kata-kata dengan spasi.
  List<String> capitalizedWords = [];

  for (String word in words) {
    if (word.isNotEmpty) {
      // Jika kata tidak kosong
      String firstLetter = word[0].toUpperCase();
      String restOfString = word.substring(1);
      capitalizedWords.add(firstLetter + restOfString);
    }
  }
  // Menggabungkan kata-kata yang telah diubah kembali menjadi sebuah string.
  return capitalizedWords.join(' ');
}

String capitalizeEachWord(String input) {
  List<String> words = input.split(' ');

  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }
  }

  return words.join(' ');
}