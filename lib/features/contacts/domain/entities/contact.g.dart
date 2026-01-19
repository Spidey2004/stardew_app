// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContactCollection on Isar {
  IsarCollection<Contact> get contacts => this.collection();
}

const ContactSchema = CollectionSchema(
  name: r'Contact',
  id: 342568039478732666,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currentMonth': PropertySchema(
      id: 1,
      name: r'currentMonth',
      type: IsarType.string,
    ),
    r'fullHearts': PropertySchema(
      id: 2,
      name: r'fullHearts',
      type: IsarType.long,
    ),
    r'giftGivenThisMonth': PropertySchema(
      id: 3,
      name: r'giftGivenThisMonth',
      type: IsarType.bool,
    ),
    r'hasHalfHeart': PropertySchema(
      id: 4,
      name: r'hasHalfHeart',
      type: IsarType.bool,
    ),
    r'lastInteraction': PropertySchema(
      id: 5,
      name: r'lastInteraction',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 7,
      name: r'notes',
      type: IsarType.string,
    ),
    r'proximityLevel': PropertySchema(
      id: 8,
      name: r'proximityLevel',
      type: IsarType.long,
    )
  },
  estimateSize: _contactEstimateSize,
  serialize: _contactSerialize,
  deserialize: _contactDeserialize,
  deserializeProp: _contactDeserializeProp,
  idName: r'id',
  indexes: {
    r'proximityLevel': IndexSchema(
      id: -5521173573896297292,
      name: r'proximityLevel',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'proximityLevel',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _contactGetId,
  getLinks: _contactGetLinks,
  attach: _contactAttach,
  version: '3.1.0+1',
);

int _contactEstimateSize(
  Contact object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.currentMonth.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  return bytesCount;
}

void _contactSerialize(
  Contact object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.currentMonth);
  writer.writeLong(offsets[2], object.fullHearts);
  writer.writeBool(offsets[3], object.giftGivenThisMonth);
  writer.writeBool(offsets[4], object.hasHalfHeart);
  writer.writeDateTime(offsets[5], object.lastInteraction);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.notes);
  writer.writeLong(offsets[8], object.proximityLevel);
}

Contact _contactDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Contact();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.currentMonth = reader.readString(offsets[1]);
  object.giftGivenThisMonth = reader.readBool(offsets[3]);
  object.id = id;
  object.lastInteraction = reader.readDateTime(offsets[5]);
  object.name = reader.readString(offsets[6]);
  object.notes = reader.readString(offsets[7]);
  object.proximityLevel = reader.readLong(offsets[8]);
  return object;
}

P _contactDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _contactGetId(Contact object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _contactGetLinks(Contact object) {
  return [];
}

void _contactAttach(IsarCollection<dynamic> col, Id id, Contact object) {
  object.id = id;
}

extension ContactQueryWhereSort on QueryBuilder<Contact, Contact, QWhere> {
  QueryBuilder<Contact, Contact, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhere> anyProximityLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'proximityLevel'),
      );
    });
  }
}

extension ContactQueryWhere on QueryBuilder<Contact, Contact, QWhereClause> {
  QueryBuilder<Contact, Contact, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> proximityLevelEqualTo(
      int proximityLevel) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'proximityLevel',
        value: [proximityLevel],
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> proximityLevelNotEqualTo(
      int proximityLevel) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proximityLevel',
              lower: [],
              upper: [proximityLevel],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proximityLevel',
              lower: [proximityLevel],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proximityLevel',
              lower: [proximityLevel],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'proximityLevel',
              lower: [],
              upper: [proximityLevel],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> proximityLevelGreaterThan(
    int proximityLevel, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'proximityLevel',
        lower: [proximityLevel],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> proximityLevelLessThan(
    int proximityLevel, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'proximityLevel',
        lower: [],
        upper: [proximityLevel],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterWhereClause> proximityLevelBetween(
    int lowerProximityLevel,
    int upperProximityLevel, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'proximityLevel',
        lower: [lowerProximityLevel],
        includeLower: includeLower,
        upper: [upperProximityLevel],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContactQueryFilter
    on QueryBuilder<Contact, Contact, QFilterCondition> {
  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currentMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currentMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currentMonth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currentMonth',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> currentMonthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentMonth',
        value: '',
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition>
      currentMonthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currentMonth',
        value: '',
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> fullHeartsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullHearts',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> fullHeartsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullHearts',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> fullHeartsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullHearts',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> fullHeartsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullHearts',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition>
      giftGivenThisMonthEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'giftGivenThisMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> hasHalfHeartEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasHalfHeart',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> lastInteractionEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastInteraction',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition>
      lastInteractionGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastInteraction',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> lastInteractionLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastInteraction',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> lastInteractionBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastInteraction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> proximityLevelEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proximityLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition>
      proximityLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proximityLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> proximityLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proximityLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<Contact, Contact, QAfterFilterCondition> proximityLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proximityLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContactQueryObject
    on QueryBuilder<Contact, Contact, QFilterCondition> {}

extension ContactQueryLinks
    on QueryBuilder<Contact, Contact, QFilterCondition> {}

extension ContactQuerySortBy on QueryBuilder<Contact, Contact, QSortBy> {
  QueryBuilder<Contact, Contact, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByCurrentMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMonth', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByCurrentMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMonth', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByFullHearts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullHearts', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByFullHeartsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullHearts', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByGiftGivenThisMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'giftGivenThisMonth', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByGiftGivenThisMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'giftGivenThisMonth', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByHasHalfHeart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasHalfHeart', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByHasHalfHeartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasHalfHeart', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByLastInteraction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastInteraction', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByLastInteractionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastInteraction', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByProximityLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximityLevel', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> sortByProximityLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximityLevel', Sort.desc);
    });
  }
}

extension ContactQuerySortThenBy
    on QueryBuilder<Contact, Contact, QSortThenBy> {
  QueryBuilder<Contact, Contact, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByCurrentMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMonth', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByCurrentMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMonth', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByFullHearts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullHearts', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByFullHeartsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullHearts', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByGiftGivenThisMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'giftGivenThisMonth', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByGiftGivenThisMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'giftGivenThisMonth', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByHasHalfHeart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasHalfHeart', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByHasHalfHeartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasHalfHeart', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByLastInteraction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastInteraction', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByLastInteractionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastInteraction', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByProximityLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximityLevel', Sort.asc);
    });
  }

  QueryBuilder<Contact, Contact, QAfterSortBy> thenByProximityLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proximityLevel', Sort.desc);
    });
  }
}

extension ContactQueryWhereDistinct
    on QueryBuilder<Contact, Contact, QDistinct> {
  QueryBuilder<Contact, Contact, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByCurrentMonth(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentMonth', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByFullHearts() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullHearts');
    });
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByGiftGivenThisMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'giftGivenThisMonth');
    });
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByHasHalfHeart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasHalfHeart');
    });
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByLastInteraction() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastInteraction');
    });
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Contact, Contact, QDistinct> distinctByProximityLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proximityLevel');
    });
  }
}

extension ContactQueryProperty
    on QueryBuilder<Contact, Contact, QQueryProperty> {
  QueryBuilder<Contact, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Contact, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Contact, String, QQueryOperations> currentMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentMonth');
    });
  }

  QueryBuilder<Contact, int, QQueryOperations> fullHeartsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullHearts');
    });
  }

  QueryBuilder<Contact, bool, QQueryOperations> giftGivenThisMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'giftGivenThisMonth');
    });
  }

  QueryBuilder<Contact, bool, QQueryOperations> hasHalfHeartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasHalfHeart');
    });
  }

  QueryBuilder<Contact, DateTime, QQueryOperations> lastInteractionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastInteraction');
    });
  }

  QueryBuilder<Contact, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Contact, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Contact, int, QQueryOperations> proximityLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proximityLevel');
    });
  }
}
