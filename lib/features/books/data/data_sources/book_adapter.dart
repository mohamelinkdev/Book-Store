import 'package:book_store/core/constants/hive_constants.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:hive/hive.dart';

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = HiveConstants.bookHiveTypeIds;

  @override
  Book read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final author = reader.readString();
    final thumbnail = reader.readString();
    final description = reader.readString();

    return Book(
      id: id,
      title: title,
      author: author,
      thumbnail: thumbnail,
      description: description,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.author);
    writer.writeString(obj.thumbnail);
    writer.writeString(obj.description);
  }
}
