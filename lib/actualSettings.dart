
//OVERALL
var ichBin = "schüler";  // Ich bin: schüler, lehrer, elternteil

//STUNDENPLAN
bool abWoche = true;

// TAGESPLAN
var platzhalter = "lol";

// VERTRETUNGSPLAN
var meineKlasse = "7b";
var meinName = "Frau Strohschein";
bool vertretungHighlight = true;


// Handler

ichBinHandler(){
  if(ichBin == "schüler"){
    return meineKlasse;
  }else if(ichBin == "lehrer"){
    return meinName;
  }else if(ichBin == "elternteil"){
    print("lol");
  }else{
    print("lol, ein error");
  }
}