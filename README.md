# 🎓 Sprachlern-App

> Eine interaktive Anwendung zum effektiven Lernen von Vokabeln und Sprachen.

(https://via.placeholder.com/800x200?text=Hier+Screenshot+einf%C3%BCgen)<img width="805" height="632" alt="Bildschirmfoto 2026-02-10 um 14 39 35" src="https://github.com/user-attachments/assets/d35187b5-50f7-4c19-8810-0c0583baeebf" />

*(Tipp: Ziehe einen Screenshot deiner App einfach per Drag & Drop in dieses Textfeld, um ihn anzuzeigen!)*

## 📖 Über das Projekt
Dieses Projekt ist eine Vollständige Full-Stack-Anwendung, die Nutzern hilft, neue Sprachen zu lernen. Sie ermöglicht das Verwalten von Vokabeln, Abfragen des Wissensstands und Speichern des Lernfortschritts.

Ich habe dieses Projekt entwickelt, um meine Fähigkeiten in der **Java-Entwicklung** und im Umgang mit **relationalen Datenbanken** zu vertiefen.

### ✨ Features
* **Benutzerverwaltung:** Anlegen und Verwalten von Lernprofilen.
* **Vokabeltrainer:** Interaktives Abfragen von Vokabeln.
* **Fortschrittsanzeige:** Visualisierung des Lernerfolgs.
* **Datenpersistenz:** Sichere Speicherung aller Daten in einer PostgreSQL-Datenbank.

---

## 🛠️ Technologien (Tech Stack)

Das Projekt basiert auf einer klassischen Client-Server-Architektur:

| Bereich | Technologie | Beschreibung |
| :--- | :--- | :--- |
| **Frontend** | Java | Grafische Benutzeroberfläche (GUI) erstellt mit IntelliJ |
| **Backend** | Java | Logikschicht zur Verarbeitung der Daten |
| **Datenbank** | PostgreSQL | Relationale Datenbank zur Speicherung von Vokabeln & Usern |
| **Tools** | IntelliJ, DataGrip, Git | Entwicklungsumgebung und Versionsverwaltung |

---

## 🗂️ Projektstruktur

Das Repository ist als **Monorepo** aufgebaut:

* `frontend/` - Enthält den Source Code für die Benutzeroberfläche.
* `backend/` - Enthält die Business-Logik und API-Schnittstellen.
* `database/` - SQL-Skripte (`schema.sql`) zum Erstellen der Datenbankstruktur.

---

## 🚀 Installation & Setup

Voraussetzungen:
* Java JDK installiert
* PostgreSQL installiert und laufend

**Schritte:**
1.  Repository klonen:
    ```bash
    git clone [https://github.com/MathiasRaymann/sprachlern-app.git](https://github.com/MathiasRaymann/sprachlern-app.git)
    ```
2.  Datenbank aufsetzen:
    * Führe das Skript `database/schema.sql` in deinem SQL-Tool (z.B. DataGrip) aus.
3.  Anwendung starten:
    * Öffne das Projekt in IntelliJ und starte die Main-Klasse im `backend`-Ordner.

---

## 👤 Autor

**Mathias Raymann**

* Mein GitHub Profil(https://github.com/MathiasRaymann)

---

⭐️ *Wenn dir dieses Projekt gefällt, lass gerne einen Stern da!*
