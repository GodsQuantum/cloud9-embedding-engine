# Model catalog

The shortlist is optimized for bilingual French/English retrieval, local operation, current model quality and operational efficiency.

## 1. Qwen3-Embedding-0.6B — reference default

- source: https://huggingface.co/Qwen/Qwen3-Embedding-0.6B-GGUF
- license: Apache-2.0
- context: 32K
- output: 1024 dimensions
- recommended local variant: official Q8_0 GGUF, 639 MB
- pooling: last

Why it is the default: it is already validated on the reference Radeon 780M and its Q8 vectors were nearly identical to the TEI/ONNX reference in the Cloud9 gate.

For tighter storage, verified community quantization tests show Q5_K_M keeps much higher embedding fidelity than Q4_K_M. Treat any third-party quantization as a candidate until it passes the local gate.

## 2. Jina Embeddings v5 Text Small Retrieval — quality candidate

- source: https://huggingface.co/jinaai/jina-embeddings-v5-text-small-retrieval-GGUF
- released: 2026
- parameters: 677M
- languages: 119+
- context: 32K
- output: 1024 dimensions with Matryoshka truncation
- pooling: last
- recommended candidates: Q6_K (495 MB), Q8_0 (639 MB)
- license: **CC BY-NC 4.0**

Jina reports very strong English and multilingual benchmark averages for a sub-1B model. The non-commercial license is material: do not auto-promote it into a commercial workflow.

## 3. IBM Granite Embedding 311M Multilingual R2 — compact open candidate

- source: https://huggingface.co/ibm-granite/granite-embedding-311m-multilingual-r2
- released: 2026-04-29
- license: Apache-2.0
- parameters: 311M
- pretraining: 200+ languages
- enhanced retrieval training: 52 languages, including English and French
- context: 32K
- output: 768 dimensions, Matryoshka down to 128
- official deployment artifacts: safetensors, ONNX, OpenVINO
- llama.cpp pooling: cls

IBM reports 65.2 on its multilingual MTEB retrieval aggregate for the 311M R2 model. Since IBM does not currently publish the engine's preferred official GGUF file, a GGUF conversion should be made or verified locally against the official artifact before promotion.

## Alternative: EmbeddingGemma 300M

- source: https://huggingface.co/ggml-org/embeddinggemma-300M-GGUF
- parameters: ~308M
- official ggml-org Q8_0 conversion: 334 MB
- multilingual and extremely compact
- context: 2K

It is attractive where resident size matters more than long-document context. The current ggml-org conversion explicitly includes the dense layers.

## Promotion rule

A candidate is promoted only after:

1. it loads on the target backend;
2. the bilingual retrieval gate passes;
3. vector dimensions and pooling are recorded;
4. latency/throughput are benchmarked on representative chunks;
5. license is acceptable for the intended workload;
6. an existing index is rebuilt if the embedding space changes.
