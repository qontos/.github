<p align="center">
  <img src="https://raw.githubusercontent.com/qontos/qontos/main/assets/qontos-logo.png" alt="QONTOS" width="320">
</p>

# QONTOS

QONTOS is a full-stack modular quantum computing company. The public QONTOS organization provides open orchestration software, simulators, examples, benchmarks, and research artifacts, while the private engineering program develops native modular superconducting quantum hardware, control systems, fault tolerance, interconnects, and cryogenic infrastructure.

Start here with the flagship SDK, then explore simulators, examples, benchmarks, and research.

---

## Open Today

| Repository | Description |
|---|---|
| [`qontos`](https://github.com/qontos/qontos) | Flagship Python SDK for modular quantum computing orchestration |
| [`qontos-sim`](https://github.com/qontos/qontos-sim) | Simulators, noisy models, digital twin, and tensor-network engine |
| [`qontos-examples`](https://github.com/qontos/qontos-examples) | Hands-on notebooks, tutorials, and runnable sample programs |
| [`qontos-benchmarks`](https://github.com/qontos/qontos-benchmarks) | Benchmark definitions, methodology, and reproducible outputs |
| [`qontos-research`](https://github.com/qontos/qontos-research) | Research artifacts, whitepapers, and technical reports |
| [`.github`](https://github.com/qontos/.github) | Org profile, contributing guide, and community health files |

## In Development

Native QONTOS modular superconducting quantum hardware, pulse and calibration control, fault-tolerant quantum computing stack, photonic interconnects, and cryogenic infrastructure.

## Stretch Roadmap

1,000,000 physical qubits and 10,000 logical qubits by 2030, gated by device, FTQC, interconnect, cryogenic, and control milestones.

## Quick Start

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

## Links

- **Documentation**: [qontos.dev](https://qontos.dev)
- **Research**: [qontos/qontos-research](https://github.com/qontos/qontos-research)
- **Contact**: [eng@qontos.dev](mailto:eng@qontos.dev)

## License

All public QONTOS repositories are licensed under [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0).

---

Built by [Zhyra Quantum Research Institute (ZQRI)](https://zhyra.xyz), Abu Dhabi, UAE.
