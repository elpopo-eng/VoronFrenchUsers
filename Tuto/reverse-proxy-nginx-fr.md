# Accès à distance par reverse proxy NGINX

## Préambule

Ce guide détaille les étapes nécessaires à la mise en place d'un reverse proxy NGINX, de Certbot, et de Basic Auth pour permettre un accès à distance à une imprimante sous Mainsail, le tout sécurisé par mot de passe et chiffrement TLS.

Il deviens ainsi possible de contrôler son imprimante en se connectant sur `https://mainsail.domaine.tld` depuis n'importe quel navigateur récent.

## Prérequis à l'installation

1. Une imprimante 3D fonctionnant sous Mainsail
2. Un nom de domaine
3. Un serveur pour agir comme reverse proxy
4. Une IPv4 full stack, ou une plage de ports contenant `80` et `443`
5. Un routeur capable d'ouvrir les ports `80` et `443`

**Note:** Ce guide suppose une installation MainsailOS sur l'imprimante, et Debian ou dérivé sur le serveur reverse proxy.

**Note 2:** Si vous n'avez pas de serveur sous la main, il est possible de lancer un conteneur (Docker/LXD) depuis le Raspberry Pi de votre imprimante.

**Note 3:** La demande d'IPv4 full stack peut se faire au près de votre FAI.

## 1. Entrées DNS

Il est nécessaire de créer une entrée DNS de type `A` ou `CNAME` dédiée au sous-domaine que vous utiliserez. Ici, je choisi de créer un A record destiné au sous-domaine `voron` pour mon domaine `chelseaestcool.fr` enregistré auprès de Gandi:

```
@ 10800 IN A 10.13.37.42     # Remplacer par votre IPv4 :)
voron 10800 IN A 10.13.37.42
```

**Note:** Référez-vous à la documentation de votre registrar pour plus d'information sur la modification de vos entrées DNS.

## 2. Ouverture des ports sur votre routeur

Vous devez maintenant rediriger les ports TCP `80` et `443` de votre routeur sur l'addresse IP de votre réseau local qui sera servie par votre reverse proxy NGINX.

Dans mon cas, mon reverse proxy fonctionne sur un serveur dédié, servant l'IP `192.168.1.1`. Mon imprimante, elle, se voit attribuée l'IP `192.168.1.42`. Je redirige donc les ports TCP `80` et `443` sur `192.168.1.1`

Le port `80` n'est ici pas utilisé pour un traffic HTTP, mais pour un challenge certbot nous permettant de récupérer un certificat X.509 de Let's Encrypt. Il pourra être refermé après l'obtention du certificat, mais devra être ouvert tout les 3 mois pour permettre le renouvellement de celui-ci.

**Note:** Référez-vous à la documentation de votre routeur si vous avez besoin de plus d'informations sur la redirection de ports.


## 3. Installation de NGINX

NGINX est un serveur web, que nous configurerons en tant que reverse proxy. Il agira comme intermédiaire entre nous et l'imprimante.

**Note:** l'usage de Debian est présupposé.

Installez NGINX via le gestionnaire de paquets `apt` en utilisant les commandes suivantes :
`$ sudo apt update`
`$ sudo apt install nginx`

Activez et démarrez l'unité systemd pour que NGINX se lance automatiquement au démarrage:

`$ sudo systemctl enable nginx.service`
`$ sudo systemctl start nginx.service`

Confirmez le bon fonctionnement de NGINX en vous connectant depuis votre navigateur Internet à sa page web de test via l'addresse de votre imprimante, port 80. Dans mon cas:

`http://192.168.1.1:80`

## 4. Configuration de NGINX comme reverse proxy

Naviguez dans le dossier NGINX:

`$ cd /etc/nginx`

Supprimez les fichiers de configuration existants de NGINX:

`$ sudo rm -rf sites-enabled/*`

Créez un fichier de configuration pour votre nom de domaine. Dans mon cas il s'agit de `chelseaestcool.fr`

`$ sudo touch sites-enabled/chelseaestcool.fr`

Modifiez ce fichier avec votre éditeur de texte préféré (j'utilise `vim`) en prenant soin de remplacer les addresses IP par celle de votre imprimante:

```
server {
	server_name chelseaestcool.fr;                            #### ATTENTION ICI ! METTEZ VOTRE DOMAINE.
	return 301 http://voron.chelseaestcool.fr$request_uri;    #### ATTENTION ICI ! METTEZ VOTRE SOUS-DOMAINE.

server {
    server_name voron.chelseaestcool.fr;                      #### ATTENTION ICI ! METTEZ VOTRE SOUS-DOMAINE.

    client_max_body_size 0;
    proxy_request_buffering off;

    location / {
    auth_basic "Secured area";
          auth_basic_user_file .htpasswd;
          proxy_redirect off;
          proxy_pass http://192.168.1.42:80;                  #### ATTENTION ICI ! METTEZ L'IP DE VOTRE IMPRIMANTE.
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection $connection_upgrade;
          proxy_buffering off;
          client_max_body_size 0;
          proxy_connect_timeout  3600s;
          proxy_read_timeout  3600s;
          proxy_send_timeout  3600s;
          send_timeout  3600s;
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Forwarded-Host $http_host;
    }

    location /websocket {
          auth_basic "Secured area";
          auth_basic_user_file .htpasswd;
          proxy_set_header Authorization "";
          proxy_pass http://apiserver/websocket;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection $connection_upgrade;
          proxy_set_header Host $http_host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_read_timeout 86400;
        }

    location ~ ^/(printer|api|access|machine|server)/ {
          auth_basic "Secured area";
          auth_basic_user_file .htpasswd;
          proxy_pass http://apiserver$request_uri;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Host $http_host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Scheme $scheme;
    }

    location /webcam/ {
          auth_basic "Secured area";
          auth_basic_user_file .htpasswd;
          postpone_output 0;
          proxy_buffering off;
          proxy_ignore_headers X-Accel-Buffering;
          access_log off;
          error_log off;
          proxy_pass http://mjpgstreamer1/;
    }

    location /webcam2/ {
          auth_basic "Secured area";
          auth_basic_user_file .htpasswd;
          postpone_output 0;
          proxy_buffering off;
          proxy_ignore_headers X-Accel-Buffering;
          access_log off;
          error_log off;
          proxy_pass http://mjpgstreamer2/;
    }

    location /webcam3/ {
          auth_basic "Secured area";
          auth_basic_user_file .htpasswd;
          postpone_output 0;
          proxy_buffering off;
          proxy_ignore_headers X-Accel-Buffering;
          access_log off;
          error_log off;
          proxy_pass http://mjpgstreamer3/;
    }

    location /webcam4/ {
          auth_basic "Secured area";
          auth_basic_user_file .htpasswd;
          postpone_output 0;
          proxy_buffering off;
          proxy_ignore_headers X-Accel-Buffering;
          access_log off;
          error_log off;
          proxy_pass http://mjpgstreamer4/;
    }
}
```

Créez le fichier `conf.d/common_vars.conf` et modifiez-le:

```
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}
```

Créez le fichier `conf.d/upstream_voron.conf` et modifiez-le en prenant soin de remplacer les addresses IP par celle de votre imprimante:

```
upstream apiserver {
    ip_hash;
    server 192.168.1.42:7125;
}

upstream mjpgstreamer1 {
    ip_hash;
    server 192.168.1.42:8080;
}

upstream mjpgstreamer2 {
    ip_hash;
    server 192.168.1.42:8081;
}

upstream mjpgstreamer3 {
    ip_hash;
    server 192.168.1.42:8082;
}

upstream mjpgstreamer4 {
    ip_hash;
    server 192.168.1.42:8083;
}
```

## 5. Authentification par mot de passe

NGINX propose une fonctionalité nommée `basic_auth` permettant de forcer l'utilisateur à s'authentifier avant de pouvoir se connecter sur une page web. L'usage de cette fonctionnalité a déjà été spécifié dans la configuration à l'étape précédente, nous devons maintenant créer un fichier sur notre reverse proxy afin de l'utiliser.

Installez le paquet `apache2-utils`:

`$ sudo apt install apache2-utils`

Créez un fichier dit `htpasswd` avec le nom d'utilisateur que vous utiliserez pour vous connecter:

```
$ sudo htpasswd -c /etc/nginx/.htpasswd Chelsea
```

Le fichier `/etc/nginx/.htpasswd` sera créé. Il ne contient pas votre mot de passe, seulement un condensat de ce dernier. Il n'existe pas, à l'heure actuelle, de méthodes permettant de retrouver votre mot de passe à partir de ce condensat.

Redémarrez votre serveur NGINX:

`$ sudo systemctl restart nginx`

**Note:** *Faites pas les cons*, mettez un bon mot de passe, on parle d'une machine qui peut déclencher un indendie.

## 6. Activation du HTTPS

Un tunel TLS est une forme de chiffrement qui permet de communiquer de manière sécurisée avec une machine. Lorsqu'un tunel TLS est présent, les données échangées sont chiffrée.

Les données échangées avec notre imprimante sont sensibles. Nous configurerons donc NGINX pour utiliser un tunnel TLS, et de rediriger tout traffic sans tunel TLS vers le trafic sous tunel.

Nous utilisons l'outil `certbot` pour récupérer un certificat X.509 de chez Let's Encrypt. Ce certification attestera de l'authenticité de notre serveur et permettra la négociation d'un tunel TLS dit "de confiance".

Installez `certbot` et ses dépendances :

```
$ sudo apt install software-properties-common  
$sudo add-apt-repository universe  
$ sudo add-apt-repository ppa:certbot/certbot  
$ sudo apt update  
$ sudo apt install certbot python-certbot-nginx
```

Récupérez le certificat pour votre domaine et sous-domaine:

`$ sudo certbot --nginx -d chelseaestcool.fr -d voron.chelsea486mhz.fr`

## 7. C'est fini !

Votre imprimante devrais maintenant être accessible sur l'URL `https://voron.chelseaestcool.fr`.
