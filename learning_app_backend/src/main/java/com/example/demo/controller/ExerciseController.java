package com.example.demo.controller;

import com.example.demo.entity.Exercise;
import com.example.demo.service.ExerciseService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/exercises")
public class ExerciseController {

    // Hier definieren wir den Namen der Variable: "exerciseService"
    private final ExerciseService exerciseService;

    // Konstruktor
    public ExerciseController(ExerciseService exerciseService) {
        this.exerciseService = exerciseService;
    }

    @PostMapping
    public ResponseEntity<Exercise> createExercise(@RequestBody Exercise exercise) {
        return ResponseEntity.ok(exerciseService.createExercise(exercise));
    }

    @GetMapping
    public ResponseEntity<List<Exercise>> getAllExercises() {
        return ResponseEntity.ok(exerciseService.getAllExercises());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Exercise> getExerciseById(@PathVariable Integer id) {
        return exerciseService.getExerciseById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Das ist der neue Lösch-Befehl
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExercise(@PathVariable Integer id) {
        exerciseService.deleteExercise(id);
        return ResponseEntity.noContent().build();
    }
}