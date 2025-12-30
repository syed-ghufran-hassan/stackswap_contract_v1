# StackSwap Contract Testing Guide

This guide provides comprehensive information on testing StackSwap smart contracts using Clarinet.

## Table of Contents

- [Overview](#overview)
- [Testing Environment Setup](#testing-environment-setup)
- [Running Tests](#running-tests)
- [Writing Tests](#writing-tests)
- [Test Examples](#test-examples)
- [Best Practices](#best-practices)
- [Debugging](#debugging)

## Overview

StackSwap uses [Clarinet](https://github.com/hirosystems/clarinet) for smart contract development and testing. Clarinet provides a Clarity runtime and testing environment that allows you to:

- Run contracts locally without deploying to testnet
- Write and execute automated tests
- Debug contract interactions
- Simulate different blockchain states

## Testing Environment Setup

### Prerequisites

1. **Install Clarinet**:
   ```bash
   # macOS
   brew install clarinet
   
   # Linux
   wget -nv https://github.com/hirosystems/clarinet/releases/download/v1.0.0/clarinet-linux-x64.tar.gz -O clarinet-linux-x64.tar.gz
   tar -xf clarinet-linux-x64.tar.gz
   chmod +x ./clarinet
   mv ./clarinet /usr/local/bin
   
   # Windows
   # Download from: https://github.com/hirosystems/clarinet/releases
   ```

2. **Verify Installation**:
   ```bash
   clarinet --version
   ```

### Project Structure

```
clarinet/
├── Clarinet.toml          # Project configuration
├── contracts/             # Smart contracts
│   ├── stackswap-swap-v1.clar
│   ├── stackswap-dao.clar
│   └── ...
├── settings/              # Network settings
│   └── Devnet.toml
└── tests/                 # Test files (create this directory)
    └── stackswap_test.ts
```

## Running Tests

### Interactive Console

The Clarinet console allows you to interact with contracts in a REPL environment:

```bash
cd clarinet
clarinet console
```

In the console, you can:

```clarity
;; Check contract deployment
(contract-call? .stackswap-swap-v1 get-pair-count)

;; Call contract functions
(contract-call? .token-wstx get-balance tx-sender)

;; Deploy transactions as different users
::set_tx_sender ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM
```

### Running Test Suite

```bash
# Run all tests
clarinet test

# Run specific test file
clarinet test tests/stackswap_test.ts

# Run with coverage
clarinet test --coverage
```

### Check Contract Syntax

```bash
# Check all contracts
clarinet check

# Check specific contract
clarinet check contracts/stackswap-swap-v1.clar
```

## Writing Tests

### Test Structure

Create test files in TypeScript using the Clarinet testing framework:

```typescript
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.0.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
    name: "Test description",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        // Test implementation
    },
});
```

### Basic Test Example

```typescript
Clarinet.test({
    name: "Ensure that users can create a swap pair",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const deployer = accounts.get("deployer")!;
        const wallet1 = accounts.get("wallet_1")!;
        
        let block = chain.mineBlock([
            Tx.contractCall(
                "stackswap-swap-v1",
                "create-pair",
                [
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-wstx"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-stsw"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.liquidity-tokensoft-v1"),
                    types.ascii("wSTX-STSW"),
                    types.uint(1000000),
                    types.uint(1000000)
                ],
                wallet1.address
            ),
        ]);
        
        assertEquals(block.receipts.length, 1);
        assertEquals(block.height, 2);
        block.receipts[0].result.expectOk();
    },
});
```

## Test Examples

### Example 1: Testing Token Transfers

```typescript
Clarinet.test({
    name: "Test token transfer",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const sender = accounts.get("wallet_1")!;
        const receiver = accounts.get("wallet_2")!;
        
        let block = chain.mineBlock([
            Tx.contractCall(
                "token-stsw",
                "transfer",
                [
                    types.uint(1000),
                    types.principal(sender.address),
                    types.principal(receiver.address),
                    types.none()
                ],
                sender.address
            ),
        ]);
        
        block.receipts[0].result.expectOk().expectBool(true);
    },
});
```

### Example 2: Testing Swap Functionality

```typescript
Clarinet.test({
    name: "Test swap-x-for-y with proper slippage",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const trader = accounts.get("wallet_1")!;
        
        // First create a pair (setup)
        let setupBlock = chain.mineBlock([
            // ... create pair transaction
        ]);
        
        // Then test the swap
        let swapBlock = chain.mineBlock([
            Tx.contractCall(
                "stackswap-swap-v1",
                "swap-x-for-y",
                [
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-wstx"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-stsw"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.liquidity-tokensoft-v1"),
                    types.uint(100000), // dx (amount in)
                    types.uint(90000)   // min-dy (minimum amount out)
                ],
                trader.address
            ),
        ]);
        
        swapBlock.receipts[0].result.expectOk();
    },
});
```

### Example 3: Testing Error Conditions

```typescript
Clarinet.test({
    name: "Test swap fails with excessive slippage",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const trader = accounts.get("wallet_1")!;
        
        let block = chain.mineBlock([
            Tx.contractCall(
                "stackswap-swap-v1",
                "swap-x-for-y",
                [
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-wstx"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-stsw"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.liquidity-tokensoft-v1"),
                    types.uint(100000),
                    types.uint(999999999) // Unrealistic min-dy
                ],
                trader.address
            ),
        ]);
        
        block.receipts[0].result.expectErr(types.uint(4164)); // ERR_TOO_MUCH_SLIPPAGE
    },
});
```

### Example 4: Testing Liquidity Operations

```typescript
Clarinet.test({
    name: "Test add and remove liquidity",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const lp = accounts.get("wallet_1")!;
        
        // Add liquidity
        let addBlock = chain.mineBlock([
            Tx.contractCall(
                "stackswap-swap-v1",
                "add-to-position",
                [
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-wstx"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-stsw"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.liquidity-tokensoft-v1"),
                    types.uint(1000000),
                    types.uint(1000000)
                ],
                lp.address
            ),
        ]);
        
        addBlock.receipts[0].result.expectOk();
        
        // Remove 50% of liquidity
        let removeBlock = chain.mineBlock([
            Tx.contractCall(
                "stackswap-swap-v1",
                "reduce-position",
                [
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-wstx"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.token-stsw"),
                    types.principal("ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.liquidity-tokensoft-v1"),
                    types.uint(50) // 50%
                ],
                lp.address
            ),
        ]);
        
        removeBlock.receipts[0].result.expectOk();
    },
});
```

## Best Practices

### 1. Test Organization

- Group related tests together
- Use descriptive test names
- Test one concept per test case
- Keep tests independent and isolated

### 2. Coverage

Ensure you test:
- ✅ Happy paths (normal operation)
- ✅ Error conditions and edge cases
- ✅ Access control and permissions
- ✅ Boundary values
- ✅ State transitions

### 3. Test Data

- Use realistic test data
- Test with different account types
- Vary input amounts and parameters
- Test with edge values (0, max uint, etc.)

### 4. Assertions

```typescript
// Good: Specific assertions
block.receipts[0].result.expectOk().expectUint(1000);

// Better: Check multiple conditions
assertEquals(block.receipts.length, 1);
assertEquals(block.height, 2);
block.receipts[0].result.expectOk();
```

### 5. Setup and Teardown

```typescript
// Use helper functions for common setup
function setupPair(chain: Chain, accounts: Map<string, Account>) {
    const deployer = accounts.get("deployer")!;
    
    return chain.mineBlock([
        // Setup transactions
    ]);
}

Clarinet.test({
    name: "Test with pre-configured pair",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        setupPair(chain, accounts);
        // Test implementation
    },
});
```

## Debugging

### Using Console for Debugging

```bash
clarinet console
```

```clarity
;; Check contract state
(contract-call? .stackswap-swap-v1 get-pair-count)

;; View maps
(map-get? pairs-map u1)

;; Test function calls
(contract-call? .stackswap-swap-v1 get-pair-details 
  .token-wstx .token-stsw)
```

### Helpful Commands

```bash
# Syntax check
clarinet check

# Run specific test
clarinet test --filter "test name"

# Verbose output
clarinet test --verbose

# Generate cost reports
clarinet test --cost-reports
```

### Common Issues

1. **Contract Not Found**
   - Ensure contract names in `Clarinet.toml` match test references
   - Check contract dependencies are correct

2. **Transaction Fails**
   - Verify contract caller has sufficient balance
   - Check function arguments match contract signature
   - Review error codes in contract

3. **Map Not Found**
   - Ensure map is initialized before reading
   - Check map key format matches definition

## Additional Resources

- [Clarinet Documentation](https://docs.hiro.so/clarinet)
- [Clarity Language Reference](https://docs.stacks.co/clarity)
- [Testing Best Practices](https://book.clarity-lang.org/ch10-00-testing.html)

## Need Help?

- Review existing test examples in the repository
- Check Clarinet documentation
- Ask in StackSwap community channels
- Open an issue on GitHub

---

Happy Testing! 🧪
