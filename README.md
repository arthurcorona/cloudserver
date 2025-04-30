
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
    <img alt="x" width="25" src="./images/logo_x.png">
  </a>
</p>

## 📋 Pré-requisitos  
- Uma máquina para utilizar de servidor (eu utilizo um Raspberry PI 4).  
- Docker e Docker Compose instalados.
- Domínio (não é obrigatório, mas é recomendado para ativar o SSL).  

## 🛠️ Passo a Passo  

### 1. Instalar Docker e Docker Compose  
```bash
sudo apt update && sudo apt install docker docker-compose -y
sudo systemctl enable --now docker
```

### 3. Criar as pastas do Nextcloud 
```bash
sudo mkdir external_drive
cd external_drive
sudo mkdir nextcloud apps config data theme 
```
### 2. Criar os arquivos do nextcloud (Recomendado)

### Arquivos: Dockerfile.app; nginx.conf; setup-nextcloud.sh; db.env; docker-compose.yml 
Lembrando que os arquivos não são totalmente necessários, entretanto, todos possuem uma função importante.
O <a href="https://docs.docker.com/compose/">docker-compose</a> melhora a organização e manutenção, sendo um arquivo de orquestração.
O db.env organiza melhor as informações sensíveis.
O <a href="https://www.f5.com/go/product/welcome-to-nginx">Nginx</a> é um arquivo para a configuração do proxy reverso, para aumentar a segurança.
O Dockerfile é um arquivo para customizar o container do nextcloud.

Caso queira instalar eles, apenas faça o download dos no diretório do github e faça as alterações necessárias para você. 
Coloquei informações de exemplo, para evitar vazar dados sensíveis.
 
### Rodar o docker

```bash
# O comando -p 80:80 está mapeando a porta 80 do container pra porta 80 do pc
sudo docker run -d -p 80:80 --name nextcloud --restart unless-stopped \
-v /external_drive/nextcloud:/var/www/html \
-v /external_drive/apps:/var/www/html/custom_apps \
-v /external_drive/config:/var/www/html/config \
-v /external_drive/data:/var/www/html/data \
-v /external_drive/theme:/var/www/html/themes \
nextcloud
```

### Incrementando segurança: 

Para adicionar um certificado SSL: 
Necessário ter um domínio, por exemplo: google.com.br (É possível comprar pelo registro.br)
Necessário instalar o Nginx e o Certbot para fazer proxy reverso.

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
Para obter o certificado SSL com Let´s Encrypt, use: 
```bash
sudo certbot --nginx -d nuvem.seudominio.com
```
Após isso, teste seu domínio no navegador.



