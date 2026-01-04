# $\textcolor{teal}{Patch}$
Usefully patch for **BRGV-OS**  
### $\textcolor{teal}{"set\_pt\_gnome.sh"}$
This script add modification for user what use Portuguese (Brazil) language and add some packages for localize.  
Translate:  

|     English     |       Portuguese       |
|:---------------:|:----------------------:|
| Themes settings | Configurações de temas |
|     Office      |       Escritório       |
|    Graphics     |        Gráficos        |
|   Programming   |      Programação       |
|   Accessories   |       Acessórios       |
|     System      |        Sistema         |

Packages:

* firefox-i18n-pt-BR
* libreoffice-i18n-pt-BR
* mythes-pt_BR
* hyphen-pt_BR
* manpages-pt-br
* hunspell-pt_BR
> [!NOTE]   
> If the package is already installed give error message with the "package already installed"  
> Is not a big problem.  

**Usage** 
```bash
wget https://github.com/florintanasa/utils/raw/refs/heads/main/patch/set_pt_gnome.sh
chmod +x set_pt_gnome.sh
sudo ./set_pt_gnome.sh
```  
  
### $\textcolor{teal}{set\_distro.sh}$
This script add modification at os-release and lsb_release file for **BRGV-OS**  
**Usage**
```bash
wget https://github.com/florintanasa/utils/raw/refs/heads/main/patch/set_distro.sh
chmod +x set_distro.sh
sudo ./set_distro.sh
```

