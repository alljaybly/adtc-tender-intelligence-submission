# TenderGPT Edge

**Offline AI Tender Intelligence for Commodity Laptops**  
Built for the Africa Deep Tech Challenge 2026 (Laptop LLM Challenge)

TenderGPT Edge is a fully offline desktop application that helps contractors and enterprises analyse tender documents using a local language model. It extracts key information, retrieves evidence with citations, and answers natural-language questions — all without internet or cloud AI.

## Key Features
- 100% offline (no internet or cloud APIs required)
- Local document processing and evidence retrieval with citations
- Natural language Q&A powered by Qwen2.5-1.5B-Instruct
- Runs on CPU-only commodity laptops
- Private and secure — data never leaves the device

## Model
- **Model**: Qwen2.5-1.5B-Instruct
- **Quantization**: Q4_K_M (GGUF)
- **Runtime**: llama.cpp
- **Target Hardware**: ADTC Standard Laptop (and weaker machines)

## Hardware & Performance Notes
Performance numbers in `submission.json` were measured on an older Intel Core i3-5005U with 2.8 GB RAM (below the official ADTC Standard Laptop).  

On the reference hardware (Intel Core i5 10th–12th gen or AMD Ryzen 5 + 8 GB RAM) we expect significantly higher tokens per second and lower first-token latency. Peak memory usage remained efficient at approximately 1.8 GB.

## Domain
Corporate / Enterprise – Procurement & Tender Analysis

## Team
- Allan Blythe [](https://github.com/alljaybly)

## License
[Add your license here, e.g. MIT]