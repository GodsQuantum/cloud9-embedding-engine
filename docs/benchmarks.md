# Benchmark protocol

Two tests are intentionally separate.

## Throughput

`scripts/bench_client.py` measures the served API on the actual machine. Record:

- model and quantization;
- hardware and backend;
- batch size;
- request concurrency;
- input size;
- vector dimension;
- wall time and p95 latency.

Do not compare results from different input lengths as if they were equivalent.

## Retrieval smoke gate

`scripts/model_gate.py` runs a tiny bilingual FR/EN recall@1 check. It catches broken pooling, wrong endpoint configuration and obviously bad conversions.

It is **not** a replacement for MTEB, MIRACL, BEIR or a domain-specific evaluation.

## Cloud9 reference

Reference hardware: Ryzen 7 8845HS / Radeon 780M, RADV Vulkan.

Qwen3-Embedding-0.6B Q8_0 produced about 54.9 req/s on the short sequential micro-benchmark and about 73.4 embeddings/s at batch 32. Five cross-engine samples had cosine 0.99959–0.99976 versus the TEI/ONNX representation.

Large knowledge-base chunks around ~900 tokens take materially longer. Production configuration should therefore be chosen from real corpus tests, not the short benchmark alone.
