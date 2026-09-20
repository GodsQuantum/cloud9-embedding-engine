# Architecture

Cloud9 Embedding Engine deliberately stays smaller than a general LLM stack.

## Data path

```text
client / Open WebUI
        |
        | OpenAI-compatible POST /v1/embeddings
        v
cloud9-embedding-server
        |
        | profile + model policy
        v
upstream llama-server
        |
        +--> Vulkan / CUDA / Metal / CPU backend supported by llama.cpp
        |
        +--> dedicated embedding GGUF
```

The engine does not proxy generation models and does not share a model process with chat inference. That separation gives embeddings a stable endpoint and lets operators restart or benchmark them without unloading the main LLM.

## Coexistence policy

On a shared Radeon 780M, two Vulkan processes can coexist but they still contend for GPU execution and memory bandwidth. Cloud9 therefore defaults to:

- one embedding slot;
- a small resident embedding model;
- systemd `Nice=10` for CPU-side work;
- no artificial hard CPU reservation;
- a separate `bulk` profile only for initial indexing; on the validated 8845HS/780M profile it uses 8 slots and `ubatch=2048`, while production stays at one slot / `ubatch=512`.

The engine makes no promise of zero LLM slowdown. Measure simultaneous inference before promoting `balanced` or `bulk` to a permanent profile.

## Index invariants

A vector index is tied to at least:

- model family / checkpoint;
- embedding dimension;
- pooling and task mode;
- relevant query/document prefixes.

Changing those fields requires a re-embed. The runtime must never silently substitute another model because an endpoint happens to be available.

## Backends

The primary path is llama.cpp because it provides a compact OpenAI-compatible embedding server and broad hardware support. The model catalog may also document official ONNX/OpenVINO artifacts when they are a better deployment choice, but they are not silently mixed into the llama.cpp runtime.
