# Cursor 开发环境集成方案 v1.1

> 基于 Compound Engineering (CE) + Everything Claude Code (ECC) + 现有 Skills 的深度整合
> 创建日期: 2026-04-05 | 更新日期: 2026-04-05
> v1.1: 增加进化策略体系、Token 持续优化框架、按需扩展候选库

---

## 一、设计哲学

```
CE  = 工作流引擎（HOW — 怎么干活）
ECC = 编码约束层（WHAT — 遵守什么规则）
Skills = 领域知识库（KNOW — 懂什么知识）
```

三者分层互补，不重叠、不冲突。

### 核心原则

1. **CE 不动** — 插件自动管理，41 个 skills 保持原样
2. **Rules 做减法** — 只导入对 Cursor 有效的 ECC 规则，去除 Claude Code 专属概念
3. **Skills 做整合** — 去重、合并、补充，每个领域只保留一个权威来源
4. **可扩展优先** — 新项目新语言可通过添加文件即时扩展，无需修改现有内容

---

## 二、目标架构

```
┌──────────────────────────────────────────────────────────────┐
│                    Cursor Agent 运行时                         │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Layer 0: Cursor 内置 Skills (7个，系统管理，不动)              │
│    create-rule, create-skill, create-subagent,               │
│    migrate-to-skills, shell, update-cursor-settings, babysit │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Layer 1: CE Plugin Skills (41个，插件管理，不动)              │
│    工作流: brainstorm → plan → work → review → ship           │
│    Git: commit, PR, worktree, branch cleanup                 │
│    审查: 30+ reviewer subagent types                          │
│    前端: frontend-design (CE版)                               │
│    杂项: todo, onboarding, reproduce-bug, etc.               │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Layer 2: 工作区 Rules (.cursor/rules/) ← ECC 改造导入        │
│    ┌─ common-* (6个, alwaysApply: true)                      │
│    │  编码风格、安全、测试、Git、模式、性能                      │
│    └─ {lang}-* (按语言 glob 匹配)                             │
│       Go/TS/Python/Kotlin/Swift/PHP 各5个                    │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Layer 3: 用户级 Skills (~/.cursor/skills/) ← 整合后          │
│    ┌─ 保留 (11个): 无替代的领域知识                            │
│    ├─ 升级 (3个): 合并 ECC 精华后增强                          │
│    ├─ 退役 (3个): CE 已覆盖，避免冲突                          │
│    └─ 新增 (7个): 从 ECC 引入的独特能力                        │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Layer 4: 扩展框架 (约定驱动，面向未来)                         │
│    ┌─ .cursor/rules/{lang}-{aspect}.md  ← 新语言规则          │
│    ├─ ~/.cursor/skills/{domain}/SKILL.md ← 新领域知识         │
│    └─ docs/evolution-log.md              ← 进化记录           │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## 三、Layer 2 — ECC Rules 导入方案

### 3.1 Common Rules（通用规则）

| ECC 原始文件 | 操作 | 改造要点 |
|------------|------|---------|
| `common-coding-style.md` | **导入** | 原样可用，`alwaysApply: true` |
| `common-git-workflow.md` | **导入** | 删除 `~/.claude/settings.json` 引用 |
| `common-patterns.md` | **导入** | 原样可用 |
| `common-security.md` | **改造** | 删除 "Use security-reviewer agent"，改为通用指引 |
| `common-testing.md` | **改造** | 删除 "Use tdd-guide agent"，保留 TDD 流程 |
| `common-performance.md` | **改造** | 删除 Claude Code 模型选择和快捷键，保留 Context Window 管理策略 |
| `common-agents.md` | **丢弃** | 整个内容依赖 `~/.claude/agents/`，Cursor 无法使用 |
| `common-hooks.md` | **丢弃** | PreToolUse/PostToolUse 是 Claude Code 专属 |
| `common-development-workflow.md` | **改造** | 重写为与 CE 工作流对齐的版本 |

### 3.2 语言专属 Rules（按 glob 匹配）

ECC 为每种语言提供 5 个维度的规则：`coding-style`、`patterns`、`security`、`testing`、`hooks`。

| 语言 | 文件数 | globs | 导入策略 |
|------|-------|-------|---------|
| **TypeScript** | 5 | `**/*.ts, **/*.tsx, **/*.js, **/*.jsx` | 全部导入，`hooks` 改造 |
| **Go** | 5 | `**/*.go, **/go.mod, **/go.sum` | 全部导入，`hooks` 改造 |
| **Python** | 5 | `**/*.py, **/*.pyi` | 全部导入，`hooks` 改造 |
| **Kotlin** | 5 | `**/*.kt, **/*.kts, **/build.gradle.kts` | 全部导入，`hooks` 改造 |
| **Swift** | 5 | `**/*.swift, **/Package.swift` | 按需，`hooks` 改造 |
| **PHP** | 5 | `**/*.php, **/composer.json` | 按需，`hooks` 改造 |

**hooks 改造说明**：每个语言的 `{lang}-hooks.md` 引用了 Claude Code 的 hook 系统，需要：
- 删除 hook 注册的描述
- 保留其中有价值的检查逻辑作为 "质量提醒"

### 3.3 改造后的 common-security.md 示例

```markdown
---
description: "Security: mandatory checks, secret management, response protocol"
alwaysApply: true
---
# Security Guidelines

## Mandatory Security Checks

Before ANY commit:
- [ ] No hardcoded secrets (API keys, passwords, tokens)
- [ ] All user inputs validated
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (sanitized HTML)
- [ ] CSRF protection enabled
- [ ] Authentication/authorization verified
- [ ] Rate limiting on all endpoints
- [ ] Error messages don't leak sensitive data

## Secret Management

- NEVER hardcode secrets in source code
- ALWAYS use environment variables or a secret manager
- Validate that required secrets are present at startup
- Rotate any secrets that may have been exposed

## Security Response Protocol

If security issue found:
1. STOP immediately
2. Run ce:review with security focus
3. Fix CRITICAL issues before continuing
4. Rotate any exposed secrets
5. Review entire codebase for similar issues
```

### 3.4 改造后的 common-development-workflow.md 示例

```markdown
---
description: "Development workflow aligned with CE: brainstorm, plan, work, review, ship"
alwaysApply: true
---
# Development Workflow

## Feature Implementation Pipeline

1. **Explore & Define** (ce:brainstorm)
   - Clarify requirements and scope
   - Produce requirements document

2. **Plan** (ce:plan)
   - Create implementation plan from requirements
   - Define implementation units and dependencies

3. **Execute** (ce:work)
   - Follow plan, write tests, implement code
   - Incremental commits after each logical unit

4. **Review** (ce:review)
   - Multi-perspective code review before PR
   - Fix critical and high issues

5. **Ship** (git-commit-push-pr)
   - Create PR with comprehensive description
   - Include test plan and monitoring notes
```

### 3.5 改造后的 common-performance.md 示例

```markdown
---
description: "Performance: context management, build troubleshooting"
alwaysApply: true
---
# Performance Optimization

## Context Window Management

Avoid last 20% of context window for:
- Large-scale refactoring
- Feature implementation spanning multiple files
- Debugging complex interactions

Lower context sensitivity tasks:
- Single-file edits
- Independent utility creation
- Documentation updates
- Simple bug fixes

## Build Troubleshooting

If build fails:
1. Analyze error messages carefully
2. Fix incrementally, one error at a time
3. Verify after each fix
4. Check for similar issues in related files
```

---

## 四、Layer 3 — User Skills 整合方案

### 4.1 整合决策矩阵

| # | 现有 Skill | 决策 | 理由 | 动作 |
|---|-----------|------|------|------|
| 1 | `api-design` | **保留** | 中文业务 API 规范，CE/ECC 无等价物 | 无需改动 |
| 2 | `backend-patterns` | **保留** | 深度后端架构（缓存/事件/RBAC），CE 无此深度 | 无需改动 |
| 3 | `coding-standards` | **升级** | 与 ECC `common-coding-style` 重叠，合并精华 | 合并 ECC 的 Code Quality Checklist |
| 4 | `error-handling` | **保留** | Go+JS 双语错误处理，业务错误体系，独特 | 无需改动 |
| 5 | `file-management` | **保留** | 中文项目结构模板，独特的文档管理体系 | 无需改动 |
| 6 | `frontend-design` | **退役** | CE 的 `frontend-design` 更强大（截图验证、设计系统检测） | 标记为 archived |
| 7 | `frontend-patterns` | **保留** | React/Next.js 深度模式（App Router/状态管理/虚拟化），CE 不覆盖此深度 | 无需改动 |
| 8 | `go-backend` | **保留** | 中文 Go 开发规范，业务场景匹配 | 无需改动 |
| 9 | `project-planning` | **退役** | CE `ce:brainstorm` + `ce:plan` 完全覆盖且更强 | 标记为 archived |
| 10 | `report-generation` | **保留** | 中文日报/周报/月报模板，CE 无此能力 | 无需改动 |
| 11 | `security-best-practices` | **升级** | 与 ECC security rule 部分重叠，合并三员分离+RBAC 精华 | 合并 ECC 安全检查清单 |
| 12 | `security-review` | **保留** | OWASP Top 10 + 深度审计方法论，与 CE reviewer 互补 | 无需改动 |
| 13 | `skill-creator` | **退役** | Cursor 内置 `create-skill` 和 CE 的 `create-skill` 已覆盖 | 标记为 archived |
| 14 | `sqlite-database` | **保留** | SQLite 专业知识，CE/ECC 无此领域 | 无需改动 |
| 15 | `task-tracking` | **升级** | CE 有 `todo-create/resolve/triage`，但你的版本有独特的甘特图和优先级体系 | 简化，移除与 CE todo 重叠的部分 |
| 16 | `tdd-workflow` | **保留** | 深度 TDD 方法论（Mock 模式/覆盖率策略），CE 无此深度 | 无需改动 |
| 17 | `workflow-orchestration` | **退役** → **降级为参考** | CE `ce:work` 是真正可执行的工作流，你的是声明式模板 | 保留为只读参考，不作为 active skill |

### 4.2 从 ECC 新增的 Skills

| # | ECC Skill | 加入理由 | 注意事项 |
|---|-----------|---------|---------|
| 1 | `documentation-lookup` | 你已配置 Context7 MCP，此 skill 教 Agent 正确使用它查文档 | 直接可用 |
| 2 | `mcp-server-patterns` | MCP 服务器开发指南，独特且实用 | 直接可用 |
| 3 | `bun-runtime` | Bun 运行时指南，Node.js 替代方案 | 直接可用 |
| 4 | `nextjs-turbopack` | Next.js 16+ Turbopack 知识 | 直接可用 |
| 5 | `content-engine` | 跨平台内容创作指南 | 直接可用 |
| 6 | `article-writing` | 长文写作方法论，反 AI 味道 | 直接可用 |
| 7 | `frontend-slides` | HTML 演示文稿生成，独特能力 | 直接可用 |

### 4.3 整合后的最终 Skills 清单

```
~/.cursor/skills/                   # 整合后: 21 个 active skills
├── api-design/                     # [保留] 中文 RESTful API 规范
├── backend-patterns/               # [保留] 后端架构深度模式
├── coding-standards/               # [升级] 合并 ECC 精华
├── error-handling/                  # [保留] Go+JS 错误处理
├── file-management/                # [保留] 中文文档管理
├── frontend-patterns/              # [保留] React/Next.js 深度模式
├── go-backend/                     # [保留] 中文 Go 开发规范
├── report-generation/              # [保留] 中文报告模板
├── security-best-practices/        # [升级] 合并 ECC 安全清单
├── security-review/                # [保留] OWASP 审计方法论
├── sqlite-database/                # [保留] SQLite 专业知识
├── task-tracking/                  # [升级] 精简，与 CE todo 互补
├── tdd-workflow/                   # [保留] 深度 TDD 方法论
├── documentation-lookup/           # [新增] Context7 文档查询
├── mcp-server-patterns/            # [新增] MCP 服务器开发
├── bun-runtime/                    # [新增] Bun 运行时
├── nextjs-turbopack/               # [新增] Next.js Turbopack
├── content-engine/                 # [新增] 跨平台内容创作
├── article-writing/                # [新增] 长文写作
├── frontend-slides/                # [新增] HTML 演示文稿
├── _evolution/                     # [新增] 进化框架 (见第六章)
│   └── SKILL.md
│
├── _archived/                      # 退役 skills 备份目录
│   ├── frontend-design/            # [退役] → CE frontend-design 替代
│   ├── project-planning/           # [退役] → CE brainstorm+plan 替代
│   ├── skill-creator/              # [退役] → Cursor 内置替代
│   └── workflow-orchestration/     # [退役] → CE work 替代
```

---

## 五、完整 Token 预算分析

### 5.1 alwaysApply Rules 的 Context 开销

| 类别 | 文件数 | 估算 tokens | 说明 |
|------|-------|------------|------|
| Common Rules (alwaysApply) | 6 | ~1500 | 每个约 250 tokens |
| 语言 Rules (glob 匹配) | 按需 0-5 | ~0-800 | 只在打开对应文件时加载 |
| Skills 描述注入 | 21 | ~1000 | 只注入 description，不注入全文 |
| CE Skills 描述注入 | 41 | ~2000 | 同上 |
| **总计** | — | **~4500-5300** | 占 200K context 的 ~2.5% |

### 5.2 对比不导入 ECC Rules 的情况

| 场景 | Token 开销 | 收益 |
|------|-----------|------|
| 当前（无 rules） | ~3000 | 无编码约束 |
| 导入后 | ~5300 | 编码风格、安全、测试、Git 全面约束 |
| 如果全部 alwaysApply | ~8000+ | 浪费，不推荐 |

**结论**：使用 glob 匹配的语言规则方案，只增加约 2300 tokens，性价比极高。

---

## 六、进化策略与 Token 持续优化体系

### 6.1 核心进化模型：CALOR 循环

```
                    ┌─────────────┐
                    │  Candidate  │ ← ECC 候选库 / 社区 / 自研
                    │   (候选)     │
                    └──────┬──────┘
                           │ 评估：是否填补空白？token 成本？
                           ▼
                    ┌─────────────┐
                    │   Assess    │ ← 需求匹配 + Token 预算检查
                    │   (评估)     │
                    └──────┬──────┘
                           │ 通过 → 导入；不通过 → 留在候选库
                           ▼
                    ┌─────────────┐
                    │    Load     │ ← 复制 + 适配 frontmatter + 验证
                    │   (加载)     │
                    └──────┬──────┘
                           │ 使用一段时间后
                           ▼
                    ┌─────────────┐
                    │  Optimize   │ ← 压缩 description、精简内容、调 globs
                    │   (优化)     │
                    └──────┬──────┘
                           │ 季度审计
                           ▼
                    ┌─────────────┐
                    │   Review    │ ← 使用频率检查 + 退役决策
                    │   (审查)     │
                    └──────┴──────┘
                           │
                    ┌──────┴──────┐
                    │  Archive    │ ← 长期未用 → _archived/
                    │  or Evolve  │ ← 仍需要 → 下一轮优化
                    └─────────────┘
```

**CALOR = Candidate → Assess → Load → Optimize → Review**

每个 skill/rule 在生命周期中持续流转，确保系统始终精简高效。

### 6.2 Token 持续优化体系（四层防线）

#### 第一层：加载时优化（静态）

在 skill/rule 被加载到 context 之前减少开销。

| 优化策略 | 方法 | 预期节省 |
|---------|------|---------|
| **globs 精确匹配** | 语言 rules 只在打开对应文件时加载，不用 `alwaysApply` | ~60% 语言规则 token |
| **description 精炼** | 每个 skill description 控制在 15 个英文单词内 | ~30% 描述层 token |
| **去重** | 同一知识点只在一个 skill/rule 中出现 | 避免 2-3x 重复消耗 |
| **分层加载** | common rules (always) + lang rules (glob) + skills (on-demand) | 按需分级 |

**description 精炼示例：**

```
❌ 长: "RESTful API design guidelines including URL naming, request/response 
   formats, HTTP status codes, pagination, and error handling. Use when 
   designing APIs, creating new endpoints, or reviewing API implementations."
   → 33 words ≈ 45 tokens

✅ 短: "REST API design: naming, status codes, pagination, errors. 
   Use for API design and review."
   → 15 words ≈ 20 tokens

   每个 skill 节省 ~25 tokens × 21 skills = ~525 tokens
```

#### 第二层：运行时优化（动态）

在对话过程中减少不必要的 token 消耗。

```
策略 A: 单次读取原则
  - Agent 读取某个 skill 后，该 skill 内容已在 context 中
  - 不要在同一对话中重复读取同一 skill
  - 如需引用，直接引用而非重新读取

策略 B: 渐进式深入
  - 第一次：只读 skill 的 description（~20 tokens）
  - 确认需要后：读取完整 skill（~300-800 tokens）
  - 避免"读了不用"的浪费

策略 C: Context Window 感知
  - 当 context 已使用 >70%：避免启动新的多文件任务
  - 当 context 已使用 >85%：只做单文件编辑和简单修复
  - 如需大型任务：开新对话
```

#### 第三层：周期性优化（定期审计）

每季度执行一次"瘦身审计"，持续压缩 token 总量。

```
季度审计清单:
┌─────────────────────────────────────────────────────────────────┐
│ □ 1. 使用频率分析                                                │
│      过去 3 个月中，哪些 skills 从未被 Agent 选择？               │
│      → 移到 _archived/                                          │
│                                                                  │
│ □ 2. Description 瘦身                                            │
│      检查每个 description 是否超过 15 words                       │
│      → 精简到最低有效长度                                         │
│                                                                  │
│ □ 3. 内容去冗                                                    │
│      检查 skills 间是否有新增的内容重叠                            │
│      → 合并到一个 skill，退役另一个                               │
│                                                                  │
│ □ 4. Rules 版本检查                                               │
│      框架版本、API 变更是否让某些规则过时                          │
│      → 更新或删除过时内容                                         │
│                                                                  │
│ □ 5. CE/ECC 上游同步                                             │
│      CE 插件是否有新功能覆盖了某些 skills                          │
│      ECC 上游是否有值得同步的改进                                  │
│      → 退役被覆盖的 skills，选择性合并改进                        │
│                                                                  │
│ □ 6. Token 预算重新测算                                          │
│      更新第五章 Token 预算表                                      │
│      → 确保总预算不超过 context 的 5%                             │
│                                                                  │
│ □ 7. 更新 evolution-log.md                                       │
│      记录所有变更                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### 第四层：进化式优化（持续改进）

基于实际使用反馈驱动优化方向。

```
反馈信号 → 优化行动:

1. "Agent 选错了 skill"
   → 修改 description 中的触发条件（WHEN），使其更精确
   → 检查是否有多个 skills 的 description 太相似

2. "Agent 没有选择该 skill"
   → 检查 description 是否包含正确的关键词
   → 确认 skill 的 WHAT 和 WHEN 描述是否匹配实际使用场景

3. "context 不够用了"
   → 检查 alwaysApply rules 数量，考虑将低频 rules 改为 glob
   → 精简 skill 内容，删除示例代码中的冗余部分
   → 合并小型相关 skills 为一个综合 skill

4. "某个领域缺少指导"
   → 从候选库(第十一章)中评估并导入合适的 skill
   → 或基于项目经验创建新的自定义 skill
```

### 6.3 Token 预算控制目标

```
总目标: 常规加载 token ≤ 200K context 的 3%（约 6000 tokens）

分配:
  alwaysApply Rules (6个)     ≤ 1500 tokens   (25%)
  Skills 描述 (21个 user)     ≤  450 tokens   (7.5%)
  Skills 描述 (41个 CE)       ≤ 2000 tokens   (33%)
  Glob Rules (按需 0-5个)     ≤  800 tokens   (13%)
  系统保留                     ≤ 1250 tokens   (21.5%)
  ──────────────────────────────────────────────
  合计                        ≤ 6000 tokens   (3%)

红线: 如果 token 占比超过 5%，必须触发瘦身审计
```

### 6.4 新语言扩展流程

当你开始使用新语言（如 Rust、Java、C#）时：

```
Step 1: 查阅候选库(第十一章)是否有现成的 ECC 资源
  → 如有：复制 + 适配 frontmatter → .cursor/rules/

Step 2: 创建最多 5 个语言规则文件（glob 匹配，不用 alwaysApply）
  .cursor/rules/{lang}-coding-style.md   (globs: ["**/*.rs"])
  .cursor/rules/{lang}-patterns.md
  .cursor/rules/{lang}-security.md
  .cursor/rules/{lang}-testing.md
  .cursor/rules/{lang}-hooks.md          (改造为质量提醒)

Step 3: 可选 — 从候选库导入或创建语言专属 skill
  ~/.cursor/skills/{lang}-backend/SKILL.md

Step 4: Token 预算检查
  → 新增 rules 的 token ≤ 800
  → 总预算仍在 3% 以内

Step 5: 记录到 evolution-log.md
```

模板格式（以 Rust 为例）：

```markdown
---
description: "Rust: ownership, error handling, formatting. Use for .rs files."
globs: ["**/*.rs", "**/Cargo.toml"]
alwaysApply: false
---
# Rust Coding Style

## Ownership & Borrowing
- Prefer borrowing over cloning
- Use lifetimes explicitly when compiler requires

## Error Handling
- Use `thiserror` for library errors, `anyhow` for application errors
- Always propagate errors with `?` operator

## Formatting
- `cargo fmt` is mandatory
- `cargo clippy` on every commit
```

### 6.5 新领域 Skill 扩展

当你进入新业务领域（如 AI/ML、DevOps、移动端）时：

```
~/.cursor/skills/{domain}/SKILL.md

命名规范:
  - 小写 + 连字符
  - 64 字符以内
  - description ≤ 15 英文单词（WHAT + WHEN）

流程:
  1. 从候选库(第十一章)查找 → 有则导入改造，无则自建
  2. 精简 description，确保不与现有 skills 的 description 重叠
  3. Token 预算检查 → 总描述层仍在预算内
  4. 记录到 evolution-log.md
```

### 6.6 进化记录文件

```markdown
# docs/evolution-log.md

## 进化记录

| 日期 | 操作 | 类型 | 名称 | 来源 | 原因 | Token 影响 |
|------|------|------|------|------|------|-----------|
| 2026-04-05 | 初始化 | 方案 | v1.0 | ALL | 三系统整合 | 基线 ~5300 |
| 2026-04-05 | 升级 | 方案 | v1.1 | — | 增加进化策略+候选库 | 无变化 |
| | 新增 | rule | rust-* | ECC | 开始 Rust 项目 | +400 |
| | 退役 | skill | xxx | — | 3个月未使用 | -60 |
| | 优化 | skill | xxx | — | description 瘦身 | -25 |
```

---

## 七、实施路线图

### Phase 1: Rules 导入（立即可执行）

```
1. 创建 .cursor/rules/ 目录
2. 复制 ECC common-* rules（6个，改造后的版本）
3. 复制 ECC 语言 rules（Go/TS/Python/Kotlin 各5个 = 20个）
4. 验证 glob 匹配正确
```

### Phase 2: Skills 整合（立即可执行）

```
1. 从 ECC .cursor/skills/ 复制 7 个新 skill 到 ~/.cursor/skills/
2. 将 3 个退役 skill 移到 _archived/ 子目录
3. 升级 3 个 skill（coding-standards, security-best-practices, task-tracking）
4. 创建 _evolution/ skill
```

### Phase 3: 验证（Phase 1-2 完成后）

```
1. 打开不同语言文件，确认 glob rules 正确加载
2. 测试 CE 工作流（brainstorm → plan → work → review）是否正常
3. 确认退役 skills 不再被 Agent 调用
4. 检查 context token 使用量是否在预期范围
```

### Phase 4: 持续进化（长期）

```
1. 按需添加新语言 rules
2. 按需添加新领域 skills
3. 跟踪 CE 和 ECC 上游更新
4. 定期健康检查
```

---

## 八、风险与缓解

| 风险 | 可能性 | 影响 | 缓解措施 |
|------|-------|------|---------|
| Rules 与 CE skills 指令冲突 | 低 | 中 | Rules 只定义约束（WHAT），不涉及工作流（HOW） |
| 过多 alwaysApply rules 浪费 context | 中 | 低 | 只有 6 个 common rules 是 alwaysApply |
| ECC 上游更新导致规则过时 | 中 | 低 | evolution-log 追踪，定期同步 |
| 退役 skills 的知识丢失 | 低 | 低 | 移到 _archived/ 而非删除 |
| 新开发者不了解体系 | 中 | 中 | evolution-log + 本文档作为入口 |

---

## 九、文件清单总览

### 将创建/修改的文件

```
.cursor/
├── settings.json                          # 已存在，不动
└── rules/                                 # 新建目录
    ├── common-coding-style.md             # ← ECC (原样)
    ├── common-git-workflow.md             # ← ECC (微调)
    ├── common-patterns.md                 # ← ECC (原样)
    ├── common-security.md                 # ← ECC (改造)
    ├── common-testing.md                  # ← ECC (改造)
    ├── common-performance.md              # ← ECC (改造)
    ├── common-development-workflow.md     # ← ECC (重写)
    ├── typescript-coding-style.md         # ← ECC (原样)
    ├── typescript-patterns.md             # ← ECC (原样)
    ├── typescript-security.md             # ← ECC (原样)
    ├── typescript-testing.md              # ← ECC (原样)
    ├── typescript-hooks.md                # ← ECC (改造)
    ├── golang-coding-style.md             # ← ECC (原样)
    ├── golang-patterns.md                 # ← ECC (原样)
    ├── golang-security.md                 # ← ECC (原样)
    ├── golang-testing.md                  # ← ECC (原样)
    ├── golang-hooks.md                    # ← ECC (改造)
    ├── python-coding-style.md             # ← ECC (原样)
    ├── python-patterns.md                 # ← ECC (原样)
    ├── python-security.md                 # ← ECC (原样)
    ├── python-testing.md                  # ← ECC (原样)
    ├── python-hooks.md                    # ← ECC (改造)
    ├── kotlin-coding-style.md             # ← ECC (原样)
    ├── kotlin-patterns.md                 # ← ECC (原样)
    ├── kotlin-security.md                 # ← ECC (原样)
    ├── kotlin-testing.md                  # ← ECC (原样)
    └── kotlin-hooks.md                    # ← ECC (改造)

~/.cursor/skills/                          # 整合后
    (21 个 active skills，详见 4.3 节)

docs/
├── cursor-integration-plan.md             # 本文档
└── evolution-log.md                       # 进化记录
```

---

## 十、执行确认

本方案完成后的系统规模：

| 组件 | 数量 | 来源 |
|------|------|------|
| Cursor 内置 Skills | 7 | 系统管理 |
| CE Plugin Skills | 41 | 插件管理 |
| Workspace Rules | 27 | ECC 改造导入 |
| User Skills | 21 | 整合后 |
| **候选库** | **194** | ECC agents + skills（按需扩展） |
| **总计活跃** | **96** | 四层协同 |

用户确认后，开始逐步执行 Phase 1-4。

---

## 十一、按需扩展候选库（ECC Agents & Skills）

> **定位**：这是你的"军火库"——不直接加载，不消耗 token，只在需要时按 CALOR 流程（第六章）评估导入。

### 11.1 ECC Agents 候选目录（38个）

ECC Agents 转换为 Cursor Skill 时需要：
- 移除 `tools` 和 `model` frontmatter（Claude Code 专属）
- 保留 `description` 并精简到 ≤15 words
- 将 agent 委托指令改为通用指导

#### A 类：CE 已覆盖 — 无需转换（22个）

这些 agent 的功能已被 CE 的 subagent 或 skill 完全覆盖。

| # | Agent | CE 等价物 | 说明 |
|---|-------|----------|------|
| 1 | `architect` | `ce:plan` + `architecture-strategist` | 架构设计 |
| 2 | `planner` | `ce:plan` | 实施规划 |
| 3 | `code-reviewer` | `ce:review` (30+ reviewers) | 代码审查 |
| 4 | `security-reviewer` | `security-reviewer` subagent | 安全审查 |
| 5 | `tdd-guide` | `testing-reviewer` + 你的 `tdd-workflow` | TDD 指导 |
| 6 | `performance-optimizer` | `performance-oracle` subagent | 性能优化 |
| 7 | `refactor-cleaner` | `code-simplicity-reviewer` | 重构清理 |
| 8 | `database-reviewer` | `data-integrity-guardian` | 数据库审查 |
| 9 | `e2e-runner` | `test-browser` skill | E2E 测试 |
| 10 | `docs-lookup` | `documentation-lookup` skill + Context7 | 文档查询 |
| 11 | `doc-updater` | `onboarding` skill | 文档更新 |
| 12 | `typescript-reviewer` | `kieran-typescript-reviewer` | TS 审查 |
| 13 | `python-reviewer` | `kieran-python-reviewer` | Python 审查 |
| 14 | `go-reviewer` | `correctness-reviewer` | Go 审查 |
| 15 | `kotlin-reviewer` | `correctness-reviewer` | Kotlin 审查 |
| 16 | `rust-reviewer` | `correctness-reviewer` | Rust 审查 |
| 17 | `cpp-reviewer` | `correctness-reviewer` | C++ 审查 |
| 18 | `csharp-reviewer` | `correctness-reviewer` | C# 审查 |
| 19 | `java-reviewer` | `correctness-reviewer` | Java 审查 |
| 20 | `flutter-reviewer` | `correctness-reviewer` | Flutter 审查 |
| 21 | `dart-build-resolver` | 同 `build-error-resolver` 模式 | Dart 构建 |
| 22 | `loop-operator` | Cursor 暂无等价自主循环能力 | 自主循环 |

#### B 类：有独特价值 — 推荐按需转换为 Skill（9个）

这些 agent 提供了 CE 未覆盖的专门能力，值得在需要时转换。

| # | Agent | 独特价值 | 适用场景 | 转换难度 |
|---|-------|---------|---------|---------|
| 1 | `build-error-resolver` | 通用构建错误诊断方法论 | 任何语言构建失败 | ★☆☆ 简单 |
| 2 | `go-build-resolver` | Go 专属: go vet/build 错误修复 | Go 项目 | ★☆☆ 简单 |
| 3 | `java-build-resolver` | Maven/Gradle 错误修复 | Java/Spring Boot | ★☆☆ 简单 |
| 4 | `kotlin-build-resolver` | Kotlin/Gradle 错误修复 | Kotlin/Android | ★☆☆ 简单 |
| 5 | `rust-build-resolver` | Cargo/borrow checker 错误修复 | Rust 项目 | ★☆☆ 简单 |
| 6 | `cpp-build-resolver` | CMake/链接错误修复 | C++ 项目 | ★☆☆ 简单 |
| 7 | `pytorch-build-resolver` | CUDA/tensor 错误修复 | PyTorch ML 项目 | ★☆☆ 简单 |
| 8 | `healthcare-reviewer` | 临床安全 + PHI 合规 + 医疗数据完整性 | 医疗健康应用 | ★★☆ 中等 |
| 9 | `gan-planner` | 产品规格展开 + 评估标准制定 | AI 驱动开发 | ★★☆ 中等 |

#### C 类：特殊用途 — 暂不推荐转换（7个）

这些 agent 依赖 Claude Code 的特殊能力或特定管道架构。

| # | Agent | 原因 |
|---|-------|------|
| 1 | `chief-of-staff` | 依赖多通道通信工具(email/Slack/LINE) |
| 2 | `opensource-forker` | 三阶段管道架构，需配合 sanitizer+packager |
| 3 | `opensource-sanitizer` | 同上，管道中间环节 |
| 4 | `opensource-packager` | 同上，管道终端环节 |
| 5 | `harness-optimizer` | 依赖 eval harness 基础设施 |
| 6 | `gan-evaluator` | 依赖 Playwright 实时评估循环 |
| 7 | `gan-generator` | 依赖与 evaluator 的多 agent 协作 |

---

### 11.2 ECC Skills 候选目录（156个）

ECC Skills 转换为 Cursor Skill 时只需：
- 移除 `origin` frontmatter 字段
- 精简 `description` 到 ≤15 words
- 验证内容无 Claude Code 专属引用

按领域分为 7 大类：

#### 类别 1：语言与框架（~48个）— 高价值优先

当你启动新语言/框架的项目时，从这里选取。

**通用语言：**

| Skill | 用途 | 与现有体系关系 |
|-------|------|---------------|
| `golang-patterns` | Go 惯用模式 | 补充你的 `go-backend` skill |
| `golang-testing` | Go 测试模式 | 补充 `tdd-workflow` |
| `python-patterns` | Python 惯用模式 | 新增能力 |
| `python-testing` | pytest + TDD | 补充 `tdd-workflow` |
| `rust-patterns` | Rust 所有权/错误处理 | 新增能力 |
| `rust-testing` | Rust 测试模式 | 新增能力 |
| `kotlin-patterns` | Kotlin 惯用模式 | 新增能力 |
| `kotlin-testing` | Kotlin 测试模式 | 新增能力 |
| `kotlin-coroutines-flows` | 协程 + Flow 异步 | 新增能力 |
| `kotlin-exposed-patterns` | Exposed ORM | 新增能力 |
| `kotlin-ktor-patterns` | Ktor 框架 | 新增能力 |
| `cpp-coding-standards` | C++ Core Guidelines | 新增能力 |
| `cpp-testing` | GoogleTest/CTest | 新增能力 |
| `csharp-testing` | xUnit/.NET 测试 | 新增能力 |
| `perl-patterns` | Modern Perl 5.36+ | 新增能力 |
| `perl-security` | Perl 安全模式 | 新增能力 |
| `perl-testing` | Perl Test2::V0 | 新增能力 |

**移动端/跨平台：**

| Skill | 用途 |
|-------|------|
| `dart-flutter-patterns` | Flutter 全栈模式 |
| `compose-multiplatform-patterns` | KMP Compose 模式 |
| `android-clean-architecture` | Android Clean Architecture |
| `swift-concurrency-6-2` | Swift 6.2 并发模型 |
| `swift-actor-persistence` | Swift Actor 持久化 |
| `swift-protocol-di-testing` | Swift 协议式 DI |
| `swiftui-patterns` | SwiftUI 架构模式 |

**Web 框架：**

| Skill | 用途 | 备注 |
|-------|------|------|
| `nextjs-turbopack` | ★ 已列入 Phase 2 导入 | — |
| `nestjs-patterns` | NestJS 后端 | 新增能力 |
| `nuxt4-patterns` | Nuxt 4 SSR | 新增能力 |
| `django-patterns` | Django 架构模式 | 新增能力 |
| `django-security` | Django 安全 | 新增能力 |
| `django-tdd` | Django TDD | 新增能力 |
| `django-verification` | Django 验证循环 | 新增能力 |
| `laravel-patterns` | Laravel 架构模式 | 新增能力 |
| `laravel-security` | Laravel 安全 | 新增能力 |
| `laravel-tdd` | Laravel TDD | 新增能力 |
| `laravel-verification` | Laravel 验证循环 | 新增能力 |
| `laravel-plugin-discovery` | Laravel 插件发现 | 新增能力 |
| `springboot-patterns` | Spring Boot 架构 | 新增能力 |
| `springboot-security` | Spring Security | 新增能力 |
| `springboot-tdd` | Spring Boot TDD | 新增能力 |
| `springboot-verification` | Spring Boot 验证 | 新增能力 |
| `dotnet-patterns` | .NET 架构模式 | 新增能力 |
| `jpa-patterns` | JPA 数据访问 | 新增能力 |

#### 类别 2：架构与工程实践（~18个）— 中等价值

| Skill | 用途 | 与现有体系关系 |
|-------|------|---------------|
| `api-design` | REST API 设计 | 你已有同名 skill，可合并精华 |
| `backend-patterns` | Node.js 后端 | 你已有同名 skill |
| `coding-standards` | TS/JS 编码标准 | 你已有同名 skill |
| `frontend-patterns` | React/Next 前端 | 你已有同名 skill |
| `architecture-decision-records` | ADR 决策记录 | 新增，有独特价值 |
| `hexagonal-architecture` | 六边形架构 | 新增，架构补充 |
| `design-system` | 设计系统 | CE frontend-design 已覆盖部分 |
| `database-migrations` | 跨 ORM 迁移模式 | 新增，补充 sqlite-database |
| `postgres-patterns` | PostgreSQL 优化 | 新增，补充数据库知识 |
| `docker-patterns` | Docker 容器化 | 新增能力 |
| `deployment-patterns` | 部署模式 | 新增能力 |
| `git-workflow` | Git 工作流 | ECC common-git-workflow 已覆盖 |
| `e2e-testing` | E2E 测试 | CE test-browser 已覆盖 |
| `benchmark` | 性能基准测试 | 新增能力 |
| `content-hash-cache-pattern` | 内容哈希缓存 | 特定模式，按需 |
| `verification-loop` | 验证循环 | CE ce:work 已覆盖 |
| `regex-vs-llm-structured-text` | 正则 vs LLM 决策 | 独特，按需 |
| `security-review` | 安全审查 | 你已有同名 skill |

#### 类别 3：AI/ML 工程（~14个）— 按项目需求

| Skill | 用途 | 推荐度 |
|-------|------|--------|
| `pytorch-patterns` | PyTorch 深度学习 | ★★★ ML 项目必备 |
| `claude-api` | Anthropic Claude API | ★★★ AI 应用必备 |
| `cost-aware-llm-pipeline` | LLM 成本优化 | ★★★ AI 应用推荐 |
| `prompt-optimizer` | 提示词优化 | ★★☆ 有用 |
| `ai-first-engineering` | AI 优先工程模型 | ★★☆ 团队管理 |
| `ai-regression-testing` | AI 回归测试 | ★★☆ AI 质量保障 |
| `foundation-models-on-device` | 端侧模型部署 | ★★☆ 移动端 AI |
| `agent-eval` | Agent 评估对比 | ★★☆ Agent 开发 |
| `agent-harness-construction` | Agent 工具设计 | ★★☆ Agent 开发 |
| `agentic-engineering` | Agent 工程方法 | ★★☆ Agent 开发 |
| `eval-harness` | 评估框架 | ★☆☆ 专业需求 |
| `autonomous-agent-harness` | 自主 Agent 系统 | ★☆☆ 高级需求 |
| `agent-payment-x402` | Agent 支付协议 | ★☆☆ 特殊需求 |
| `gan-style-harness` | GAN 风格评估 | ★☆☆ 特殊需求 |

#### 类别 4：内容与媒体（~10个）— 按项目需求

| Skill | 用途 | 备注 |
|-------|------|------|
| `content-engine` | ★ 已列入 Phase 2 导入 | — |
| `article-writing` | ★ 已列入 Phase 2 导入 | — |
| `frontend-slides` | ★ 已列入 Phase 2 导入 | — |
| `brand-voice` | 品牌声音建模 | 内容创作进阶 |
| `crosspost` | 多平台分发 | 配合 content-engine |
| `manim-video` | Manim 数学动画 | 教育/演示 |
| `remotion-video-creation` | React 视频生成 | 视频创作 |
| `video-editing` | AI 视频编辑 | 视频工作流 |
| `videodb` | 视频理解/编辑 | 视频数据管理 |
| `ui-demo` | Playwright 演示录制 | 产品演示 |

#### 类别 5：业务领域（~18个）— 高度按需

只在进入特定行业时导入。

| 领域 | Skills | 数量 |
|------|--------|------|
| **医疗健康** | `healthcare-cdss-patterns`, `healthcare-emr-patterns`, `healthcare-eval-harness`, `healthcare-phi-compliance` | 4 |
| **物流供应链** | `logistics-exception-management`, `returns-reverse-logistics`, `customs-trade-compliance`, `carrier-relationship-management` | 4 |
| **投资/商务** | `investor-materials`, `investor-outreach`, `lead-intelligence`, `customer-billing-ops` | 4 |
| **制造/能源** | `production-scheduling`, `quality-nonconformance`, `inventory-demand-planning`, `energy-procurement` | 4 |
| **签证/翻译** | `visa-doc-translate` | 1 |
| **市场研究** | `market-research` | 1 |

#### 类别 6：工具与集成（~17个）— 按使用场景

| Skill | 用途 | 推荐度 |
|-------|------|--------|
| `documentation-lookup` | ★ 已列入 Phase 2 导入 | — |
| `mcp-server-patterns` | ★ 已列入 Phase 2 导入 | — |
| `bun-runtime` | ★ 已列入 Phase 2 导入 | — |
| `clickhouse-io` | ClickHouse 分析数据库 | ★★☆ 大数据分析 |
| `jira-integration` | Jira 项目管理集成 | ★★☆ 企业团队 |
| `google-workspace-ops` | Google Workspace 操作 | ★★☆ 企业环境 |
| `exa-search` | Exa AI 搜索 | ★★☆ 研究工具 |
| `fal-ai-media` | fal.ai 媒体生成 | ★☆☆ AI 媒体 |
| `nutrient-document-processing` | 文档处理 API | ★☆☆ 文档工作流 |
| `data-scraper-agent` | 自动数据采集 | ★★☆ 数据收集 |
| `deep-research` | 深度研究工作流 | ★★☆ 研究场景 |
| `social-graph-ranker` | 社交图谱分析 | ★☆☆ 社交分析 |
| `x-api` | X/Twitter API | ★☆☆ 社交媒体 |
| `browser-qa` | 浏览器自动化测试 | ★★☆ UI 测试 |
| `click-path-audit` | 点击路径审计 | ★★☆ UX 调试 |
| `nanoclaw-repl` | REPL 工具 | ★☆☆ 特殊需求 |
| `connections-optimizer` | 社交网络优化 | ★☆☆ 社交管理 |

#### 类别 7：元技能/Claude Code 专属（~31个）— 不推荐转换

这些 skill 深度依赖 Claude Code 特有功能（hooks、autonomous loops、agent fleet 等），转换价值低。

| 子类 | Skills | 原因 |
|------|--------|------|
| **Claude Code 内存/配置** | `ck`, `configure-ecc`, `workspace-surface-audit` | 依赖 `.claude/` 目录 |
| **Hooks 驱动** | `plankton-code-quality`, `continuous-learning`, `continuous-learning-v2` | 依赖 hook 系统 |
| **自主循环** | `autonomous-loops`, `continuous-agent-loop` | 依赖自主运行能力 |
| **多 Agent 编排** | `claude-devfleet`, `team-builder`, `santa-method`, `ralphinho-rfc-pipeline` | 依赖 Agent fleet |
| **Context 管理** | `context-budget`, `token-budget-advisor`, `strategic-compact` | Claude Code context 专属 |
| **Skill/Rule 元管理** | `skill-comply`, `skill-stocktake`, `rules-distill` | Claude Code skill 生态 |
| **安全/审计** | `safety-guard`, `security-scan`, `repo-scan` | 依赖 Claude Code 安全框架 |
| **项目模板/示例** | `project-guidelines-example`, `blueprint`, `codebase-onboarding` | 参考价值 > 使用价值 |
| **搜索/研究** | `search-first` | 依赖 researcher agent 委托 |
| **流程管理** | `project-flow-ops`, `product-lens` | 部分可用，但 CE 已覆盖核心 |
| **开源管道** | `opensource-pipeline` | 依赖三阶段 agent 管道 |
| **平台专属** | `openclaw-persona-forge` | Claude Code persona 系统 |

---

### 11.3 按需导入快速参考表

当你面对新项目时，按技术栈快速查找应导入的 skill：

| 我要做... | 从候选库导入 | Token 影响 |
|-----------|-------------|-----------|
| **Go 微服务** | `golang-patterns` + `golang-testing` | +~500 |
| **Python AI 应用** | `python-patterns` + `pytorch-patterns` + `claude-api` | +~900 |
| **Kotlin Android** | `kotlin-patterns` + `kotlin-coroutines-flows` + `android-clean-architecture` | +~900 |
| **Rust 系统编程** | `rust-patterns` + `rust-testing` | +~600 |
| **Spring Boot 后端** | `springboot-patterns` + `springboot-security` + `jpa-patterns` | +~900 |
| **Django Web** | `django-patterns` + `django-security` + `django-tdd` | +~900 |
| **Flutter 移动端** | `dart-flutter-patterns` + `compose-multiplatform-patterns` | +~600 |
| **DevOps/部署** | `docker-patterns` + `deployment-patterns` + `database-migrations` | +~900 |
| **内容创作** | `brand-voice` + `crosspost` | +~400 |
| **医疗健康系统** | `healthcare-*` (4个全套) | +~1200 |

> 注意：每次导入后检查 Token 总预算（第六章 6.3），确保常规加载 ≤ 200K 的 3%。
