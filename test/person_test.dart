import 'package:crud_sqlite/person.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('round-trips through the SQLite row representation', () {
    const person = Person(
      id: 7,
      name: 'Ahmad Sattar',
      email: 'ahmadsattar457@gmail.com',
      age: 21,
      imagePath: '/data/img_1.png',
    );

    final restored = Person.fromMap(person.toMap());

    expect(restored.id, person.id);
    expect(restored.name, person.name);
    expect(restored.email, person.email);
    expect(restored.age, person.age);
    expect(restored.imagePath, person.imagePath);
  });

  test('omits the id so SQLite can auto-increment a new row', () {
    const person = Person(name: 'Sara Zahid', email: 'sara.zahid@gmail.com', age: 26);
    expect(person.toMap().containsKey('id'), isFalse);
    expect(person.toMap()['image_path'], isNull);
  });

  test('builds avatar initials, falling back when the name is blank', () {
    expect(const Person(name: 'Bilal Tariq', email: 'b@t.com', age: 29).initials, 'BT');
    expect(const Person(name: 'Ahmad', email: 'a@b.com', age: 21).initials, 'A');
    expect(const Person(name: '   ', email: 'a@b.com', age: 21).initials, '?');
  });

  test('copyWith only replaces the fields it is given', () {
    const person = Person(id: 3, name: 'Sara', email: 'sara@x.com', age: 24);
    final updated = person.copyWith(age: 26);
    expect(updated.age, 26);
    expect(updated.id, 3);
    expect(updated.name, 'Sara');
  });
}
