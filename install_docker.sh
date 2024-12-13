#!/bin/bash

# Liste des serveurs
SERVERS=("user@serveur1" "user@serveur2" "user@serveur3")

for SERVER in "${SERVERS[@]}"; do
    echo "Installation de Docker sur $SERVER..."

    ssh "$SERVER" << 'ENDSSH'
        # Mettre à jour les paquets
        sudo apt update

        # Installer les dépendances
        sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

        # Ajouter la clé GPG de Docker
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

        # Ajouter le dépôt de Docker
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

        # Mettre à jour les paquets à nouveau
        sudo apt update


        sudo apt install docker-ce -y

        # Démarrer Docker et activer le service
        sudo systemctl start docker
        sudo systemctl enable docker

        echo "Docker a été installé sur $SERVER."
ENDSSH
done