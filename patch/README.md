# $`\textcolor{teal}{\texttt{Patch}}`$
Usefully patch for [**BRGV-OS**](https://github.com/florintanasa/brgvos-void)  
### $`\textcolor{teal}{\texttt{set\_pt\_gnome.sh}}`$
This script add modification for user what use Portuguese (Brazil) language, add default keyboard 'br' and add some 
packages for localize.  
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
  
**Request**  
Is necessary to have installed [**BRGV-OS**](https://github.com/florintanasa/brgvos-void) in Portuguese (Brazil) 
Language, from English image ISO, like @LinuXpert in next video review.  
  
[<img src="https://img.youtube.com/vi/T-d6V8p3Qc0/maxresdefault.jpg" width="960" height="510"/>](https://www.youtube.com/embed/T-d6V8p3Qc0?autoplay=1&mute=1)
  
**Usage** 
```bash
wget https://github.com/florintanasa/utils/raw/refs/heads/main/patch/set_pt_gnome.sh
chmod +x set_pt_gnome.sh
sudo ./set_pt_gnome.sh
```  
  
### $`\textcolor{teal}{\texttt{set\_distro.sh}}`$
This script add modification at os-release and lsb_release file for [**BRGV-OS**](https://github.com/florintanasa/brgvos-void)  
**Usage**
```bash
wget https://github.com/florintanasa/utils/raw/refs/heads/main/patch/set_distro.sh
chmod +x set_distro.sh
sudo ./set_distro.sh
```

