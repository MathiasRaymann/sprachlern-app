package com.example.demo;

import com.example.demo.entity.Exercise;
import com.example.demo.repository.ExerciseRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.util.List;

@Component // Sagt Spring: "Bitte lade mich und führe mich aus"
public class DatabaseLoader implements CommandLineRunner {

    private final ExerciseRepository repository;

    // Dependency Injection: Spring gibt uns das Repository automatisch
    public DatabaseLoader(ExerciseRepository repository) {
        this.repository = repository;
    }

    @Override
    public void run(String... args) throws Exception {
        System.out.println("\n------------------------------------------------");
        System.out.println("TEST: Lade Übungen aus der Datenbank...");

        List<Exercise> exercises = repository.findAll();

        if (exercises.isEmpty()) {
            System.out.println("WARNUNG: Keine Übungen gefunden! Hast du das INSERT SQL ausgeführt?");
        } else {
            for (Exercise ex : exercises) {
                System.out.println("ID: " + ex.getId());
                System.out.println("Frage: " + ex.getContent().getQuestion()); // <-- Zugriff auf JSON Objekt!
                System.out.println("Lösung: " + ex.getContent().getCorrect_answer());
                System.out.println("Optionen: " + ex.getContent().getOptions());
                System.out.println("------------------------------------------------\n");
            }
        }
    }
}