## Instalació i utilització Git /Github


1.  Instalar [Git](https://git-scm.com/book/es/v1/Empezando-Instalando-Git):
```
sudo apt-get update
sudo apt-get install git
```

  * Configurar nom i correu 
```
  git config --global user.name “Nom”
  git config --global user.email “Correu”
```
  * Comprovem dades
```
 git config –list
```
<br>


2. Nou compte [GitHub](https://github.com) 

<br>

3. Combinem Git - Github
* Creem repositori a Github
* Creem copia local del repositori
	* OPCIO A (quan encara no hem inclos res) 
	```
	mkdir /nomRepo
	cd nomRepo
	git init 
	git remote add origin https://github.com/UsuariGithub/nomRepo.git
	```
	* OPCIO B ( clonar un repositori del GitHub)
	```
	git clone https://github.com/UsuariGithub/nomRepo.git
	git init 
	```
	
<br>

* Actualitzar canvis fets en local a GitHub (SEMPRE 3 PASOS)
    1. Afegim o modifiquem arxiu
    ```
    git add . (afegeix tots els arxius nous)
              -u ( actualitza fitxers que han canviat de nom o eliminats)
              -A (fa totes dues coses)
    ```
    2. Fem un commit
    ```
    git commit -m "missatge de canvis"
    ```
    3. Ho actualitzem a github
    ```
    git push 
    o
    git push -u origin master
    ```
    
<br>
	
* Actualitzar canvis fets en GitHub a local
  ```   git pull –rebase   ```
  
  <br>
  
* Afegir branca 
 	```  	git checkout -b branchmimi  	```
	* Veure en quina branca estem
	``` 	git branch 	```
	* Actualitzar branca al github
	``` 	git push origin branchmimi 	```
	* Canviar de branca 
  ```   git checkout master   ```

<br>

* Desfer un git init
```rm -rf .git```

<br>

**Una carpeta nova no la agafa be si no hi ha cap document dins**
