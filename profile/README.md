<p align="center">
  <img src="https://raw.githubusercontent.com/qontos/qontos/main/assets/qontos-logo.png" alt="QONTOS" width="320">
</p>

<h3 align="center">Quantum computing orchestration. Software-first. Hardware-agnostic. Modular-native.</h3>

<p align="center">
  <a href="https://qontos.dev">Documentation</a> &middot;
  <a href="https://github.com/qontos/qontos-examples">Examples</a> &middot;
  <a href="https://github.com/orgs/qontos/discussions">Discussions</a>
</p>

---

QONTOS is a distributed quantum computing orchestration platform. Submit quantum circuits once -- QONTOS handles partitioning, scheduling, execution, aggregation, and verification across any combination of quantum backends.

## Start Here

| Repository | Description |
|---|---|
| [`qontos`](https://github.com/qontos/qontos) | Python SDK for quantum circuit orchestration |
| [`qontos-sim`](https://github.com/qontos/qontos-sim) | Simulators and modular digital twin |
| [`qontos-examples`](https://github.com/qontos/qontos-examples) | Tutorials, notebooks, and integration examples |
| [`qontos-benchmarks`](https://github.com/qontos/qontos-benchmarks) | Benchmark framework and reproducible methodology |

## Install

```bash
pip install qontos
```

```python
from qontos import QontosClient

client = QontosClient()
job = client.submit(circuit="OPENQASM 2.0; ...", shots=8192)
result = client.get_result(job.id)
print(result.counts)
```

## Capabilities

- **Multi-format circuit ingestion** -- OpenQASM 2.0/3.0, Qiskit, PennyLane
- **Circuit partitioning** -- Greedy, spectral, and manual strategies
- **Capability-aware scheduling** -- Fidelity, queue depth, cost, and capacity scoring
- **Multi-provider execution** -- IBM Quantum, Amazon Braket, local simulators, extensible
- **Cryptographic execution proofs** -- SHA-256 hash chain for full auditability
- **Modular-native design** -- Built for distributed quantum modules from day one

## Documentation

Full guides, API reference, and architecture docs at **[qontos.dev](https://qontos.dev)**.

## Contributing

See [CONTRIBUTING.md](https://github.com/qontos/.github/blob/main/CONTRIBUTING.md) for development setup, code standards, and pull request guidelines.

## License

All public QONTOS repositories are licensed under [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0).

---

Built by [Zhyra Quantum Research Institute (ZQRI)](https://zhyra.xyz), Abu Dhabi.
