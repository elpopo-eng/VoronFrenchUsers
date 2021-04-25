# BME680
- [Integration dans esphome](https://github.com/trvrnrth/esphome-bsec-bme680)

Testé dans mon salon, a l'air OK, mais je n'ai pas grand chose pour comparer.

Achat:
- [AE](https://fr.aliexpress.com/item/4000049700826.html)
- [AE2](https://fr.aliexpress.com/item/4001113450307.html) (commandé seulement pour l'instant.)

# CJMCU-811/CCS811

Le CCS811 peut être couplé avec un sensor temp+hum pour améliorer les résultats.

Testé dans mon salon, reporte des valeurs de COV plus faibles que le BME680.

Achat:
- [AE](https://fr.aliexpress.com/item/4001041877560.html)

# SGP30

Capteur TVOC/eCO2 pour detecter les VOC, le CO2, les formhaldéhydes, etc... donc en théorie les vapeurs d'ABS, etc... 

Achat:
- [AE](https://fr.aliexpress.com/item/4000004614708.html) (commandé seulement pour l'instant.)

# ZMOD4410

Capteur relativement récent, il n'y a pas encore d'intégration dans esphome. Probablement plus difficile à utiliser car il s'agit d'une capteur moins spécialiser pour lequel on doit créer un algorithme en fonction d'un apprentissage à faire pour ce qu'on veut détecter.

Le FW de test (blob) fourni par Renesas reporte TVOC, eCO2, EtOH et IAQ. J'ai réussi à le linker pour un esp32 et un stm32, mais pas pour un esp8266.
