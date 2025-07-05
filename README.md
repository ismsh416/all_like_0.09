# Text Analyzer - Java Spring Boot

## ✅ Overview

This application analyzes a given English text file and provides statistical insights about word usage. It is implemented in **Java 17** using **Spring Boot** and adheres to the task requirements for the developer test.

---

## 🧠 Features

- 📄 **Word Count**: Calculates the total number of words (excluding stop words and special cases).
- 🔝 **Top 5 Frequent Words**: Shows the most frequently used words with usage counts, excluding prepositions, pronouns, articles, conjunctions, modal verbs, etc.
- 🔠 **Unique Words**: Lists 50 unique words in alphabetical order.
- 📂 **File Input**:
  - From a preloaded file (`moby.txt` in `resources`)
  - From a file uploaded via REST endpoint (e.g. via Postman or frontend)

---

## 📦 API Endpoints

### 1. **Analyze Resource File**
- **Method:** `GET`
- **URL:** `/api/text`
- **Description:** Analyzes the `moby.txt` file from the `resources` folder.
- **Response:** JSON containing total word count, top 5 frequent words, and unique words list.

### 2. **Analyze Uploaded File**
- **Method:** `POST`
- **URL:** `/api`
- **Content-Type:** `multipart/form-data`
- **Parameter:** `file` (the text file to be analyzed)
- **Description:** Allows users to upload a `.txt` file for custom analysis.
- **Response:** Same format as above.

---

## 🕐 Performance

- ⏱ **Processing Time**: Tracked and printed in seconds with two decimal places.
- 💡 Useful for benchmarking the algorithm against larger files.

---

## 📁 Project Structure

```plaintext
src
└── main
    ├── java
    │   └── com.epicor
    │       ├── controller
    │       │   └── TextAnalyzerController.java
    │       ├── service
    │       │   └── TextAnalyzerService.java
    │       ├── model
    │       │   ├── AnalysisResult.java
    │       │   └── WordResult.java
    │       └── util
    │           └── WordsUtil.java
    └── resources
        └── moby.txt
