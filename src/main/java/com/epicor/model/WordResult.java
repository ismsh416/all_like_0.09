package com.epicor.model;

import lombok.*;

@Data
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class WordResult {
    String word;
    int count;
}
