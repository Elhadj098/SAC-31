#  SAC31 - Liaison Série Inter-Systèmes (Arduino & Raspberry Pi)

Ce projet réalise une chaîne complète d'acquisition, de supervision et de commande distribuée entre trois unités de traitement. Il met en œuvre des protocoles de communication série (UART) et I2C, ainsi que l'adaptation de niveaux logiques entre des systèmes 3.3V et 5V.

**Université Haute-Alsace (UHA) - Licence 2 EEA**

---

## Auteurs
* **Elhadji FALL**
* **Aliou DIALLO**
* **Mame Diarra FALL**

**Professeur :** M. Abderazik BIROUCHE


---

##  Architecture du Système

Le système est composé de trois blocs interconnectés :

1.  **Bloc Acquisition (Arduino Uno) :** Lit l'état de deux boutons poussoirs et transmet l'information.
2.  **Bloc Supervision (Raspberry Pi) :** Reçoit les données, affiche l'état sur un écran LCD Grove (I2C) et relaye la commande.
3.  **Bloc Effecteur (Arduino Uno) :** Reçoit la commande du Raspberry et pilote des LEDs.

![Schéma Électrique](schema_electrique.png)

---

##  Matériel Requis

* 2x Arduino Uno
* 1x Raspberry Pi (3 ou 4)
* 1x Écran LCD Grove RGB (I2C)
* 2x Boutons poussoirs
* 2x LEDs (Rouge, Verte)
* **Composants d'adaptation :**
    * Résistances : 220Ω (LEDs), 200Ω & 300Ω (Pont diviseur), 10kΩ (Pull-up).
    * Transistor NPN (adaptation de niveau).

---

##  Fonctionnement Logique

Le Raspberry Pi agit comme un "Hub". Voici la table de vérité du système :

| Boutons (Arduino 1) | Code Série Envoyé | Affichage LCD (Rpi) | Action (Arduino 2) |
| :--- | :---: | :--- | :--- |
| **Aucun** | `'0'` | R: OFF / V: OFF | LEDs éteintes |
| **Rouge** | `'R'` | **R: ON** / V: OFF | LED Rouge ON |
| **Vert** | `'V'` | R: OFF / **V: ON** | LED Verte ON |
| **Les Deux** | `'D'` | **R: ON / V: ON** | Les 2 LEDs ON |

---

##  Installation et Utilisation

### 1. Arduino Émetteur (Dossier `Arduino_TX`)
* Ouvrir le fichier `.ino` avec l'IDE Arduino.
* Téléverser sur la carte connectée aux boutons.

### 2. Raspberry Pi (Dossier `Raspberry_Python`)
* Activer l'I2C via `sudo raspi-config`.
* Installer les dépendances Python :
    ```bash
    pip3 install pyserial
    # La bibliothèque grove_rgb_lcd doit être présente dans le dossier
    ```
* Lancer le script :
    ```bash
    python3 main.py
    ```

### 3. Arduino Récepteur (Dossier `Arduino_RX`)
* Ouvrir le fichier `.ino`.
* **Note importante :** Ce code utilise `SoftwareSerial` sur les pins 10 et 11.
* Téléverser sur la carte connectée aux LEDs.

---

## Spécificités Techniques

### Adaptation de Tension (5V → 3.3V)
Pour protéger le RX du Raspberry Pi des signaux 5V de l'Arduino émetteur, un **pont diviseur de tension** est utilisé :
* $R_{serie} = 200\Omega$
* $R_{masse} = 300\Omega$
* $V_{out} \approx 3.0V$ (Compatible et sécurisé).

### Inversion Logique (3.3V → 5V)
L'adaptation vers l'Arduino récepteur utilise un transistor NPN en montage émetteur commun. Ce montage **inverse le signal** (Active-Low).
* **Solution Logicielle :** Utilisation de la bibliothèque `SoftwareSerial` avec le paramètre d'inversion activé :
    ```cpp
    SoftwareSerial mySerial(10, 11, true); // true = Logique inversée
    ```

---

##  Licence
Projet académique réalisé dans le cadre du module SAC31.
