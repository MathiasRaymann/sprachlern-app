package com.example.demo.entity;

import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Type;
import com.fasterxml.jackson.annotation.JsonIgnore; // <--- Import nicht vergessen!

@Entity
@Table(name = "exercises")
@Getter
@Setter
public class Exercise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // --- ÄNDERUNG START ---
    // Alt: private Integer lessonId;  <-- Das löschen!

    // Neu: Echte Verbindung zur Lesson
    @ManyToOne
    @JoinColumn(name = "lesson_id", nullable = false)
    //@JsonIgnore Wichtig, damit die App nicht abstürzt
    private Lesson lesson;
    // --- ÄNDERUNG ENDE ---

    @Column(nullable = false)
    private String type;

    @Column(name = "\"order\"", nullable = false)
    private Integer order;

    @Type(JsonType.class)
    @Column(columnDefinition = "jsonb", nullable = false)
    private ExerciseContent content;

    @Column(name = "xp_reward")
    private Integer xpReward;
}