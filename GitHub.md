## Instalació i utilització Git /Github


1.  Instalar Git:
>sudo apt-get update
>sudo apt-get install git

* Configurar nom i correu 
>git config --global user.name “Nom”
>git config --global user.email “Correu”

* Comprovem dades
>git config –list

2. Nou compte [GitHub](https://github.com) 
	


3. Combinem Git - Github
* Creem repositori a Github
* Creem copia local del repositori
	* OPCIO A (quan encara no hem inclos res) 
	>mkdir /nomRepo

	>cd nomRepo
	
	>git init 
	
	>git remote add origin https://github.com/UsuariGithub/nomRepo.git
	
	* OPCIO B ( clonar un repositori del GitHub)
	>git clone https://github.com/UsuariGithub/nomRepo.git

	>git init 

* Afegirm arxius a repositori local I volem actualitzar-ho (SEMPRE 3 PASOS)
	> git add .  (afegeix tots els arxius nous)  /   -u (actualitza fitxer que han cambiat de nom o eliminats) / -A  (fa totes dues coses)
	* Fem un commit
	>git commit -m “missatge”
	* Ho actualitzem a github
	>git push -u origin master
* Afegir arxiu en github i que es mostri en local
> git pull –rebase

* Afegir branca 
 	>git checkout -b branchmimi 
	* Veure en quina branca estem
	>git branch
	* Actualitzar branca al github
	>git push origin branchmimi
	* Canviar de branca 
	> git checkout master


* Desfer de git init
rm -rf .git

**Una carpeta nova no la agafa be si no hi ha cap document dins**
