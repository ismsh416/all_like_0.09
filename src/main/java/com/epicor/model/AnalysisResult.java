package com.epicor.model;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Data
@Getter
@Setter
public class AnalysisResult {
    int totalWordCount;
    List<WordResult> topWords;
    List<String> uniqueWords;
    double processingTime;
}
