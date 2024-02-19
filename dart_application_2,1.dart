class Book {
  String title;
  String author;
  int year;
  int pageCount;

  // Конструктор для создания экземпляра книги с заданными характеристиками
  Book(this.title, this.author, this.year, this.pageCount);

  // Метод для вывода информации о книге
  void displayInfo() {
    print('Название: $title');
    print('Автор: $author');
    print('Год издания: $year');
    print('Количество страниц: $pageCount');
  }
}

class Library {
  List<Book> books = [];

  // Метод для добавления книги в библиотеку
  void addBook(Book book) {
    books.add(book);
    print('Книга "${book.title}" добавлена в библиотеку.');
  }

  // Метод для удаления книги из библиотеки
  void removeBook(Book book) {
    books.remove(book);
    print('Книга "${book.title}" удалена из библиотеки.');
  }

  // Метод для вывода информации о всех книгах в библиотеке
  void displayBooks() {
    if (books.isEmpty) {
      print('В библиотеке нет книг.');
    } else {
      print('Список книг в библиотеке:');
      for (var book in books) {
        book.displayInfo();
        print('-------------------------');
      }
    }
  }
}

void main() {
  // Пример использования классов
  var book1 = Book('Преступление и наказание', 'Федор Достоевский', 1866, 430);
  var book2 = Book('Война и мир', 'Лев Толстой', 1869, 1225);
  var book3 = Book('1984', 'Джордж Оруэлл', 1949, 328);

  var library = Library();
  library.addBook(book1);
  library.addBook(book2);
  library.addBook(book3);

  library.displayBooks();

  library.removeBook(book2);

  library.displayBooks();
}
