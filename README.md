<p align="center">
<img src="https://uploaddeimagens.com.br/images/003/361/136/original/placeholder.jpg">
</p>
<p align="center">
<h3 align="center">Como ter sua própria nuvem de hospedagem de arquivos</h3>
<p align="center">
  Um guia passo a passo para criar seu próprio servidor de nuvem em casa, usando **Nextcloud** e **Docker** sem depender de serviços de big techs como Google Drive ou Dropbox!
</p>

## 🚀 Por que fazer isso?  
- Ter **controle total** sobre seus arquivos, uma vez que não irão depender de nenhuma big tech.  
- Acesso remoto seguro aos seus dados.  
- Personalização com plugins.
- Economia a longo prazo (sem taxas de assinatura).  

<p align="center">
  <a href="https://github.com/arthurcorona">
    <img alt="Corona" src="./images/logo_github.png">
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

 ### 2. Criar os arquivos do nextcloud

    
