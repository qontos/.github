# Contributing to QONTOS

We welcome contributions to QONTOS. This guide applies to all repositories under the `qontos` organization.

## Getting Started

1. Fork the repository
2. Create a feature branch from `main`
3. Make your changes
4. Run the test suite
5. Submit a pull request

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/REPO_NAME.git
cd REPO_NAME

# Create virtual environment
python -m venv .venv
source .venv/bin/activate

# Install in development mode
pip install -e ".[dev]"

# Run tests
pytest

# Run linter
ruff check src/

# Run type checker
mypy src/
```

## Code Standards

- **Style:** We use [Ruff](https://docs.astral.sh/ruff/) for linting and formatting. Run `ruff check` and `ruff format` before committing.
- **Types:** All public APIs must have type annotations. We use [mypy](https://mypy-lang.org/) for type checking.
- **Tests:** All new features and bug fixes must include tests. We use [pytest](https://pytest.org/).
- **Docstrings:** Public functions and classes must have docstrings (Google style).

## Pull Request Process

1. Ensure CI passes (lint, typecheck, test, build).
2. Update documentation if you changed public APIs.
3. Add a CHANGELOG entry for user-facing changes.
4. Request review from a maintainer.
5. Squash commits before merge (or we will squash on merge).

## Commit Messages

Use conventional commit format:

```
feat: add spectral partitioning for large circuits
fix: correct qubit mapping in tensor product aggregation
docs: update scheduling API reference
test: add coverage for noisy simulation edge cases
```

## Reporting Issues

- **Bugs:** Use the [Bug Report](https://github.com/qontos/.github/issues/new?template=bug_report.yml) template.
- **Features:** Use the [Feature Request](https://github.com/qontos/.github/issues/new?template=feature_request.yml) template.
- **Security:** See [SECURITY.md](SECURITY.md).

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to abide by its terms.

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.
