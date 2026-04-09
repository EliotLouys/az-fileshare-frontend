# COMPLEMENT TECHNIQUE

## Schéma d'architecture sécurisée

![Schéma](./docs/archi_secu.png)

### Pourquoi App Gateway et pas Load Balancer ?

Le Load Balancer n'interprète pas le trafic HTTP.
Il ne peut pas bloquer une attaque par injection SQL ou gérer des certificats SSL.
L'Application Gateway centralise la gestion de la sécurité du trafic web et offre une visibilité totale sur les menaces. Celle-ci est donc nécessaire à la sécurité de l'application.

## Tests de charge

## Estimation des coûts additionnels

Une application Gateway avec WAFv2 consomme ~0.42€ par heure.
Cela s'accumule à ~302€ par mois si activé constamment. C'est une ressource qui augmente largement la sécurité de l'application, mais qui est onéreuse.
