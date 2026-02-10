package com.example.demo.entity;

import java.io.Serializable;
import java.util.List;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor // Wichtig für den JSON-Parser
@AllArgsConstructor
public class ExerciseContent implements Serializable {

    // Muss exakt zu den Schlüsseln in deinem JSON passen ("question", "options" etc.)
    private String question;

    // Im JSON heißt es "correct_answer" (Snake Case).
    // Jackson (der Parser) ist schlau genug, das oft automatisch zu mappen,
    // aber sauberer wäre @JsonProperty("correct_answer").
    // Wir lassen es erstmal einfach:
    private String correct_answer;

    private List<String> options;

    private String audio_url;
}