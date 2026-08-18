# TenderGPT Edge

**Offline AI Tender Intelligence for Commodity Laptops**

Built for the **Africa Deep Tech Challenge 2026 — Laptop LLM Challenge**.

TenderGPT Edge is a desktop application designed to help contractors and enterprises analyse tender documents using a local language model. It extracts document information, retrieves supporting evidence with page citations, and answers natural-language questions — all without requiring cloud AI or sending tender data to external services.

## Why TenderGPT Edge?

Tender documents can be long, complex, and time-consuming to analyse. Important information such as closing dates, submission requirements, evaluation criteria, scope of work, and contact details can be difficult to locate quickly.

TenderGPT Edge combines deterministic document processing, evidence retrieval, and a locally running language model to help users explore tender documents while keeping the source data on the device.

The project is designed around an offline-first approach:

* No cloud AI APIs required
* Tender documents remain on the local machine
* Evidence is retrieved from the source document
* AI answers can be supported by document citations
* The language model runs locally on CPU hardware

## Key Features

* 100% local document processing
* Offline AI question answering
* Natural-language Q&A powered by Qwen2.5-1.5B-Instruct
* Evidence retrieval with page citations
* PDF document inspection and text extraction
* OCR fallback support for difficult documents
* Tender information extraction
* Procurement and bid-readiness analysis
* Local CPU inference
* No cloud AI APIs required
* Desktop interface built with PySide6
* Export functionality for generated analysis
* Local-first design for privacy and data control

## How It Works

TenderGPT Edge follows a local processing pipeline:

1. A tender PDF is opened in the desktop application.
2. The document is inspected and processed locally.
3. Text is extracted from the PDF.
4. OCR can be used when normal text extraction is insufficient.
5. The document is divided into deterministic evidence chunks.
6. The evidence engine retrieves relevant information for a user's question.
7. The selected evidence is provided to the local Qwen language model.
8. The model generates an answer based on the available context.
9. Supporting document pages can be displayed as citations.

The system separates evidence retrieval from language generation so that the application can distinguish between document evidence and the generated answer.

## Architecture

TenderGPT Edge is structured as an offline-first desktop application.

```text
                    ┌───────────────────────┐
                    │   Tender PDF Input    │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │ Document Inspection   │
                    │ & Text Extraction     │
                    └───────────┬───────────┘
                                │
                     ┌──────────┴──────────┐
                     ▼                     ▼
          ┌──────────────────┐   ┌──────────────────┐
          │ Standard PDF Text │   │   OCR Fallback   │
          │    Extraction     │   │                  │
          └─────────┬────────┘   └─────────┬────────┘
                    └──────────┬───────────┘
                               ▼
                    ┌───────────────────────┐
                    │ Deterministic Chunker │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │   Evidence Engine     │
                    │ Local Retrieval       │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │ Prompt Construction   │
                    │ + Evidence Context    │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │ Qwen2.5-1.5B-Instruct │
                    │ GGUF via llama.cpp    │
                    │      Local CPU        │
                    └───────────┬───────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │ Answer + Citations    │
                    │ Tender Intelligence   │
                    └───────────────────────┘
```

## Technology Stack

TenderGPT Edge uses:

* **Python**
* **PySide6**
* **llama.cpp**
* **llama-cpp-python**
* **Qwen2.5**
* **GGUF**
* **SQLite**
* **PDF processing**
* **OCR**
* **Natural Language Processing**
* **Information Retrieval**

## Local AI Model

The application uses a quantized local language model.

* **Model:** Qwen2.5-1.5B-Instruct
* **Detected parameters:** 1,777,088,000
* **Architecture:** Qwen2
* **Quantization:** Q4_K_M
* **Format:** GGUF
* **Runtime:** llama.cpp / llama-cpp-python
* **Context length reported by profiler:** 32,768 tokens
* **Inference mode:** Local CPU

The model is not included in the Git repository.

Use the included model download instructions or script to obtain the required GGUF model and place it in the expected `models/` directory.

## ADTC 2026 Profiling Results

The following results were generated using the ADTC participant profiler and are recorded in `submission.json`.

| Metric                      |                       Result |
| --------------------------- | ---------------------------: |
| Model                       | Qwen2.5-1.5B-Instruct Q4_K_M |
| Detected Parameters         |                1,777,088,000 |
| Generation Throughput       |               8.7 tokens/sec |
| First Token Latency         |                  24,479.2 ms |
| Prompt Tokens               |                          512 |
| Generated Tokens            |                          128 |
| ARC-Easy Accuracy           |                          74% |
| Peak RSS Memory             |                   1822.45 MB |
| Steady-State RSS Memory     |                   1739.07 MB |
| Peak Virtual Memory         |                   2283.41 MB |
| CPU Utilisation P99         |                        51.5% |
| Thermal Throttling Detected |                           No |
| Random Seed                 |                           42 |

The model profiler also confirmed:

* Parameter count matches the claimed approximately 1.8B model size.
* The model architecture was detected as `qwen2`.
* The reported context length was 32,768 tokens.

The complete machine-readable profiling report is available in:

```text
submission.json
```

## Project Structure

The project is organised around separate responsibilities:

```text
tender-intelligence-edge/
│
├── ai/                 # Local LLM integration and prompts
├── app/                # Application entry point
├── config/             # Application and model settings
├── core/
│   ├── document/       # Document inspection and text extraction
│   ├── evaluation/     # Evaluation and validation components
│   ├── knowledge/      # Evidence retrieval
│   ├── pipeline/       # Processing pipeline
│   ├── reasoning/      # Reasoning-related components
│   └── services/       # Supporting services
│
├── desktop/             # PySide6 desktop interface
├── models/              # Local GGUF model location
├── scripts/             # Utility scripts
│
├── REPORT.md            # ADTC project report
└── submission.json      # ADTC profiler results
```

## Getting Started

### Requirements

The application requires:

* Python 3.12
* A compatible CPU
* The project dependencies
* The Qwen2.5-1.5B-Instruct Q4_K_M GGUF model

### Clone the Repository

```bash
git clone https://github.com/alljaybly/tender-intelligence-edge.git
cd tender-intelligence-edge
```

### Create a Virtual Environment

On Linux or WSL:

```bash
python -m venv .venv
source .venv/bin/activate
```

### Install Dependencies

Install the dependencies using the repository's provided requirements configuration.

For the desktop environment, the project uses a Python virtual environment with the required PySide6, PDF-processing, OCR, and local LLM dependencies.

### Download the Model

Download the Qwen2.5-1.5B-Instruct Q4_K_M GGUF model using the repository's model download instructions.

Place the model in:

```text
models/qwen2.5-1.5b-instruct-q4_k_m.gguf
```

The model is intentionally not stored in the Git repository because of its size.

### Run the Application

With the virtual environment activated:

```bash
python app/main.py
```

When the local model loads successfully, the application should report:

```text
Model Status: Qwen2.5 Loaded
Model Name: Qwen2.5
Response Mode: Local CPU
```

## Using TenderGPT Edge

1. Launch the application.
2. Confirm that the Qwen2.5 model has loaded.
3. Select **Open Tender**.
4. Choose a tender PDF.
5. Allow the application to inspect and process the document.
6. Navigate through the extracted tender information.
7. Use the Evidence Explorer to inspect retrieved document evidence.
8. Open the AI Assistant.
9. Ask questions about the tender document.
10. Review the generated answer and supporting citations.

Example questions include:

```text
What is the closing date for this tender?
```

```text
What documents are required for submission?
```

```text
What are the evaluation criteria?
```

```text
Summarise the scope of work.
```

```text
What are the main risks or warnings in this tender?
```

## Evidence-Based AI

TenderGPT Edge does not rely solely on the language model to search the tender document.

Before generating an answer, the application retrieves relevant evidence from the locally processed document. This evidence is used to construct the model context.

This approach provides:

* Better connection between answers and source documents
* Page-level evidence references
* Deterministic local retrieval
* Separation between document evidence and language generation
* A foundation for evaluating answer quality against source material

## Offline and Privacy Design

Tender documents may contain commercially sensitive information.

TenderGPT Edge is designed so that document processing and AI inference can take place locally.

The intended architecture does not require:

* Cloud AI APIs
* External document uploads
* Remote inference services

This allows tender documents and generated analysis to remain under the user's local control.

## Domain

**Corporate / Enterprise**

Primary use case:

**Procurement and Tender Intelligence**

TenderGPT Edge is designed for organisations and professionals who need to analyse procurement and tender documentation more efficiently.

## Built For

**Africa Deep Tech Challenge 2026**

**Laptop LLM Challenge**

The project demonstrates the use of a quantized language model running locally on commodity CPU hardware, combined with a practical desktop application and document intelligence workflow.

## Team

* [Allan Blythe](https://github.com/alljaybly)

Working solo.

## ADTC Submission Files

The repository includes the supporting submission materials for the Africa Deep Tech Challenge 2026.

Important files include:

```text
REPORT.md
metadata.json
submission.json
download_model.sh
```

`submission.json` contains the profiler-generated performance and benchmark results for the participant submission.

## Project Status

TenderGPT Edge is an active prototype and demonstration of offline AI-assisted tender intelligence.

The current implementation includes:

* Local document processing
* PDF text extraction
* OCR fallback
* Deterministic document chunking
* Evidence retrieval
* Local Qwen2.5 inference
* Evidence-supported natural-language Q&A
* PySide6 desktop interface
* Tender information extraction
* Bid-readiness analysis
* Local CPU inference

## License

This project is currently submitted as part of the Africa Deep Tech Challenge 2026.

No open-source license has been declared at this time.

---

**TenderGPT Edge — Offline AI Tender Intelligence for Commodity Laptops**
