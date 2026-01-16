# $`\textcolor{teal}{\texttt{Patch}}`$  
  
Usefully patch for [**BRGV-OS**](https://github.com/florintanasa/brgvos-void)  

### $`\textcolor{teal}{\texttt{set\_pt\_BR\_gnome.sh}}`$  
  
This script add modification for user what use Portuguese (Brazil) language, add default keyboard `br` and add some 
packages for localize.  
With modification can be used for any language.  
  
Translate:  

|     English     |       Portuguese       |
|:---------------:|:----------------------:|
| Themes settings | Configurações de temas |
|     Office      |       Escritório       |
|    Graphics     |        Gráficos        |
|   Programming   |      Programação       |
|   Accessories   |       Acessórios       |
|     System      |        Sistema         |
|    Internet     |        Internet        |
|   Multimedia    |       Multimídia       |

Packages:

* firefox-i18n-pt-BR
* libreoffice-i18n-pt-BR
* mythes-pt_BR
* hyphen-pt_BR
* manpages-pt-br
* hunspell-pt_BR
  
> [!NOTE]   
> If the package is already installed give error message with the "package already installed", these are not a problem.  
  
**Require**  
  
Is necessary to have installed [**BRGV-OS**](https://github.com/florintanasa/brgvos-void) in Portuguese (Brazil) 
Language, from English image ISO, like @LinuXpert in next video review.  
  
[<img src="https://img.youtube.com/vi/T-d6V8p3Qc0/maxresdefault.jpg" width="960" height="510"/>](https://www.youtube.com/embed/T-d6V8p3Qc0?autoplay=1&mute=1)
  
**Usage** 
  
```bash
wget https://github.com/florintanasa/utils/raw/refs/heads/main/patch/set_pt_BR_gnome.sh
chmod +x set_pt_BR_gnome.sh
sudo mv set_pt_BR_gnome.sh /usr/local/bin/ # to be used by all users
set_pt_BR_gnome.sh --help # for more info 
```  

The last command display next info help messages:
```text
Run the script for current user, only for parameters '2', '4' or '--help'
Usage:
  ./set_pt_BR_gnome.sh [PARAMETER]

Description:
  This script add modify for Portuguese (Brazilian) language, from English to Portuguese (Brazilian), in dconf for all new users and/or actual user
  Also, set as keyboard 'br' and install some localized packages xbps.
  If a the user provide an ARGUMENT, like '1' or '2' or '1 2' this script is run directly
  If a the user not provide an ARGUMENT appear a menu with some options.

Options:
     With PARAMETER     Modify for Portuguese (Brazilian) language, for all new user or actual user.
  Without PARAMETER     Is open a options menu with next options:
  Option 1 - Modify for Portuguese (Brazilian) language, from English to Portuguese (Brazilian), in dconf for
             all new users, add 'br' keyboard and add additional packages for localized language.
  Option 2 - Modify for Portuguese (Brazilian) language, from English to Portuguese (Brazilian), in dconf for
             current user, add 'br' keyboard and add additional packages for localized language.
  Option 3 - Modify for Portuguese (Brazilian) language, from English to Portuguese (Brazilian), in dconf for
             all new users and current user, add 'br' keyboard and add additional packages for localized language.
  Option 4 - Modify for English language, from Portuguese (Brazilian) to English, in dconf for
             all new users, set 'us' default keyboard and 'br' secondary keyboard.
  Option 5 - Enable Portuguese (Brazilian) language in libc-locales and install additional packages for localized language.
  Option 6 - Modify for English language, from Portuguese (Brazilian) to English, in dconf for
             current user, set 'us' default keyboard and 'br' secondary keyboard.
  Option 7 - Modify for English language, from Portuguese (Brazilian) to English, in dconf for
             all new users and current user, set 'us' default keyboard and 'br' secondary keyboard.
  Option 8 - Exit from script.

Examples:
  sudo set_pt_BR_gnome.sh 1             # Option 1
  sudo set_pt_BR_gnome.sh 2             # Option 2
  set_pt_BR_gnome.sh 2                  # Option 2, can be run by current user, but without to install the packages
  sudo set_pt_BR_gnome.sh 1 2           # Option 3
  sudo set_pt_BR_gnome.sh 2 1           # Option 3
  sudo set_pt_BR_gnome.sh 3             # Option 4
  sudo set_pt_BR_gnome.sh 4             # Option 6
  set_pt_BR_gnome.sh 4                  # Option 6, can be run by current user
  sudo set_pt_BR_gnome.sh 5             # Option 5
  sudo set_pt_BR_gnome.sh 3 4           # Option 7
  sudo set_pt_BR_gnome.sh 4 3           # Option 7
  sudo set_pt_BR_gnome.sh$              # Use the menu to choose an option
  set_pt_BR_gnome.sh --help or -h       # This help.
```
In the following video, you found how to use the patches and another example of how to install [**BRGV-OS**](https://github.com/florintanasa/brgvos-void)

[<img src="https://img.youtube.com/vi/pN8bdZ6Hw88/maxresdefault.jpg" width="960" height="510"/>](https://www.youtube.com/embed/pN8bdZ6Hw88?autoplay=1&mute=1)

### $`\textcolor{teal}{\texttt{set\_distro.sh}}`$
This script add modification at os-release and lsb_release file for [**BRGV-OS**](https://github.com/florintanasa/brgvos-void).
  
**Require**  
  
To have installed [**BRGV-OS**](https://github.com/florintanasa/brgvos-void) with `base-files` version >= 0.146_1

**Usage**
  
```bash
wget https://github.com/florintanasa/utils/raw/refs/heads/main/patch/set_distro.sh
chmod +x set_distro.sh
set_distro.sh --help
```
