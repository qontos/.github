# QONTOS Public Release And Install Policy

This document is the canonical public source for how QONTOS packages should be installed today and how public release references should be maintained across the public repositories.

## Current Public Install Model

QONTOS is still in a pre-release stage for package distribution.

That means:

- public installation uses pinned Git tags, not moving `main`
- public docs should describe the current tag-based install path plainly
- PyPI wording should remain future-facing until packages are actually published there

## Current Package Matrix

| Surface | Current Public Install Path | Current Tag Policy |
| :--- | :--- | :--- |
| `qontos` | `pip install git+https://github.com/qontos/qontos.git@v0.2.0` | SDK installs from the current pinned SDK tag |
| `qontos-sim` | `pip install "qontos-sim[all] @ git+https://github.com/qontos/qontos-sim.git@v0.1.0"` | simulator installs from the current sim tag and pulls the pinned SDK dependency |
| `qontos-examples` | `pip install -r requirements.txt` or install the pinned SDK + sim tags directly | examples should prefer the curated requirements path for a reproducible environment |
| `qontos-benchmarks` | `pip install "qontos-bench @ git+https://github.com/qontos/qontos-benchmarks.git@v0.1.0"` | benchmark installs should use the pinned benchmark tag |
| `qontos-research` | no package install | research is a publication surface, not a package surface |
| `.github` | no package install | org standards and policy repo, not an installable package |

## Public Install Rules

- Always use pinned tags in public install snippets.
- Do not reference `@main` in public installation guidance.
- Do not imply PyPI availability before it exists.
- Prefer one canonical install path per repo instead of multiple competing stories.
- When a repo is not a package surface, say so directly.

## Repo-Specific Guidance

| Repo | Guidance |
| :--- | :--- |
| `qontos` | README is the primary install surface; `docs/index.md` should point back here and to this policy |
| `qontos-sim` | README should explain the pinned tag install and optional extras clearly |
| `qontos-examples` | README should prefer `requirements.txt` for the full examples environment |
| `qontos-benchmarks` | README should show the pinned benchmark install and keep contributor install separate |
| `qontos-research` | docs should point here for release/install policy, but should not present itself as installable |
| `.github` | owns the canonical policy and shared consistency guardrails |

## When Tags Change

When the active public tags change:

1. update this policy first
2. update the repo README install snippets
3. update repo-local docs hubs
4. update examples `requirements.txt` if needed
5. run the public doc consistency checks

## Future PyPI Transition

Once QONTOS packages are actually published to PyPI:

- replace pinned Git install snippets with package installs
- remove pre-release wording from the affected repos
- update this policy to make PyPI the canonical install path
- keep Git tags as the fallback source only if that remains intentional

## Related Docs

- [Public Registry](public-registry.md)
- [QONTOS Research Release Checklist](https://github.com/qontos/qontos-research/blob/main/docs/release-checklist.md)
