# Security Policy

## Our Commitment

The StackSwap team takes the security of our smart contracts and platform very seriously. We appreciate the security community's efforts in helping us maintain the highest security standards.

## Supported Versions

We currently provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.x     | :white_check_mark: |
| < 1.0   | :x:                |

## Smart Contract Security

### Audit Status

StackSwap smart contracts are built with security as a top priority. We follow best practices for Clarity smart contract development:

- **Formal Verification**: Clarity's decidable nature allows for formal verification
- **Type Safety**: Clarity's strong type system prevents many common vulnerabilities
- **No Reentrancy**: Clarity's design eliminates reentrancy attacks
- **Bounded Execution**: All contract calls have predictable gas costs

### Security Features

Our contracts implement multiple security measures:

1. **Access Control**: Proper authentication and authorization checks
2. **Input Validation**: Comprehensive validation of all user inputs
3. **Safe Math**: Overflow/underflow protection (built into Clarity)
4. **Pausability**: Emergency pause mechanisms where appropriate
5. **Time Locks**: Delayed execution for sensitive operations

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

### How to Report

If you discover a security vulnerability, please send a detailed report to:

**Email**: stackswap.official@gmail.com

### What to Include

Your report should include:

1. **Type of vulnerability** (e.g., logic error, access control issue)
2. **Affected contract(s)** and function(s)
3. **Step-by-step instructions** to reproduce the issue
4. **Potential impact** and severity assessment
5. **Suggested fix** (if you have one)
6. **Your contact information** for follow-up

### Response Timeline

- **Initial Response**: Within 48 hours of report receipt
- **Investigation**: We will investigate and validate the report
- **Updates**: Regular updates every 72 hours during investigation
- **Resolution**: Timeline depends on severity and complexity

### Severity Levels

We classify vulnerabilities using the following severity levels:

#### Critical
- Fund theft or loss
- Unauthorized minting of tokens
- Complete system compromise

#### High
- Partial fund loss
- Denial of service affecting core functionality
- Access control bypass

#### Medium
- Incorrect calculation affecting token economics
- Information disclosure
- Minor access control issues

#### Low
- Gas optimization issues
- Best practice violations
- Informational findings

## Disclosure Policy

### Coordinated Disclosure

We follow a coordinated disclosure model:

1. **Report received** and acknowledged
2. **Vulnerability confirmed** and fix developed
3. **Fix deployed** to production
4. **Public disclosure** after fix is live (typically 30-90 days after report)

### Recognition

We maintain a security researchers hall of fame for responsible disclosure:

- Public acknowledgment (unless you prefer to remain anonymous)
- Potential bug bounty rewards for qualifying vulnerabilities
- Attribution in security advisories

## Bug Bounty Program

### Scope

The following contracts are in scope for bug bounty rewards:

- stackswap-swap-v1.clar
- stackswap-farming-v1.clar
- stackswap-governance-v1.clar
- stackswap-dao.clar
- stackswap-one-step-mint-v1.clar
- All SIP-010 token contracts

### Rewards

Rewards are determined based on severity:

- **Critical**: Up to $10,000 USD (in STX or STSW)
- **High**: Up to $5,000 USD
- **Medium**: Up to $1,000 USD
- **Low**: Up to $250 USD

*Note: Final reward amounts are at the discretion of the StackSwap team.*

### Exclusions

The following are **NOT** eligible for bug bounty rewards:

- Vulnerabilities in third-party contracts or dependencies
- Issues already known to the team
- Issues found in archived or deprecated code
- Theoretical vulnerabilities without proven exploit
- Social engineering attacks
- DoS attacks with insignificant impact

## Security Best Practices for Users

### When Using StackSwap

1. **Verify Contract Addresses**: Always verify you're interacting with official StackSwap contracts
2. **Check Transaction Details**: Review all transaction parameters before signing
3. **Use Official Interfaces**: Only use official StackSwap frontends
4. **Keep Keys Secure**: Never share your private keys or seed phrases
5. **Start Small**: Test with small amounts before committing large funds

### When Providing Liquidity

1. **Understand Impermanent Loss**: Be aware of IL risks
2. **Verify Pool Details**: Check token pairs and pool parameters
3. **Monitor Positions**: Regularly check your liquidity positions
4. **Withdraw Safely**: Understand the implications of withdrawing liquidity

## Security Contacts

- **Security Email**: stackswap.official@gmail.com
- **GitHub Security Advisory**: Use GitHub's private security reporting feature

## Past Security Advisories

We will publish security advisories for all resolved vulnerabilities:

*No security advisories have been published yet.*

## Additional Resources

- [Clarity Security](https://docs.stacks.co/clarity/security)
- [Stacks Security Best Practices](https://docs.stacks.co/build-apps/guides/security)
- [Smart Contract Security Best Practices](https://consensys.github.io/smart-contract-best-practices/)

## Updates to This Policy

This security policy may be updated from time to time. Please check back regularly for the latest information.

---

**Last Updated**: December 30, 2025

Thank you for helping keep StackSwap and our users safe! 🔐
