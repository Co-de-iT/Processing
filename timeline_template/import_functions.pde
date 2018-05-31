ArrayList<TimelineEvent> importEvents(String fileName, char token) {
  ArrayList<TimelineEvent> events;
  String[]lines;
  String[][] fields;

  int year;
  String evTitle;
  String evDesc;

  // load file from path
  lines = loadStrings(dataPath(fileName));
  fields = new String[lines.length][];

  events = new ArrayList<TimelineEvent>();

  for (int i=0; i<lines.length; i++) {

    // splits lines into words
    fields[i] = split(lines[i], token); // split wants a char - splitTokens a String

    // get data into the fields

    // year
    year = int(Float.valueOf(fields[i][0]));    
    // event
    evTitle = fields[i][1];
    // description
    evDesc = fields[i][2];

    events.add(new TimelineEvent(year, evTitle, evDesc));
  }
  return events;
}



// the neutral read file function

void readFile(String fileName, String token) {
  String[]lines;
  String[][] words;

  // load file from path
  lines = loadStrings(dataPath(fileName));
  words = new String[lines.length][];

  for (int i=0; i<lines.length; i++) {

    // splits lines into words
    words[i] = splitTokens(lines[i], token);
    for (int j=0; j< words[i].length; j++) {
    }
    println();
  }
}
