package com.example.demo.repository;

import com.example.demo.entity.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExerciseRepository extends JpaRepository<Exercise, Integer> {
    // Leer! Spring Data JPA generiert automatisch alle Methoden wie findAll(), save(), etc.
}