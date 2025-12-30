# Contributing to StackSwap

Thank you for your interest in contributing to StackSwap! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Development Workflow](#development-workflow)
- [Testing](#testing)
- [Coding Standards](#coding-standards)
- [Submitting Changes](#submitting-changes)
- [Reporting Bugs](#reporting-bugs)
- [Feature Requests](#feature-requests)

## Code of Conduct

We are committed to providing a welcoming and inclusive environment. Please be respectful and professional in all interactions.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/stackswap_contract_v1.git
   cd stackswap_contract_v1
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/stackswap/stackswap_contract_v1.git
   ```

## Development Setup

### Prerequisites

- Node.js (>= 10.0.0)
- npm or yarn
- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity runtime packaged as a CLI

### Installation

1. **Install dependencies**:
   ```bash
   npm install
   # or
   yarn install
   ```

2. **Set up environment variables**:
   ```bash
   cp .env.sample.env .env
   # Edit .env with your configuration
   ```

3. **Install Clarinet** (if not already installed):
   ```bash
   # macOS via Homebrew
   brew install clarinet
   
   # Or download from: https://github.com/hirosystems/clarinet/releases
   ```

## Project Structure

```
stackswap_contract_v1/
├── clarinet/               # Clarinet configuration and contracts
│   ├── contracts/          # Clarity smart contracts
│   ├── settings/           # Clarinet settings
│   └── Clarinet.toml       # Clarinet configuration
├── src/                    # JavaScript utilities
├── assets/                 # Token logos and assets
├── deploy.js               # Deployment script
├── package.json            # Node.js dependencies
└── README.md               # Project documentation
```

### Key Contracts

- **stackswap-swap-v1.clar**: Core DEX swap functionality
- **stackswap-dao.clar**: DAO governance
- **stackswap-farming-v1.clar**: Liquidity mining rewards
- **stackswap-governance-v1.clar**: Governance voting
- **stackswap-one-step-mint-v1.clar**: Token launchpad
- **token-stsw.clar**: StackSwap governance token

## Development Workflow

1. **Create a new branch** for your feature or fix:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-description
   ```

2. **Make your changes** following the coding standards

3. **Test your changes** thoroughly

4. **Commit your changes** with clear, descriptive messages:
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```

### Commit Message Convention

Use conventional commit messages:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `test:` - Adding or updating tests
- `refactor:` - Code refactoring
- `chore:` - Maintenance tasks

## Testing

### Running Clarinet Console

To test contracts interactively:

```bash
cd clarinet
clarinet console
```

### Running Tests

```bash
npm test
```

### Testing Best Practices

- Write tests for all new functionality
- Ensure all tests pass before submitting a PR
- Test edge cases and error conditions
- Test contract interactions thoroughly

## Coding Standards

### Clarity Contracts

- Follow [Clarity coding conventions](https://docs.stacks.co/clarity/overview)
- Use descriptive function and variable names
- Include comments for complex logic
- Use proper error handling with meaningful error codes
- Follow the existing code style in the project

### JavaScript

- Use ES6+ syntax
- Follow existing code formatting
- Add JSDoc comments for public functions
- Handle errors appropriately

### Documentation

- Update README.md when adding new features
- Add inline comments for complex logic
- Document all public APIs and functions
- Update CHANGELOG.md (if exists)

## Submitting Changes

1. **Push your changes** to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create a Pull Request** (PR) on GitHub:
   - Use a clear, descriptive title
   - Reference any related issues (e.g., "Fixes #123")
   - Provide a detailed description of changes
   - Include screenshots for UI changes
   - List any breaking changes

3. **Wait for review**:
   - Address any feedback from reviewers
   - Make requested changes in new commits
   - Keep the PR updated with the main branch

### PR Checklist

Before submitting a PR, ensure:
- [ ] Code follows project coding standards
- [ ] All tests pass
- [ ] New code has appropriate test coverage
- [ ] Documentation is updated
- [ ] Commit messages follow conventions
- [ ] No merge conflicts with main branch

## Reporting Bugs

When reporting bugs, please include:

1. **Clear title and description**
2. **Steps to reproduce** the issue
3. **Expected behavior**
4. **Actual behavior**
5. **Environment details** (OS, Node version, etc.)
6. **Screenshots or logs** if applicable

## Feature Requests

We welcome feature requests! Please:

1. **Check existing issues** to avoid duplicates
2. **Clearly describe** the feature and use case
3. **Explain why** this feature would be useful
4. **Consider implementation** if possible

## Questions?

If you have questions about contributing:
- Open a [GitHub Discussion](https://github.com/stackswap/stackswap_contract_v1/discussions)
- Join our community channels
- Review existing issues and PRs

## License

By contributing to StackSwap, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to StackSwap! 🚀
