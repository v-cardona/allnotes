import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:allnotes/domain/entities/note_state_entity.dart';

class NoteModel {
  final String? id;
  final String title;
  final String content;
  final int color;
  final int statusInt;
  final DateTime createdAt;
  final DateTime modifiedAt;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.statusInt,
    DateTime? createdAt,
    DateTime? modifiedAt,
  })  : createdAt = DateTime.now(),
        modifiedAt = modifiedAt ?? DateTime.now();

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    int? color,
    int? statusInt,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      statusInt: statusInt ?? this.statusInt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  factory NoteModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return NoteModel(
      title: data?['title'],
      content: data?['content'],
      color: data?['color'],
      statusInt: data?['status'],
      createdAt: data?['createdAt'].toDate(),
      modifiedAt: data?['modifiedAt'].toDate(),
    );
  }

  factory NoteModel.firstNote() {
    return NoteModel(
      title: 'Untitled',
      content: 'This is your first note',
      color: Colors.white.value,
      statusInt: NoteStateEntity().getEnumValue(NoteState.unspecified),
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "title": title,
      "content": content,
      "color": color,
      "status": statusInt,
      "createdAt": createdAt,
      "modifiedAt": modifiedAt,
    };
  }
}
