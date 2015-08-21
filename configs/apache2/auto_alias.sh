 ## Mas Proyectos?, crealos en este array, formato <dominio>:<carpeta-publica>
 #DOMAINS=('local.urbania.ec:src/public')
 ## Loop through all sites

. /domains.sh

 for elt in "${DOMAINS[@]}";
 do
	IFS=: read DOMAIN DIRWEB <<< $elt
	echo "$DOMAIN*$DIRWEB"
	echo "Creando un directorio publico para $DOMAIN. Directorio: $DIRWEB"
	mkdir -p /var/www/$DOMAIN/$DIRWEB
	echo "Creando configuracion vhost para $DOMAIN"
	cp /etc/apache2/sites-available/albatros.local.conf /etc/apache2/sites-available/$DOMAIN.conf
	echo "Actualizando vhost para $DOMAIN"
	sed -i s,albatros.local,$DOMAIN,g /etc/apache2/sites-available/$DOMAIN.conf
	sed -i s,/var/www,/var/www/$DOMAIN/$DIRWEB,g /etc/apache2/sites-available/$DOMAIN.conf
	echo "Enabling $DOMAIN"
	a2ensite $DOMAIN.conf
	echo "Restart Apache Now"
	service apache2 restart
    done

