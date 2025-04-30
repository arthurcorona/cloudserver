<p align="center">
<img src="https://uploaddeimagens.com.br/images/003/361/136/original/placeholder.jpg">
</p>
<p align="center">
<h3 align="center">Como ter sua própria nuvem de hospedagem de arquivos</h3>
<p align="center">
  Um guia passo a passo para criar seu próprio servidor de nuvem em casa, usando Nextcloud e Docker sem depender de serviços de big techs como Google Drive ou Dropbox!
</p>

## 🚀 Por que fazer isso?  
- Ter **controle total** sobre seus arquivos, uma vez que não irão depender de nenhuma big tech.  
- Acesso remoto seguro aos seus dados.  
- Personalização com plugins.
- Economia a longo prazo (sem taxas de assinatura).  

<p align="center">
  <a href="https://github.com/arthurcorona">
    <img alt="Corona" width="25" src="./images/logo_github.png">
  </a>
</p>
<p align="center">

	
   <a href="https://www.linkedin.com/in/arthur-corona-32a155216/">
    <img alt="LinkedIn" width="25" src="https://github.com/Universidade-Livre/imagens/blob/main/png/linkedin.png">
  </a>
	
  <a href="https://www.x.com/iamarthurcorona">
    <img alt="LinkedIn" width="25" src="./images/logo_x.png">
  </a>
</p>

## 📋 Pré-requisitos  
- Um computador/servidor (eu utilizo um Raspberry PI 4).  
- Docker e Docker Compose instalados.
- Domínio (não é obrigatório, mas é recomendado para ativar o SSL).  

## 🛠️ Passo a Passo  

### 1. Instalar Docker e Docker Compose  
```bash
# Exemplo para Ubuntu:
sudo apt update && sudo apt install docker docker-compose -y
sudo systemctl enable --now docker
```

### 3. Criar as pastas do Nextcloud 
```bash
sudo mkdir external_drive
cd external_drive
sudo mkdir nextcloud apps config data theme 
```
### 2. Criar os arquivos do nextcloud
```bash

```
 
### Rodar o docker

```bash
sudo docker run -d -p 90:90 --name nextcloud --restart unless-stopped \
-v /external_drive/nextcloud:/var/www/html \
-v /external_drive/apps:/var/www/html/custom_apps \
-v /external_drive/config:/var/www/html/config \
-v /external_drive/data:/var/www/html/data \
-v /external_drive/theme:/var/www/html/themes \
nextcloud
```

### Incrementar segurança: 

Adicionando um certificado SSL: 
Necessário ter um domínio, por exemplo: google.com.br (É possível comprar pelo registro.br)
Necessário instalar o Nginx e o Certbot

```bash 
sudo apt update
sudo apt install nginx certbot python3-certbot-nginx
```
Criar um arquivo novo :
```bash
sudo nano /etc/nginx/sites-available/nextcloud

# e adicionar: 
server {
#obs: ip e dominio de exemplo por questões de segurança.
    listen 80;
    server_name nuvem.seudominio.com;

    location / {
        proxy_pass http://111.1.1.1:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
Após isso, ative e teste o site:
```bash
sudo ln -s /etc/nginx/sites-available/nextcloud /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

```bash
sudo certbot --nginx -d nuvem.seudominio.com
```

