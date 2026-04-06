# Forge 进化记录 (Evolution Log)

> **Forge** — Development Rules System 的变更追踪。
> 遵循 CALOR 循环: Candidate → Assess → Load → Optimize → Review
> Dashboard: `docs/forge-dashboard.html`

## 约定

- **操作类型**: 初始化 / 新增 / 升级 / 退役 / 同步 / 优化 / 审计
- **组件类型**: rule / skill / plugin / 方案
- **来源标记**: ECC = Everything Claude Code, CE = Compound Engineering, CUSTOM = 自定义
- **Token 影响**: 标注对常规加载 token 预算的影响（+ 增加 / - 减少 / = 无变化）

---

## 记录

| 日期 | 操作 | 类型 | 名称 | 来源 | 原因 | Token 影响 |
|------|------|------|------|------|------|-----------|
| 2026-04-05 | 初始化 | 方案 | v1.0 | ECC+CE+CUSTOM | 三大系统深度整合，建立基线 | 基线 ~5300 |
| 2026-04-05 | 升级 | 方案 | v1.1 | — | 增加 CALOR 进化策略、Token 四层防线、按需扩展候选库(194个) | = 无变化 |
| 2026-04-05 | 新增 | rule | common-coding-style | ECC | 编码风格约束，alwaysApply | +250 |
| 2026-04-05 | 新增 | rule | common-git-workflow | ECC | Git 工作流约束，去除 Claude Code 引用 | +200 |
| 2026-04-05 | 新增 | rule | common-patterns | ECC | 通用设计模式 | +250 |
| 2026-04-05 | 新增 | rule | common-security | ECC | 安全检查清单，改造为通用指引 | +250 |
| 2026-04-05 | 新增 | rule | common-testing | ECC | TDD 流程，去除 agent 引用 | +200 |
| 2026-04-05 | 新增 | rule | common-performance | ECC | Context 管理，去除 Claude Code 专属内容 | +150 |
| 2026-04-05 | 新增 | rule | common-development-workflow | ECC | 重写为 CE 工作流对齐版本 | +200 |
| 2026-04-05 | 新增 | rule | golang-* (5个) | ECC | Go 语言规则，hooks 改造为质量提醒 | +0 (glob) |
| 2026-04-05 | 新增 | rule | typescript-* (5个) | ECC | TypeScript 规则，hooks 改造 | +0 (glob) |
| 2026-04-05 | 新增 | rule | python-* (5个) | ECC | Python 规则，hooks 改造 | +0 (glob) |
| 2026-04-05 | 新增 | rule | kotlin-* (5个) | ECC | Kotlin 规则，hooks 改造 | +0 (glob) |
| 2026-04-05 | 新增 | skill | documentation-lookup | ECC | Context7 MCP 文档查询指南 | +20 |
| 2026-04-05 | 新增 | skill | mcp-server-patterns | ECC | MCP 服务器开发指南 | +20 |
| 2026-04-05 | 新增 | skill | bun-runtime | ECC | Bun 运行时指南 | +20 |
| 2026-04-05 | 新增 | skill | nextjs-turbopack | ECC | Next.js 16+ Turbopack | +20 |
| 2026-04-05 | 新增 | skill | content-engine | ECC | 跨平台内容创作 | +20 |
| 2026-04-05 | 新增 | skill | article-writing | ECC | 长文写作方法论 | +20 |
| 2026-04-05 | 新增 | skill | frontend-slides | ECC | HTML 演示文稿生成 | +20 |
| 2026-04-05 | 升级 | skill | coding-standards | ECC+CUSTOM | 合并 ECC Code Quality Checklist | = 无变化 |
| 2026-04-05 | 升级 | skill | security-best-practices | ECC+CUSTOM | 合并 ECC 安全检查清单 + 响应协议 | = 无变化 |
| 2026-04-05 | 升级 | skill | task-tracking | CUSTOM | 精简 description，与 CE todo 互补定位 | = 无变化 |
| 2026-04-05 | 退役 | skill | frontend-design | — | CE frontend-design 更强大 | -45 |
| 2026-04-05 | 退役 | skill | project-planning | — | CE brainstorm+plan 完全覆盖 | -45 |
| 2026-04-05 | 退役 | skill | skill-creator | — | Cursor 内置 create-skill 已覆盖 | -45 |
| 2026-04-05 | 退役 | skill | workflow-orchestration | — | CE work 是真正可执行的工作流 | -45 |
| 2026-04-05 | 新增 | skill | _evolution | CUSTOM | CALOR 进化框架 meta-skill | +20 |
| 2026-04-05 | 优化 | rule | common-development-workflow | CUSTOM | 加入 5W1H 需求分析框架 + "先提问再执行"行为准则 | +150 |
| 2026-04-05 | 优化 | skill | 全部 21 个 | CUSTOM | description 精简到 ≤15 词，5 个补充 YAML frontmatter | -525 |
| 2026-04-05 | 优化 | skill | _archived/* | — | SKILL.md → SKILL.md.bak，阻止 Cursor 发现退役 skills | = 无变化 |
| 2026-04-05 | 退役 | rule | 8 个 .mdc 文件 | — | ~/.cursor/rules/ 下的旧规则与 workspace rules 重复，移到 _archived_mdc/ | -2000 |
| 2026-04-05 | 退役 | agent | 10 个 agent 文件 | — | ~/.cursor/agents/ 下的旧 agent 不被 Cursor 使用，CE subagents 已覆盖 | = 无变化 |
| 2026-04-06 | 优化 | rule | common-development-workflow | CUSTOM | 加入任务路由表，11 种任务类型自动匹配工作流 | +150 |
| 2026-04-06 | 新增 | skill | orchestrator | CUSTOM | 工作流编排 skill，用户通过 @orchestrator 主动触发结构化多阶段执行 | +20 |
| 2026-04-06 | 审计 | 方案 | ECC 整合验证 | — | 确认 everything-claude-code 核心内容已全部提取，目录可删除 | = 无变化 |
| 2026-04-06 | 新增 | rule | common-project-init | CUSTOM | 项目初始化检查清单：结构、配置、工具、文档、安全 | +0 (on-demand) |
| 2026-04-06 | 新增 | rule | common-documentation | CUSTOM | 文档标准：注释、README、API 文档、CHANGELOG、ADR | +200 (alwaysApply) |
| 2026-04-06 | 新增 | rule | common-design-system | CUSTOM | UI/UX 设计系统：布局、排版、色彩、组件、响应式、无障碍 | +0 (glob) |
| 2026-04-06 | 新增 | rule | common-architecture | CUSTOM | 架构标准：分层、模块边界、依赖方向、ADR | +0 (on-demand) |
| 2026-04-06 | 新增 | rule | common-error-handling | CUSTOM | 错误处理：分类、结构化错误、日志、用户反馈、恢复模式 | +200 (alwaysApply) |
| 2026-04-06 | 新增 | rule | common-api-design | CUSTOM | API 设计：RESTful、状态码、分页、版本化、验证 | +0 (glob) |
| 2026-04-06 | 新增 | rule | common-database | CUSTOM | 数据库：Schema 设计、迁移、索引、查询、安全 | +0 (glob) |
| 2026-04-06 | 新增 | rule | common-dependency | CUSTOM | 依赖管理：选型、版本锁定、更新策略、安全审计 | +0 (glob) |
| 2026-04-06 | 退役 | 方案 | everything-claude-code/ | ECC | 核心内容已全部提取到 rules+skills，删除源目录 | = 无变化 |
| 2026-04-06 | 新增 | rule | java-* (5个) | CUSTOM | Java 全套规则：编码风格、设计模式、安全、测试、质量提醒 | +0 (glob) |
| 2026-04-06 | 新增 | rule | frontend-engineering | CUSTOM | 前端工程化：组件架构、状态管理、性能、CSS、表单、错误边界 | +0 (glob) |
| 2026-04-06 | 升级 | 方案 | Forge v1.2 | CUSTOM | 系统命名为 Forge，创建身份规则和扩展框架 | +150 (alwaysApply) |
| 2026-04-06 | 新增 | rule | forge-identity | CUSTOM | 系统身份：名称、版本、组成、扩展协议 | +150 (alwaysApply) |
| 2026-04-06 | 新增 | rule | forge-extensibility | CUSTOM | 扩展框架：模板、版本管理、迁移、退役流程 | +0 (on-demand) |
| 2026-04-06 | 新增 | 方案 | forge-dashboard.html | CUSTOM | 可视化监控仪表盘：规则/技能清单、Token预算、CALOR状态、时间线 | = 无变化 |
| 2026-04-06 | 新增 | rule | frontend-design-standard | CUSTOM | 前端视觉设计基准：暖色体系、排版、组件、阴影、响应式、Agent指南 | +0 (glob) |
| | | | | | | |

---

## 季度审计记录

| 审计周期 | 审计日期 | 活跃 Rules | 活跃 Skills | Token 总量 | 状态 | 备注 |
|---------|---------|-----------|------------|-----------|------|------|
| Q2 2026 | 2026-04-05 | 27 | 21 | ~5300 | 已部署 | Phase 1-2 全部完成 |
| Q2 2026 | 2026-04-06 | 35 | 22 | ~5870 | 已部署 | +8 项目级规则 +orchestrator skill，ECC 整合完毕 |
| Q2 2026 | 2026-04-06 | 44 | 22 | ~6100 | **Forge v1.2** | +Java(5) +前端工程(1) +设计基准(1) +Forge身份(2) +Dashboard |
| | | | | | | |
