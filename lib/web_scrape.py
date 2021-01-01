import requests     # Zum Lesen der Webseite / des HTML-Codes
import time         # Zeitberechnung
import json         # Zum Umgang mit JSON-Dateien
import sys


class mainClass():

    durchlauf = 0

    try:
        startzeit = time.time()

        while True:

            durchlauf += 1
            print("\n\n\t\t\t#####", '{:08}'.format(durchlauf), "#####")
            print("\t>> START")

            datum = 'Datum aus dart-File'

            #URL_Vertretungsplan = "http://www.gymnasium-templin.de/typo3/vertretung/index.php?d=" + str(datum)
                                    #URL + aktuelles Datum (oder nächster Montag)
            #URL_Vertretungsplan = "http://www.gymnasium-templin.de/typo3/vertretung/index.php?d=20181220"
            URL_Vertretungsplan = "http://www.gymnasium-templin.de/typo3/vertretung/index.php"
            #URL_Vertretungsplan = str(input("Geben sie bitte die URL des gewünschten Vertretungsplans ein:\n"))



            # Datum wird ausgeben

            print("\tDatum:", str(datum))
            print("\tZeit seit Start:", str(time.time() - startzeit), "Sek.")

            # --------------------------------------------------------------------------------------------------------#

            # Offline-Modus | Wenn aus:   Website wird gelesen und in die url.txt-Datei geschrieben
            #                 Wenn aktiv: URL wird durch vorgefertigte Datei ("url_offline.txt") ersetzt

            r = requests.get(URL_Vertretungsplan)
            print("\tWebsite gelesen.")

            file = open("url.txt", "w")
            file.write(r.text)
            file.close()
            print("\tTXT-Datei überschrieben.")

            datei = "url.txt"

            # Datei ("url.txt") wird im Lese-/Schreibemodus geöffnet

            file = open(datei, "r+")
            d = file.readlines()
            file.seek(0)

            # Filtern von Informationen
            # Zeilen mit entsprechenden HTML-Elementen werden gefunden und in eine Datei geschrieben

            for i in d:
                ##    if "Hr" in i or "Fr" in i:
                ##        file.write("\n")
                if ("></td>" not in i) and ("""<td align="center">""" in i) or ("<td>" in i) or ("""<td align="center"></td>""" in i):
                    file.write(i)
            print("\tInformationen herausgefiltert.")
            file.truncate()
            file.close()

            # Datei ("url.txt") wird im Lese-/Schreibemodus geöffnet

            file = open(datei, "r+")
            d = file.readlines()
            file.seek(0)

            # HTML-Elemente werden aus der Datei entfernt | Nur nützliche Informationen werden behalten

            delete_list = ["""<td align="center">""", "<td>", "</td>", "<br>", "\t"]
            for line in file:
                for word in delete_list:
                    line = line.replace(word, "")
                file.write(line)
            print("\tUnnötige Zeichen entfernt und kopiert.")
            file.truncate()
            file.close()

            # Datei ("url.txt") wird im Lese geöffnet -> Zeilen werden ausgelesen

            file = open(datei, "r")
            lines = file.readlines()
            file.close()

            # Datei ("url.txt") wird im Schreibemodus geöffnet

            file = open(datei, "w")

            # Restliche HTML-Formatierungen und unnötige Zeilen werden entfernt

            for line in lines:
                if "<" not in line or ">" not in line:
                    file.write(line)
            print("\tUnnötige Zeilen entfernt.")
            file.close()
            file = open(datei, "r")
            lines = file.readlines()
            file.close()


            p = 0

            titel = ["Info", "Raum", "Klasse", "Fach", "Block", "Lehrer"]

            for i in range(6):

                lines.insert(p, titel[p])
                lines.insert(0, "Zum Löschen")
                lines.append("\n")

                p += 1

            vertretung_o = [0 ,6 ,12 ,18 ,24 ,30 ,36 ,42 ,48 ,54 ,60 ,66 ,72 ,78 ,84 ,90 ,96 ,102 ,108 ,114 ,120 ,126 ,
                            132 ,138 ,144 ,150 ,156 ,162 ,168 ,174 ,180 ,186 ,192 ,198 ,204 ,210 ,216 ,222 ,228 ,234 ,
                            240 ,246 ,252 ,258 ,264 ,270 ,276 ,282 ,288 ,294 ,300 ,306 ,312 ,318 ,324 ,330 ,336 ,342 ,
                            348 ,354 ,360 ,366 ,372 ,378 ,384 ,390 ,396 ,402 ,408 ,414 ,420 ,426 ,432 ,438 ,444 ,450 ,
                            456 ,462 ,468 ,474 ,480 ,486 ,492 ,498 ,504 ,510 ,516 ,522 ,528 ,534 ,540 ,546 ,552 ,558 ,
                            564 ,570 ,576 ,582 ,588 ,594]
            block_o = [1 ,7 ,13 ,19 ,25 ,31 ,37 ,43 ,49 ,55 ,61 ,67 ,73 ,79 ,85 ,91 ,97 ,103 ,109 ,115 ,121 ,127 ,133 ,
                       139 ,145 ,151 ,157 ,163 ,169 ,175 ,181 ,187 ,193 ,199 ,205 ,211 ,217 ,223 ,229 ,235 ,241 ,247 ,
                       253 ,259 ,265 ,271 ,277 ,283 ,289 ,295 ,301 ,307 ,313 ,319 ,325 ,331 ,337 ,343 ,349 ,355 ,361 ,
                       367 ,373 ,379 ,385 ,391 ,397 ,403 ,409 ,415 ,421 ,427 ,433 ,439 ,445 ,451 ,457 ,463 ,469 ,475 ,
                       481 ,487 ,493 ,499 ,505 ,511 ,517 ,523 ,529 ,535 ,541 ,547 ,553 ,559 ,565 ,571 ,577 ,583 ,589 ,
                       595]
            fach_o = [2 ,8 ,14 ,20 ,26 ,32 ,38 ,44 ,50 ,56 ,62 ,68 ,74 ,80 ,86 ,92 ,98 ,104 ,110 ,116 ,122 ,128 ,134 ,
                      140 ,146 ,152 ,158 ,164 ,170 ,176 ,182 ,188 ,194 ,200 ,206 ,212 ,218 ,224 ,230 ,236 ,242 ,248 ,
                      254 ,260 ,266 ,272 ,278 ,284 ,290 ,296 ,302 ,308 ,314 ,320 ,326 ,332 ,338 ,344 ,350 ,356 ,362 ,
                      368 ,374 ,380 ,386 ,392 ,398 ,404 ,410 ,416 ,422 ,428 ,434 ,440 ,446 ,452 ,458 ,464 ,470 ,476 ,
                      482 ,488 ,494 ,500 ,506 ,512 ,518 ,524 ,530 ,536 ,542 ,548 ,554 ,560 ,566 ,572 ,578 ,584 ,590 ,
                      596]
            klasse_o = [3 ,9 ,15 ,21 ,27 ,33 ,39 ,45 ,51 ,57 ,63 ,69 ,75 ,81 ,87 ,93 ,99 ,105 ,111 ,117 ,123 ,129 ,
                        135 ,141 ,147 ,153 ,159 ,165 ,171 ,177 ,183 ,189 ,195 ,201 ,207 ,213 ,219 ,225 ,231 ,237 ,
                        243 ,249 ,255 ,261 ,267 ,273 ,279 ,285 ,291 ,297 ,303 ,309 ,315 ,321 ,327 ,333 ,339 ,345 ,
                        351 ,357 ,363 ,369 ,375 ,381 ,387 ,393 ,399 ,405 ,411 ,417 ,423 ,429 ,435 ,441 ,447 ,453 ,
                        459 ,465 ,471 ,477 ,483 ,489 ,495 ,501 ,507 ,513 ,519 ,525 ,531 ,537 ,543 ,549 ,555 ,561 ,
                        567 ,573 ,579 ,585 ,591 ,597]
            raum_o = [4 ,10 ,16 ,22 ,28 ,34 ,40 ,46 ,52 ,58 ,64 ,70 ,76 ,82 ,88 ,94 ,100 ,106 ,112 ,118 ,124 ,130 ,
                      136 ,142 ,148 ,154 ,160 ,166 ,172 ,178 ,184 ,190 ,196 ,202 ,208 ,214 ,220 ,226 ,232 ,238 ,244 ,
                      250 ,256 ,262 ,268 ,274 ,280 ,286 ,292 ,298 ,304 ,310 ,316 ,322 ,328 ,334 ,340 ,346 ,352 ,358 ,
                      364 ,370 ,376 ,382 ,388 ,394 ,400 ,406 ,412 ,418 ,424 ,430 ,436 ,442 ,448 ,454 ,460 ,466 ,472 ,
                      478 ,484 ,490 ,496 ,502 ,508 ,514 ,520 ,526 ,532 ,538 ,544 ,550 ,556 ,562 ,568 ,574 ,580 ,586 ,
                      592 ,598]
            bemerkung_o = [5 ,11 ,17 ,23 ,29 ,35 ,41 ,47 ,53 ,59 ,65 ,71 ,77 ,83 ,89 ,95 ,101 ,107 ,113 ,119 ,125 ,
                           131 ,137 ,143 ,149 ,155 ,161 ,167 ,173 ,179 ,185 ,191 ,197 ,203 ,209 ,215 ,221 ,227 ,233 ,
                           239 ,245 ,251 ,257 ,263 ,269 ,275 ,281 ,287 ,293 ,299 ,305 ,311 ,317 ,323 ,329 ,335 ,341 ,
                           347 ,353 ,359 ,365 ,371 ,377 ,383 ,389 ,395 ,401 ,407 ,413 ,419 ,425 ,431 ,437 ,443 ,449 ,
                           455 ,461 ,467 ,473 ,479 ,485 ,491 ,497 ,503 ,509 ,515 ,521 ,527 ,533 ,539 ,545 ,551 ,557 ,
                           563 ,569 ,575 ,581 ,587 ,593 ,599]

            x = 0
            vertretung = []
            block = []
            fach = []
            klasse = []
            raum = []
            bemerkung = []

            u = int(len(lines) / 6)
            #print("\t\tZeilen:", u)
            #print("\t\tAnzahl der Zeilen in lines:", len(lines))

            if len(lines) > 0:
                for i in range(int(len(lines) / 6)):
                    #print("", lines[vertretung_o[x]].replace("\n"," "),lines[block_o[x]].replace("\n"," "),lines[fach_o[x]].replace("\n"," "),lines[klasse_o[x]].replace("\n"," "),lines[raum_o[x]].replace("\n"," "),lines[bemerkung_o[x]].replace("\n"," "),"\n")

                    vertretung.extend([lines[vertretung_o[x]].replace("\n", "")])
                    block.extend([lines[block_o[x]].replace("\n", "")])
                    fach.extend([lines[fach_o[x]].replace("\n", "")])
                    klasse.extend([lines[klasse_o[x]].replace("\n", "")])
                    raum.extend([lines[raum_o[x]].replace("\n", "")])
                    bemerkung.extend([lines[bemerkung_o[x]].replace("\n", "")])
                    x += 1

            else:
                print("\tEs sind keine Einträge vorhanden.")

            print("\tInformationen in Listen eingetragen.")

            vertretungFile = open("vertretungsplan.json", "w")
            vertretungFile.write(
                '{\n'
            #    '   "vertretungsplan": [\n'
            )

            vertretungFile.write(
                '\n\t"date":{'
                '\n\t\t"datum": "' + datum +  '"\n'
                '\t},\n'
            )


            var1 = 0

            for t in range(int(len(lines) / 6)-1):
                vertretungFile.write(
                    '\n\t"' + ("v" + str(var1)) +'":{'
                    '\n\t\t"vertretung": "' + str(vertretung[var1]) + '",\n'
                    '\t\t"block": "' + str(block[var1]) + '",\n'
                    '\t\t"fach": "' + str(fach[var1]) + '",\n'
                    '\t\t"klasse": "' + str(klasse[var1]) + '",\n'
                    '\t\t"raum": "' + str(raum[var1]) + '",\n'
                    '\t\t"bemerkung": "' + str(bemerkung[var1]) + '"'
                    '\n\t},'
                )
                var1 += 1

            vertretungFile.write(
                '\n\t"ende":{'
                '\n\t\t"schlusswort": "Ende der Datei."\n'
                '\t}\n'
                '}'
            )

            vertretungFile.close()

            print("\tInformationen als .json exportiert.")

            f3 = open("vertretungsplan.json", "r")
            lines1 = f3.readlines()
            f3.close()

            f3_1 = open("vertretungsplan.json", "w")
            for line1 in lines1:
                if "Zum Löschen" not in line1:
                    f3_1.write(line1)
            f3_1.close()

            print("\tUnnötige Zeilen der .json entfernt.")

            with open("vertretungsplan.json", "r") as file:
                filedata = file.read()
            filedata = filedata.replace("ä", "ae")
            filedata = filedata.replace("ö", "oe")
            filedata = filedata.replace("ü", "ue")

            with open("vertretungsplan.json", "w") as file:
                file.write(filedata)

    except:
        print("\n############################\n\nProgramm wird beendet in...:\n")
        countdown = 5
        for i in range(5):
            time.sleep(1)
            print("\t\t >>", countdown, "<<")
            countdown -= 1
        time.sleep(1)
        sys.exit("  \nProgramm wurde beendet.")
