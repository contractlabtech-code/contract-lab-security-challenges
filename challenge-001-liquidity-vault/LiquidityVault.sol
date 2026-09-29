# Contract Lab Security Challenge #1

A liquidity vault. ETH goes in, shares come out. Flash loans on the side.

It compiles under 0.8.24. It handles the happy path correctly. The math checks out
on paper.

It also contains one flaw that lets an attacker leave with most of the deposits.

---

## Your task

1. Identify the flaw.
2. Write the exact call sequence an attacker would use.
3. Quantify what can be extracted.
4. Propose the minimal fix.

A finding without a reachable path and a concrete number is not a finding.

## Scope and assumptions

- Solidity 0.8.24. Assume no compiler bugs.
- The vault holds **100 ETH** deposited by one honest user.
- The attacker starts with **1 ETH** and controls a contract of their own.
- Nothing outside this file is in scope. No governance, no upgrades, no oracles.
- Gas costs are ignored.

---

## The contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface IFlashReceiver {
    function onFlashLoan(uint256 fee, bytes calldata data) external payable;
}

contract LiquidityVault {
    uint256 public totalShares;
    mapping(address => uint256) public shares;

    address public borrower;
    uint256 public debt;
    uint256 private entered = 1;

    event Deposit(address indexed account, uint256 assets, uint256 minted);
    event Redeem(address indexed account, uint256 burned, uint256 assets);
    event Borrow(address indexed account, uint256 amount, uint256 fee);

    modifier nonReentrant() {
        require(entered == 1, "LOCKED");
        entered = 2;
        _;
        entered = 1;
    }

    function totalAssets() public view returns (uint256) {
        return address(this).balance;
    }

    function maxFlashLoan() public view returns (uint256) {
        return totalAssets() * 9 / 10;
    }

    function flashFee(uint256 amount) public pure returns (uint256) {
        return (amount + 999) / 1000;
    }

    function deposit(uint256 minShares) external payable returns (uint256 minted) {
        require(msg.value != 0, "ZERO_ASSETS");

        uint256 assetsBefore = totalAssets() - msg.value;
        uint256 supply = totalShares;

        minted = supply == 0
            ? msg.value
            : msg.value * supply / assetsBefore;

        require(minted != 0 && minted >= minShares, "SLIPPAGE");

        shares[msg.sender] += minted;
        totalShares = supply + minted;

        emit Deposit(msg.sender, msg.value, minted);
    }

    function transferShares(address to, uint256 amount) external {
        require(to != address(0) && amount != 0, "BAD_TRANSFER");

        shares[msg.sender] -= amount;
        shares[to] += amount;
    }

    function redeem(uint256 amount, uint256 minAssets)
        external
        nonReentrant
        returns (uint256 assets)
    {
        require(amount != 0, "ZERO_SHARES");

        assets = amount * totalAssets() / totalShares;

        require(assets != 0 && assets >= minAssets, "SLIPPAGE");

        shares[msg.sender] -= amount;
        totalShares -= amount;

        emit Redeem(msg.sender, amount, assets);

        (bool sent,) = payable(msg.sender).call{value: assets}("");
        require(sent, "SEND_FAILED");
    }

    function flashBorrow(uint256 amount, bytes calldata data)
        external
        nonReentrant
    {
        require(
            amount != 0 && amount <= maxFlashLoan(),
            "LOAN_LIMIT"
        );

        require(msg.sender.code.length != 0, "CONTRACT_ONLY");

        uint256 fee = flashFee(amount);

        borrower = msg.sender;
        debt = amount + fee;

        emit Borrow(msg.sender, amount, fee);

        IFlashReceiver(msg.sender).onFlashLoan{value: amount}(fee, data);

        require(debt == 0, "UNPAID");

        borrower = address(0);
    }

    function repay() external payable {
        require(
            msg.sender == borrower && debt != 0,
            "NO_ACTIVE_LOAN"
        );

        require(
            msg.value != 0 && msg.value <= debt,
            "BAD_REPAYMENT"
        );

        debt -= msg.value;
    }
}
```

---

Submissions open for 48 hours. Full writeup published after.

**Contract Lab** — clearer analysis. Safer smart contracts.
