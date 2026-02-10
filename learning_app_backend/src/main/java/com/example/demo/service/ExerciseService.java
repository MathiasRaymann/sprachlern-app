package com.example.demo.service;

import com.example.demo.entity.Exercise;
import com.example.demo.repository.ExerciseRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExerciseService {

    private final ExerciseRepository exerciseRepository;

    public ExerciseService(ExerciseRepository exerciseRepository) {
        this.exerciseRepository = exerciseRepository;
    }

    // Speichern
    public Exercise createExercise(Exercise exercise) {
        return exerciseRepository.save(exercise);
    }

    // Alle laden
    public List<Exercise> getAllExercises() {
        return exerciseRepository.findAll();
    }

    // Einzelne suchen (DAS HAT GEFEHLT!)
    public Optional<Exercise> getExerciseById(Integer id) {
        return exerciseRepository.findById(id);
    }

    // Löschen
    public void deleteExercise(Integer id) {
        exerciseRepository.deleteById(id);
    }
}