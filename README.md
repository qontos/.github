<div align="center">
  <a href="https://github.com/qontos">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/qontos/.github/main/assets/qontos-logo-white.png">
      <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/qontos/.github/main/assets/qontos-logo.png">
      <img src="https://raw.githubusercontent.com/qontos/.github/main/assets/qontos-logo.png" alt="QONTOS" width="260">
    </picture>
  </a>

  <h3>QONTOS Organization Standards</h3>
  <p><strong>Community health, shared policy, branding, and org-level automation for the QONTOS organization.</strong></p>

  <p>
    <img src="https://img.shields.io/badge/Visibility-Public-0f766e?style=flat-square" alt="Visibility: Public">
    <img src="https://img.shields.io/badge/Track-Org_Standards-0b3b8f?style=flat-square" alt="Track: Org Standards">
    <img src="https://img.shields.io/badge/Status-Active-166534?style=flat-square" alt="Status: Active">
  </p>

  <p>
    <a href="#overview">Overview</a> &middot;
    <a href="#what-lives-here">What Lives Here</a> &middot;
    <a href="#org-policies">Org Policies</a> &middot;
    <a href="#automation-and-guardrails">Automation and Guardrails</a>
  </p>
</div>

---

## Overview

This repository is the organizational control surface for QONTOS on GitHub. It defines the public profile, shared contribution policies, support and security routes, issue templates, and the consistency checks that keep the public repos aligned.

## What Lives Here

| Path | Purpose |
| :--- | :--- |
| `profile/README.md` | Public organization landing page shown at [github.com/qontos](https://github.com/qontos) |
| `CONTRIBUTING.md`, `SECURITY.md`, `SUPPORT.md`, `CODE_OF_CONDUCT.md` | Shared standards inherited by the broader org |
| `ISSUE_TEMPLATE/` and `PULL_REQUEST_TEMPLATE.md` | Consistent intake and review structure across repos |
| `scripts/` | Cross-repo and per-repo policy checks for public documentation consistency |
| `tests/` | Self-tests that validate the policy checkers and guard against regression |
| `assets/` | Canonical QONTOS logo assets used across public repo READMEs and the org profile |

## Org Policies

This repo is the canonical source for:

- community standards and contribution expectations
- public support and vulnerability reporting routes
- documentation and install-policy consistency rules
- commit identity verification for repository governance

## Automation And Guardrails

The `.github` repo currently enforces two important organization-wide trust signals:

- **Commit identity verification** to ensure commits use the approved author email
- **Documentation consistency checks** to keep install guidance, security contact information, pinned tags, and notebook instructions aligned across the public repos

## Related Repositories

| Repository | Role |
| :--- | :--- |
| [qontos](https://github.com/qontos/qontos) | Flagship SDK and public developer entry point |
| [qontos-sim](https://github.com/qontos/qontos-sim) | Simulation, digital twin, and tensor-network modeling |
| [qontos-examples](https://github.com/qontos/qontos-examples) | Tutorials, notebooks, and runnable example workflows |
| [qontos-benchmarks](https://github.com/qontos/qontos-benchmarks) | Public evidence and regression methodology |
| [qontos-research](https://github.com/qontos/qontos-research) | Whitepapers, roadmap, and technical publication surface |

---

<p align="center">
  <sub>QONTOS · Hybrid superconducting-photonic quantum computing · Built by Zhyra Quantum Research Institute (ZQRI)</sub>
</p>
