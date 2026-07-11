<p align="center">
  <a href="https://github.com/qontos">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/qontos/.github/main/assets/qontos-logo-white.png">
      <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/qontos/.github/main/assets/qontos-logo.png">
      <img src="https://raw.githubusercontent.com/qontos/.github/main/assets/qontos-logo.png" alt="QONTOS" width="280">
    </picture>
  </a>
</p>

<p align="center">
  <strong>Architecture intelligence for modular quantum systems.</strong><br>
  Open software today. Hardware is in early design; no devices have been fabricated yet.
</p>

---

## Open source, available today

These packages are public, installable, and green on their own CI. Every number they
produce is simulation, labelled as such.

| Repository | Description |
|------------|-------------|
| **[qontos-sim](https://github.com/qontos/qontos-sim)** | Circuit builder, exact statevector and tensor-network (MPS) simulators, and a modular-architecture estimator. NumPy only. |
| **[qontosq](https://github.com/qontos/qontosq)** | The quantum SDK for the modular architecture: cross-module transpilation to Bell pairs plus feed-forward, link noise, and a QEC-aware logical layer |
| **[qontos-examples](https://github.com/qontos/qontos-examples)** | Runnable examples, executed in CI against the pinned public releases |

## Quick install (pre-release)

```bash
pip install "qontos-sim @ git+https://github.com/qontos/qontos-sim.git@v0.1.0"
pip install "qontosq @ git+https://github.com/qontos/qontosq.git@v0.4.0"
```

## Status, stated honestly

- **Software**: an engineering alpha, not a market-validated product. Useful today for
  building and simulating circuits and for modular-architecture planning.
- **Research**: a candidate erasure-aware seam co-design for modular error correction,
  internally validated in simulation, pending external review and a patent filing. Not
  yet peer-reviewed.
- **Hardware**: architecture and simulation only. No qubits have been fabricated. Our own
  resource estimator reports that the current QONTOS-1 design sits above the
  fault-tolerance threshold, a validation-machine design rather than a fault-tolerant one.

## Long-term ambition (aspiration, not a current capability)

QONTOS aims to build a native modular superconducting quantum computer, joining
superconducting modules with a photonic interconnect. The direction includes tantalum
transmon chiplets, modular cryogenics with photonic links, erasure-aware error
correction, and pulse-level control. Any qubit-count or date targets are long-term
aspirations gated by engineering milestones (a gate ladder from first hardware through
below-threshold operation), not commitments and not current capabilities.

## Links

- [Release & Install Policy](https://github.com/qontos/.github/blob/main/docs/release-install-policy.md)
- [qontos-sim](https://github.com/qontos/qontos-sim) and [qontosq](https://github.com/qontos/qontosq) documentation
- [Examples](https://github.com/qontos/qontos-examples)

Research papers, benchmark evidence, and the hardware roadmap are being prepared and
will be linked here as each becomes public.

## Contributing

See [CONTRIBUTING.md](https://github.com/qontos/.github/blob/main/CONTRIBUTING.md) for guidelines.

## Security

Report vulnerabilities to [security@qontos.io](mailto:security@qontos.io). See [SECURITY.md](https://github.com/qontos/.github/blob/main/SECURITY.md).

---

<p align="center">
  <sub>Built by <a href="https://zhyra.xyz">Zhyra Quantum Research Institute</a> · Abu Dhabi, UAE</sub>
</p>
