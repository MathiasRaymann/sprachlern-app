package com.example.demo.entity; // Dein Package

import jakarta.persistence.*; // Für @Entity, @Table, @Id etc.
import lombok.Getter;         // Lombok spart uns Tipparbeit
import lombok.Setter;

@Entity
@Table(name = "languages") // WICHTIG: Muss genau so heißen wie in SQL!
@Getter
@Setter
public class Language {

    @Id
    @Column(length = 2) // In SQL hast du CHAR(2) gemacht
    private String code;

    @Column(nullable = false)
    private String name;

    @Column(name = "flag_icon") // SQL: flag_icon -> Java: flagIcon
    private String flagIcon;
}