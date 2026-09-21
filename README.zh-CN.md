<p align="center">
  <img src="docs/assets/logo.svg" width="132" alt="Cloud9 Embedding Engine logo">
</p>

<h1 align="center">Cloud9 Embedding Engine</h1>

<p align="center"><strong>面向 RDNA 的本地向量服务，兼容 OpenAI Embeddings API。</strong></p>

Cloud9 Embedding Engine 是一个轻量、独立的本地 embedding 运行时。它基于 llama.cpp 提供 `/v1/embeddings`，默认使用低竞争的单 slot 配置，并为首次大规模知识库导入提供临时 bulk 配置。 当前验证的 bulk 配置为 8 slots / ubatch 2048；正常 production 配置仍为 1 slot / ubatch 512。llama.cpp 主机 prompt cache 默认关闭（`C9EE_CACHE_RAM=0`），并使用较低的 CPU/I/O 优先级，避免 embedding 服务挤占其他基础设施资源。

参考硬件为 Ryzen 7 8845HS / Radeon 780M。当前默认模型为 Qwen3-Embedding-0.6B Q8_0；模型目录同时记录 Jina Embeddings v5 Small Retrieval 与 IBM Granite Embedding 311M Multilingual R2。

模型许可证彼此独立：项目代码为 MIT；Jina v5 Small 为 CC BY-NC 4.0，因此不应被默认为商业用途模型。

详细信息见 [docs/models.md](docs/models.md) 与 [docs/architecture.md](docs/architecture.md)。
