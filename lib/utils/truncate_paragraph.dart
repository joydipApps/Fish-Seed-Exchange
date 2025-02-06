String truncateParagraph(String paragraph) {
  if (paragraph.length <= 1500) {
    return paragraph; // No need to truncate
  }

  // Find the nearest full stop within the limit
  int truncateIndex = paragraph.lastIndexOf('.', 1500);

  if (truncateIndex == -1) {
    // If there is no full stop, truncate at the character limit
    return paragraph.substring(0, 1500);
  } else {
    // Truncate at the nearest full stop
    return paragraph.substring(0, truncateIndex + 1);
  }
}
