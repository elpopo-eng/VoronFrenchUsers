

1 Concept of ZeroTier:
Zero Tier is a Zero Trust low configuration stackable VPN. It allow remote connection to system without the pain of setting up a VPN tunnel, since it rely on zero trust the client have to join the network, then an admin have to approve the connection, afterwards client could access any port of the systems in the same network.
https://www.zerotier.com/ 

2 Account and network creation:
Go to https://accounts.zerotier.com/auth/realms/zerotier/protocol/openid-connect/registrations?client_id=zt-central&redirect_uri=https%3A%2F%2Fmy.zerotier.com%2Fapi%2F_auth%2Foidc%2Fcallback&response_type=code&scope=all&state=state

Create an account and then in the account control panel do the following go to create a private network on the top left side of the window
https://www.stratospherix.com/img/guides/vpn/vpnsetup_01.jpg 


detailled steps here : https://www.stratospherix.com/support/setupvpn_01.php


Dully note the ip range in ipv4 auto sign part, here i will use : 192.168.193.* (will be used to whitelist this in moonraker if needed) and also the network name 

https://www.stratospherix.com/img/guides/vpn/vpnsetup_04.jpg

Done

3 install on the pi:
*curl -s https://install.zerotier.com | sudo bash*

4: Join the previous network from the pi:
From the command line simply type *sudo zerotier-cli join* ################ with ############### being the 16-digit network ID of the network you wish to join.

5: install on pc mac, linux or iphone to access remotely the printer. then join the same network as above to have your phone and voron in the same network

6: how to access :
From the client (here a mobile phone) type in the URL adress bar the ip of your zerotier voron that you can see in your zerotier management console, if it does not work endite moonraker.conf to allow the zerotier iprange (192.168.193.0/24 in our example)


1 Concept of ZeroTier:
Zero Tier is a Zero Trust low configuration stackable VPN. It allow remote connection to system without the pain of setting up a VPN tunnel, since it rely on zero trust the client have to join the network, then an admin have to approve the connection, afterwards client could access any port of the systems in the same network.
https://www.zerotier.com/ 

2 Account and network creation:
Go to https://accounts.zerotier.com/auth/realms/zerotier/protocol/openid-connect/registrations?client_id=zt-central&redirect_uri=https%3A%2F%2Fmy.zerotier.com%2Fapi%2F_auth%2Foidc%2Fcallback&response_type=code&scope=all&state=state

Create an account and then in the account control panel do the following go to create a private network on the top left side of the window
https://www.stratospherix.com/img/guides/vpn/vpnsetup_01.jpg 


detailled steps here : https://www.stratospherix.com/support/setupvpn_01.php


Dully note the ip range in ipv4 auto sign part, here i will use : 192.168.193.* (will be used to whitelist this in moonraker if needed) and also the network name 

https://www.stratospherix.com/img/guides/vpn/vpnsetup_04.jpg

Done

3 install on the pi:
curl -s https://install.zerotier.com | sudo bash

4: Join the previous network from the pi:
From the command line simply type zerotier-cli join ################ with ############### being the 16-digit network ID of the network you wish to join.

5: install on pc mac, linux or iphone to access remotely the printer. then join the same network as above to have your phone and voron in the same network

6: how to access :
From the client (here a mobile phone) type in the URL adress bar the ip of your zerotier voron that you can see in your zerotier management console, if it does not work endite moonraker.conf to allow the zerotier iprange (192.168.193.0/24 in our example)
