bool isQuestion(String text) {
  final questionWords = ['what', 'when', 'where', 'who', 'why', 'how', 'is', 'are', 'am', 'can', 'could', 'should', 'do', 'does', 'did', 'will', 'would', 'won\'t', 'can\'t'];
  final trimmedText = text.trim();

  if (trimmedText.endsWith('?')) {
    return true;
  }

  final words = trimmedText.toLowerCase().split(' ');
  return words.isNotEmpty && questionWords.contains(words[0]);
}

bool isLegitimateQuestion(String text) {
  //Vision
  //Conversation Bot where you can simply talk about stuff
  //Questions that can be answered:
  //LGBTQ Crisis Info, LGBTQ Law/Injustices

  if ((text.toLowerCase().contains("support") && text.toLowerCase().contains("lgbtq")) || text.toLowerCase().contains("depression") || text.toLowerCase().contains("anxiety") || text.toLowerCase().contains("suicide") || text.toLowerCase().contains("addiction") || text.toLowerCase().contains("abuse") || text.toLowerCase().contains("ptsd") || text.toLowerCase().contains("discrimination") || text.toLowerCase().contains("bipolar") || text.toLowerCase().contains("disorder") || text.toLowerCase().contains("personality") || text.toLowerCase().contains("eating disorder") || text.toLowerCase().contains("ocd") || text.toLowerCase().contains("dysphoria") || text.toLowerCase().contains("body dysmorphia") || text.toLowerCase().contains("autism")  ||  (text.toLowerCase().contains("lgbtq") && text.toLowerCase().contains("rights")) || text.toLowerCase().contains("lgbtq") || text.toLowerCase().contains("stress") || text.toLowerCase().contains("mental health") || text.toLowerCase().contains("feel") || text.toLowerCase().contains("feeling")) {
    return true;
  } else {
    return false;
  }
}