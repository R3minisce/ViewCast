
# Envoi

| Description | Event | Data |
| --- |--- | --- |  
| Ecouter flux tv| register | {display_id:""} |  
| Ecouter flux dashboard| register dashboard| - |  
| Déconnexion|logout| - |  

# Réception

| Description | Event | Data |
| --- |--- | --- |  
| Afficher image | load file | {stream_id, file_id, timer, dashboard} |  

Si file_id ou timer est null -> sleep mode

Timer -> temps d'attente maximum avant la prochaine image. Se mettre en sleep mode si timer (+ durée tampon) dépassé et aucun message reçu