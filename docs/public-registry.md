# QONTOS Public Registry

This document is the shared navigation map across the 6 public QONTOS repositories. Use it as the first stop when developers, researchers, or partners need to understand how the open QONTOS platform fits together.

## Public Program Map

| Layer | Repos | Purpose |
| :--- | :--- | :--- |
| Org and standards | `.github` | public profile, contribution policy, issue templates, and consistency guardrails |
| Developer platform | `qontos` | flagship SDK for ingestion, partitioning, scheduling, execution integrity, and orchestration |
| Simulation and planning | `qontos-sim` | local simulation, noisy simulation, digital twin, and tensor-network tooling |
| Adoption surface | `qontos-examples` | notebooks, runnable scripts, and learning paths for the public stack |
| Evidence layer | `qontos-benchmarks` | reproducible benchmark methodology, evidence, and regression validation |
| Research surface | `qontos-research` | whitepapers, papers, roadmap, figures, and technical publication context |

## Repo Registry

| Repo | Core Role | First Docs To Open | Current Use |
| :--- | :--- | :--- | :--- |
| [`.github`](https://github.com/qontos/.github) | org standards and shared policy | [`README.md`](https://github.com/qontos/.github/blob/main/README.md), [`docs/public-registry.md`](https://github.com/qontos/.github/blob/main/docs/public-registry.md) | org profile, support, security, and public consistency |
| [`qontos`](https://github.com/qontos/qontos) | flagship SDK | [`README.md`](https://github.com/qontos/qontos/blob/main/README.md), [`docs/index.md`](https://github.com/qontos/qontos/blob/main/docs/index.md) | ingestion, partitioning, scheduling, integrity, and public API |
| [`qontos-sim`](https://github.com/qontos/qontos-sim) | simulators and digital twin | [`README.md`](https://github.com/qontos/qontos-sim/blob/main/README.md), [`docs/index.md`](https://github.com/qontos/qontos-sim/blob/main/docs/index.md) | simulation, planning, and architecture modeling |
| [`qontos-examples`](https://github.com/qontos/qontos-examples) | public examples and notebooks | [`README.md`](https://github.com/qontos/qontos-examples/blob/main/README.md), [`docs/index.md`](https://github.com/qontos/qontos-examples/blob/main/docs/index.md) | onboarding, runnable workflows, and learning progression |
| [`qontos-benchmarks`](https://github.com/qontos/qontos-benchmarks) | public evidence and methodology | [`README.md`](https://github.com/qontos/qontos-benchmarks/blob/main/README.md), [`docs/index.md`](https://github.com/qontos/qontos-benchmarks/blob/main/docs/index.md) | correctness evidence, metrics, and regression validation |
| [`qontos-research`](https://github.com/qontos/qontos-research) | technical publications and roadmap | [`README.md`](https://github.com/qontos/qontos-research/blob/main/README.md), [`docs/index.md`](https://github.com/qontos/qontos-research/blob/main/docs/index.md) | whitepaper, papers, roadmap, figures, and release coordination |

## What Is Open Today

| Surface | Repo |
| :--- | :--- |
| SDK and orchestration primitives | `qontos` |
| Simulation and digital-twin tooling | `qontos-sim` |
| Examples and tutorials | `qontos-examples` |
| Evidence and methodology | `qontos-benchmarks` |
| Whitepapers and technical papers | `qontos-research` |

## Common Public Doc Stack

The public repos intentionally use a lighter documentation shape than the private repos:

| Layer | Purpose |
| :--- | :--- |
| `README.md` | primary public-facing narrative |
| `docs/index.md` | lighter docs hub for the repo |
| `.github/docs/release-install-policy.md` | canonical install and release policy across the public repos |
| task-specific docs | API surface, methodology, evidence, release checklist, or learning-path docs |

## How To Use This Registry

| Audience | Start Here |
| :--- | :--- |
| New developers | start with `qontos`, then open `qontos-examples` |
| Simulation or architecture users | start with `qontos-sim`, then `qontos-research` |
| Evaluators and partners | start with `qontos-benchmarks` and `qontos-research` |
| Contributors | start with `.github`, then the repo-specific `docs/index.md` |

## Operating Notes

- Keep this file current when public repos are added, split, or materially repurposed.
- Prefer linking to repo-local `docs/index.md` pages rather than scattering duplicate explanations.
- Treat this file as the public map of the ecosystem, not as a substitute for each repo’s own docs.
