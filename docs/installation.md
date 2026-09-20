# Installation

## Requirements

- Linux or another llama.cpp-supported OS;
- a recent `llama-server` build with the backend you want;
- Python 3 for benchmark/gate scripts;
- network access to Hugging Face if you use `-hf` model specs.

For AMD RDNA on Linux, a Vulkan/RADV llama.cpp build is recommended.

## Install

```bash
sudo ./scripts/install.sh
sudoedit /etc/cloud9-embedding-engine/engine.env
sudo systemctl enable --now cloud9-embedding.service
```

Verify:

```bash
cloud9-embedding-engine doctor
curl -fsS http://127.0.0.1:8091/health
cloud9-embedding-engine gate
```

## Existing Cloud9 Engine users

Cloud9 Embedding Engine can reuse the promoted upstream llama.cpp binary from Cloud9 Engine. This avoids maintaining a second compiler/build tree while keeping the embedding model/process independent.

Set:

```bash
C9EE_LLAMA_SERVER=/srv/lxc/ia-compute/data/cloud9-engine-runtime/current/upstream/bin/llama-server
```

The projects remain separate: Cloud9 Engine owns LLM backend promotion; Cloud9 Embedding Engine owns embedding model policy, serving profile and index safety.
