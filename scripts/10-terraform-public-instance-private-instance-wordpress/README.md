# demo terraform #9 - aws 2 instances in public/private network  

## LAB SENSE intervenció manual - pendent de resoldre el domini (no generarà el certificat)

1) crear la infraestructura
1.1) renomenar terraform.tfvars-sample a terraform.tfvars
```
mv terraform.tfvars{-sample,}
```
1.2) descarregar els providers
```
terraform init
```
1.3) generar el plan de desplegament
```
terraform plan -out=wordpress2capes
```
1.4) desplegar el plan
```
terraform apply wordpress2capes
```

2) crear el domini (subdomini) i associar-li la ip pública
2.1) a duckdns/noip/exitdns/dynu 
registre A al domini amb la ip pública  
3) preparar la configuració del dos servidors  
3.1) canviar script del servidor de bbdd (back-end): silent-install-private-instance.sh  
IMPORTANT  
assignar la ip del front-end (10.0.1.X) a WORDPRESS_HOST (des d'on acceptarà connexions)  
canviar el nom del domini WORDPRESS_DOMAIN al nom del domini que acabem de crear  
3.2) canviar script del servidor web (front-end): silent-install-public-instance.sh  
assignar la ip del BACK-END!! a WORDPRESS-HOST (on crearem/consultarem la informació)  
canviar el nom del domini WORDPRESS_DOMAIN al nom del domini que acabem de crear  
canviar el nom del compte de correu per possibilitar que certbot funcione de manera no interactiva  
4) desplegar els scripts   
4.1) incorporar la clau generada al agent ssh i comprovar-ho (apareixerà l'eqiqueta del nom de la clau)  
```
eval `ssh-agent`
ssh-add demo-wordpress.pem
ssh-add -L
```
4.2) desplegar l'script del servidor de bbdd - accedim al back-end a través del servidor web
```
cat silent-install-private-instance.sh | ssh -t -J ubuntu@ip-publica-front-end ubuntu@ip-privada-back-end-10-0-2-X sudo bash
```
4.3) desplegar l'script del servidor web - accedim al front-end directament
```
cat silent-install-public-instance.sh | ssh -t  ubuntu@ip-publica-front-end  sudo bash
```
5) accedir amb el navegador web a el nom del domini (WORDPRESS_DOMAIN)

