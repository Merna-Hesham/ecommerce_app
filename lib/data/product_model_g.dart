part of 'product_model.dart';

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };

    return Product(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      category: fields[3] as String,
      price: fields[4] as double,
      rating: fields[5] as double,
      images: (fields[6] as List).cast<String>(),
      thumbnail: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.thumbnail);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
