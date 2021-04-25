# Lexique


| Abbreviation | Signification                                                                                              |
| ------------ | ---------------------------------------------------------------------------------------------------------- |
| COV          | [Composé organique volatil](https://fr.wikipedia.org/wiki/Compos%C3%A9_organique_volatil) (VOC en anglais) |
| TCOV/TVOC    | Le "T" est pour total                                                                                      |

Pour les colonnes "testé":
- :heavy_check_mark: : testé et à priori OK
- :x: : testé et pas terrible (on est pas des experts, peut être que le composant testé était défectueux ou qu'on l'a mal utilisé)
- :grey_question: : pas testé


# Brain box

Pour quelque chose d'indépendant, la solution la plus simple est un esp8266/esp32 avec [esphome](https://esphome.io/).
On n'a pas considéré quelque chose d'intégré à klipper/au pi de l'imprimante pour l'instant.
Esphome fonctionne très bien avec [Home Assistant](https://www.home-assistant.io/) pour la collecte des données et l'affichage (possibilité d'envoyer les données vers une base influxdb pour affichage dans grafana).

| uC                          | Testé              | Prix  |
| --------------------------- | ------------------ | ----- |
| esp8266 (generique)         |                    | ---   |
| Wemos D1 mini pro (esp8266) | :heavy_check_mark: | ~2.5€ |
| esp32 (generique)           |                    | ~3€   |
| Wemos D1 mini ESP32         | :heavy_check_mark: | ~3€   |

[Plus de détails](./ESP.md).

# Capteur/sensor

| Sensor                              | Capacités                                                         | Protocole | Testé              | Prix  |
| ----------------------------------- | ----------------------------------------------------------------- | --------- | ------------------ | ----- |
| [BME680](./COV.md#bme680)           | Température, humidité, pression, [COV, eCO2, IAQ si blob utilisé] | i2c       | :heavy_check_mark: | ~11€  |
| [CJMCU-811/CCS811](./COV.md#bme680) | eCO2, VOC                                                         | i2c       | :heavy_check_mark: | ~5€   |
| [SGP30](./COV.md#sgp30)             |                                                                   | i2c       | :grey_question:    | ~6€   |
| [ZMOD4410](./COV.md#zmod4410)       | TVOC, eCO2, EtOH, IAQ - Pas dans esphome                          | i2c       | :grey_question:    |       |
| [MH-Z19](./Autres.md#mh-z19)        | CO2, Temp                                                         |           | :grey_question:    |       |
| [MH-Z19B](./Autres.md#mh-z19)       | CO2, Temp                                                         |           | :grey_question:    | ~16€  |
| [SCD30](./Autres.md#scd30)          |                                                                   |           | :grey_question:    |       |
| [Si7021/HTU21](./Autres.md#htu21)   | Température, humidité                                             | i2c       | :heavy_check_mark: | ~1.5€ |
| [BME280](./Autres.md#bme280)        | Température, humidité, pression                                   | i2c       | :grey_question:    | ~7€   |
| [SDS011](./Particules.md#sds011)    | PM2.5, PM10                                                       | uart      | :grey_question:    | ~15€  |
| [PMS5003](./Particules.md#pmsx003)  |                                                                   | uart      | :grey_question:    |       |
| [PMS7003](./Particules.md#pmsx003)  |                                                                   | uart      | :grey_question:    |       |
| [SPS30](./Particules.md#sps30)      | PM1, PM2.5, PM4, PM10                                             | uart/i2c  | :grey_question:    | ~27€  |
|                                     |                                                                   |           |                    |       |



# Liens


## Projets
- Luftdaten/AirRohr : https://sensor.community/fr/sensors/airrohr/
- https://howtomechatronics.com/projects/diy-air-quality-monitor-pm2-5-co2-voc-ozone-temp-hum-arduino-meter/
- https://github.com/nkitanov/iaq_board

## Autres liens
- Sensor evaluation : https://aqicn.org/sensor/
- Comparaison PMSX003: https://aqicn.org/sensor/pms5003-7003/fr/
