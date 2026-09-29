# Contract Lab Security Challenge #1

## Liquidity Vault

An educational smart contract security challenge designed to test vulnerability discovery, exploit analysis, and secure development skills.

The goal is not only to identify a vulnerability, but to understand the logic behind it, reproduce the impact, and propose a secure fix.

---

## Objective

Your objective is to:

- Identify the security flaw.
- Reproduce the attack locally.
- Explain the root cause.
- Quantify the impact.
- Propose a minimal secure fix.

A finding without a reachable execution path and a concrete impact is not a complete security finding.

---

## Environment

The challenge uses:

- Solidity: `0.8.24`
- EVM Target: `Shanghai`
- Local EVM only

Assume:

- No compiler bugs.
- No external dependencies.
- No behavior outside the provided contract.

---

## Starting State

The challenge begins with:

1. A fresh `LiquidityVault` deployment.
2. A passive user deposits exactly **100 ETH**.
3. The user receives the initial shares.
4. The attacker starts with:
   - **1 ETH**
   - **0 shares**

After the initial deposit:

- No other account interacts with the vault.
- The attacker controls a contract of their own.
- Gas costs are ignored.

---

## Rules

Allowed:

✅ Deploy attacker/helper contracts using the attacker's own budget.

Not allowed:

❌ External lenders  
❌ Impersonation  
❌ Storage modification  
❌ Forced ETH  
❌ Cheatcodes during the attack  

Test-framework funding is allowed only for initial setup.

---

## Submission Requirements

A valid submission must include:

### 1. Root Cause Explanation

Explain:

- Why the vulnerability exists.
- Which assumption or design decision caused the issue.
- Why the current implementation allows the behavior.

A vulnerability name alone is not enough.

---

### 2. Reproducible Proof of Concept

Provide:

- A working local reproduction.
- The exact call sequence.
- Expected and actual behavior.

---

### 3. Impact Analysis

Include:

- Before/after balances.
- Relevant state changes.
- Quantified impact.

---

### 4. Minimal Fix

Provide:

- The smallest practical code change.
- Explanation of why it prevents the issue.

---

### 5. Regression Test

Add a test proving:

- The vulnerability cannot be reproduced after the fix.

---

## Important Notes

This challenge is for educational purposes only.

- No real funds are involved.
- Do not attack any deployed project or service.
- This challenge does not define prize amounts, token rights, or future distributions.

---

## Security Mindset

Strong security findings are not only about discovering what breaks.

They are about understanding:

- What was trusted.
- What was assumed.
- How system behavior changes under unexpected conditions.

---

**Contract Lab**  
Clearer analysis. Safer smart contracts.
