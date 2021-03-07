# Liens importants

Ces liens permettent de voir les changement récents qui pourraient expliquer qu'une configuration ne marche plus:
* [Notes de release de klipper](https://github.com/KevinOConnor/klipper/blob/master/docs/Releases.md)
* [Changements de config pour klipper](https://github.com/KevinOConnor/klipper/blob/master/docs/Config_Changes.md)
* [Changements de config pour moonraker](https://github.com/Arksine/moonraker/blob/master/docs/user_changes.md)


# Fichiers importants

## Configurations:

### Par défaut

* klipper: ~/printer.cfg
* moonraker: ~/moonraker.conf

### Alternative en fonction des tutos suivis

* klipper: ~/klipper_config/printer.cfg
* moonraker: ~/klipper_config/moonraker.conf

## Logs

Attention quand on redémarre klipper ou moonraker, le log n'est pas effacé, ils écrivent juste à la fin du fichier, il faut donc aller voir à la fin pour voir le résulat du dernier démarrage.

### Par défaut

* klipper: /log/klippy.log
* moonraker: /log/moonraker.log

# Commandes utiles

* Lister les ports série des cartes connectées: `ls /dev/serial/by-id/`
* Redémarrer klipper/moonraker:
  * `sudo service klipper restart`
  * `sudo service moonraker restart`
* Vérifier si klipper/moonraker est démarré et afficher les dernières lignes du log:
  *	`sudo service klipper status`
  *	`sudo service moonraker status`
* Vérifier ce qu'il se passe quand on connecte une carte au pi (ctrl-c pour arrêter):
  *	`dmesg -wT`

# Dépannage

## Je change ma config, mais les paramètres ne sont pas pris en compte

Est-ce que tu changes le bon fichier ? Il y a 2 manières faciles de vérifier quel fichier de config est utilisé:

1. 	`sudo service xxxxxxx status`
```
$ sudo service klipper status
● klipper.service - LSB: Klipper daemon
Loaded: loaded (/etc/init.d/klipper; generated)
Active: active (running) since Sat 2021-03-06 15:14:34 GMT; 3h 36min ago
	Docs: man:systemd-sysv-generator(8)
Process: 415 ExecStart=/etc/init.d/klipper start (code=exited, status=0/SUCCESS)
	Tasks: 6 (limit: 1938)
CGroup: /system.slice/klipper.service
		└─453 /home/pi/klippy-env/bin/python /home/pi/klipper/klippy/klippy.py /home/pi/klipper_config/printer.cfg -l /tmp/klippy.log -a /tmp/klippy_uds

Mar 06 15:14:34 mainsailos systemd[1]: Starting LSB: Klipper daemon...
Mar 06 15:14:34 mainsailos klipper[415]: Starting klipper: klipper.
Mar 06 15:14:34 mainsailos systemd[1]: Started LSB: Klipper daemon.
```

Sur la ligne avec `└─` on voit le path du fichier de config utilisé (ici `/home/pi/klipper_config/printer.cfg`).

Example avec moonraker:
```
$ sudo service moonraker status
● moonraker.service - Starts Moonraker on startup
   Loaded: loaded (/etc/systemd/system/moonraker.service; enabled; vendor preset: enabled)
   Active: active (running) since Sat 2021-03-06 15:14:42 GMT; 3h 46min ago
 Main PID: 565 (python)
    Tasks: 6 (limit: 1938)
   CGroup: /system.slice/moonraker.service
           └─565 /home/pi/moonraker-env/bin/python /home/pi/moonraker/moonraker/moonraker.py -c /home/pi/moonraker.conf

Mar 06 18:56:39 mainsailos python[565]: [web.py:log_request()] - 200 GET /printer/objects/query?heater_bed&extruder&print_stats&toolhead&display_status&virtual_sdcard
```

2. les fichiers de log klippy.log/moonraker.log, à chaque fois que le service est démarré, le fichier de config utilisé est copié dans le log, d'abord le path, puis le contenu.


## Mainsail/fluidd "printer is not ready"

### Changement du 4 mars dans moonraker [lien](https://github.com/Arksine/moonraker/blob/master/docs/user_changes.md#march-4th-2021)

Il faut ajouter `[octoprint_compat]` dans `moonraker.conf` puis redémarrer moonraker (`sudo service moonraker restart`)

### Autre

Ce message veut dire que mainsail/fluid n'arrive pas à se connecter à moonraker, il y a 2 causes possibles:
* moonraker ne tourne pas ou n'autorise pas les connections
* klipper ne tourne pas, du coup moonraker reporte qu'il attend klipper (`The klippy host software is attempting to connect.  Please retry in a few moments.`)

Il est facile de commencer par vérifier le log de moonraker pour voir s'il y a le message à propos de klipper.

S'il n'y a pas de message d'erreur visible dans les 2 logs, il peut être intéressant de voir ce qui s'affiche dans moonraker.log quand on essaye de lancer mainsail/fluidd,
pour cela, on peut demander au pi d'afficher les changements du fichier avec `tail -f /tmp/moonraker.log` puis dans le browser, utiliser F5 pour rafraichier moonraker/fluidd. S'il y a des messages 404, c'est qu'il y a un problème d'accès, la solution est soit le changement du 4 mars cité au-dessus ou changer les paramètres d'accès dans moonraker.conf.


## J'ai chargé mon gcode et j'ai un message d'erreur au début de l'impression

Le problème le plus typique est un mauvais réglage du PRINT_START ou des variables associées, soit au niveau de la macro, soit au niveau de la config du gcode de démarrage dans le slicer.

# Demander de l'aide sur le discord

Il est plus facile de répondre si on a ces informations:
* Si problème avec klipper:
  * le retour de `ls /dev/serial/by-id/`
  * la version de klipper: depuis le dossider de klipper (`cd ~/klipper`): `git rev-parse --short HEAD`
  * printer.cfg
  * klippy.log
* Si problème avec l'interface web:
  * les fichiers en cas de problème avec klipper
  * la version de moonraker: depuis le dossider de moonraker (`cd ~/moonraker`): `git rev-parse --short HEAD`
  * moonraker.log
