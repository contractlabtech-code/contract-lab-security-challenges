# Contract Lab Security Challenge #1

## Liquidity Vault

A vulnerable educational smart contract challenge designed to test smart-contract security analysis skills.

The goal is not only to find a vulnerability, but to understand the logic behind it, reproduce the impact, and propose a secure fix.

---

## Objective

Your objective is to finish with:

- At least **90 ETH** across attacker-controlled addresses.
- The initial **1 ETH** is included in the final balance calculation.
- All flash loans must be fully settled.

Final state requirements:

- `debt == 0`
- `borrower == address(0)`

The attack must be completed in **one top-level attacker transaction**.

---

## Environment

The challenge uses:

- Solidity: `0.8.24`
- EVM Target: `Shanghai`
- Local EVM only

---

## Starting State

The challenge begins with:

1. A fresh `LiquidityVault` deployment.
2. A passive victim deposits exactly **100 ETH**.
3. The victim receives all initial shares.
4. The attacker starts with:
   - `1 ETH`
   - `0 shares`

After the victim deposit:

- No other account interacts with the vault.
- The attacker begins the exploit attempt.

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
- Which assumption failed.
- Why the current design allows the exploit.

A vulnerability name alone is not enough.

---

### 2. Reproducible Proof of Concept

Provide:

- Working local exploit.
- Clear reproduction steps.
- Expected and actual behavior.

---

### 3. Impact Evidence

Include:

- Before/after balances.
- Share changes.
- Final attacker-controlled assets.

---

### 4. Minimal Fix

Provide:

- The smallest practical code change.
- Explanation of why it prevents the exploit.

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

The strongest security findings are not only about discovering what breaks.

They are about understanding:

- What was trusted.
- What was assumed.
- How the system behaves under unexpected conditions.
