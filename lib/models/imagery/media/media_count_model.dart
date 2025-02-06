import 'package:flutter_riverpod/flutter_riverpod.dart';

class MediaCountModel {
  final String saleId;
  final int seedPicCount;
  final int seedVideoCount;

  MediaCountModel({
    required this.saleId,
    required this.seedPicCount,
    required this.seedVideoCount,
  });

  // Factory method to create an instance from JSON
  factory MediaCountModel.fromJson(Map<String, dynamic> json) {
    return MediaCountModel(
      saleId: json['saleId'],
      seedPicCount: json['seedPicCount'],
      seedVideoCount: json['seedVideoCount'],
    );
  }
}

class MediaCountModelNotifier extends StateNotifier<List<MediaCountModel>> {
  MediaCountModelNotifier() : super([]); // Initialize with an empty list

  // Update the entire list of media counts
  void updateMedias(List<MediaCountModel> newMedias) {
    state = List.from(newMedias); // Create a new list to ensure immutability
  }

  // Add a single media count to the list
  void addMedia(MediaCountModel newMedia) {
    state = [...state, newMedia]; // Add the new media count to the existing list
  }

  // Add multiple media counts to the list
  void addAllMedia(List<MediaCountModel> newMedias) {
    state = [...state, ...newMedias]; // Add all new media counts to the existing list
  }

  // Remove a media count by its saleId
  void removeMedia(String saleId) {
    state = state.where((media) => media.saleId != saleId).toList(); // Filter out the media count with the specified saleId
  }
}

// Provider for the MediaCountModelNotifier
final mediaCountModelProvider =
StateNotifierProvider<MediaCountModelNotifier, List<MediaCountModel>>((ref) {
  return MediaCountModelNotifier();
});
