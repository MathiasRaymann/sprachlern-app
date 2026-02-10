package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "languages")
@Getter
@Setter
public class Language {

    @Id
    @Column(columnDefinition = "bpchar(2)") // <--- HIER GEÄNDERT
    private String code;

    @Column(nullable = false)
    private String name;

    @Column(name = "flag_icon")
    private String flagIcon;
}