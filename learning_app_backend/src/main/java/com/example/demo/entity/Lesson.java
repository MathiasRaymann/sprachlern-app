package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore; // <--- Importieren!
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Entity
@Table(name = "lessons")
@Getter
@Setter
public class Lesson {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String title;

    private String description;

    // --- HIER KOMMT DAS SCHILD HIN ---
    @OneToMany(mappedBy = "lesson", cascade = CascadeType.ALL)
    @JsonIgnore // <--- NEU: Verhindert die Endlosschleife hier!
    private List<Exercise> exercises;
}