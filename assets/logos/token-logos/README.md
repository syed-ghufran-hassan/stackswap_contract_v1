# StackSwap Token Logos

This directory contains token logos for tokens listed on StackSwap DEX.

## Requirements

- Logo extension should be **PNG** or **JPG**
- Image should be **128x128 pixels** exactly (no larger, no smaller)
- File should be named using the full Stacks token contract address
- Logo should be clear and recognizable at small sizes

## Token Contract Address Format

For Stacks blockchain tokens (SIP-010), addresses follow this format:
```
<deployer-address>.<contract-name>
```

**Example:**
- STSW Token: `SP3K8BC0PPEVCV7NZ6QSRWPQ2JE9E5B6N3PA0KBR9.token-stsw`
- wSTX Token: `SP3K8BC0PPEVCV7NZ6QSRWPQ2JE9E5B6N3PA0KBR9.token-wstx`

## Adding a Token Logo

1. **Prepare your logo:**
   - Create a 128x128 pixel image (PNG or JPG format)
   - Ensure the logo is clear and centered
   - Use transparent background for PNG files when possible

2. **Name the file:**
   - Use the full Stacks contract address as the filename
   - Replace `.` (dots) with `_` (underscores) in the filename
   - Add the appropriate file extension

   **Example:**
   ```
   SP3K8BC0PPEVCV7NZ6QSRWPQ2JE9E5B6N3PA0KBR9_token-stsw.png
   ```

3. **Submit your logo:**
   - Add the logo file to the appropriate network folder
   - For Stacks mainnet: `/assets/logos/token-logos/stacks/`
   - For Stacks testnet: `/assets/logos/token-logos/stacks-testnet/`
   - Submit a pull request with your addition

## Directory Structure

```
token-logos/
├── stacks/           # Stacks mainnet token logos
├── stacks-testnet/   # Stacks testnet token logos
└── README.md         # This file
```

## Guidelines

- Only SIP-010 compliant tokens are accepted
- Logos must be appropriate and professional
- No copyrighted material without permission
- The StackSwap team reserves the right to reject inappropriate logos