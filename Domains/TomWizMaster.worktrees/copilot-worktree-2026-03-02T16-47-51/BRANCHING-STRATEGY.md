# GenAI-RD Branching Strategy & Protocol

## 1. Hierarchy & Tiers

We utilize a **3-Tier Waterfall Strategy** to insure stability while allowing for rapid iteration.

### Tier 1: Gold (Production) 🟡
*   **Branch:** `main`
*   **Role:** The "Source of Truth". Always stable, always deployable.
*   **Rules:**
    *   NEVER commit directly to `main`.
    *   Only accepts merges from `rc` (Release Candidate) or `stg` (Staging) after verification.
    *   Protected branch.

### Tier 2: Silver (Integration & Staging) ⚪
*   **Branch:** `stg` (and transiently `rc`)
*   **Role:** The "Melting Pot". Where all feature branches converge for integration testing.
*   **Rules:**
    *   All features merge here first.
    *   Acts as the buffer between chaos (development) and order (production).
    *   `rc` branch is created from `stg` when a release is locked.

### Tier 3: Bronze (Development) 🟤
*   **Branch:** `feature/*`, `fix/*`, `experiment/*`
*   **Role:** The "Workshop". Active development happens here.
*   **Rules:**
    *   Short-lived branches. Created from `stg`.
    *   Naming Convention: `type/description` (e.g., `feature/new-ui`, `fix/login-bug`).
    *   **MUST** be deleted after merging into `stg`.

## 2. The Workflow (The Protocol)

1.  **Start:** Update Staging.
    ```bash
    git checkout stg
    git pull origin stg
    ```
2.  **Branch:** Create your workspace.
    ```bash
    git checkout -b feature/my-cool-idea
    ```
3.  **Work & Commit:** Do your magic.
4.  **Merge:** Bring it home so it doesn't get lost.
    ```bash
    git checkout stg
    git merge feature/my-cool-idea
    ```
5.  **Cleanup:** Destroy the evidence (the branch).
    ```bash
    git branch -d feature/my-cool-idea
    ```

## 3. Latest Cleanup (Feb 2026)

*   **Consolidated:** `ready-player-one-go.ai` merged into `stg`.
*   **Deleted:** `pre`, `uat` (Obsolete/Diverged).
*   **Reset:** `rc` reset to match `stg`.
