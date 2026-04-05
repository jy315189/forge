---
description: "Development workflow: clarify first (5W1H), then brainstorm, plan, work, review, ship"
alwaysApply: true
---
# Development Workflow

## Clarify First — Ask Before You Code

**NEVER assume. ALWAYS ask.** When requirements are unclear, incomplete, or ambiguous:

- Use **interrogative form** to surface unknowns — "你期望的返回格式是？" "这个功能的边界是？"
- Ask **specific** questions, not vague ones — "用户未登录时应该跳转到哪里？" NOT "有什么需要注意的吗？"
- Group related questions together, but don't overload — 3-5 questions per round
- Wait for answers before proceeding to implementation
- If the user's answer introduces new unknowns, ask follow-up questions

**When to ask vs. when to proceed:**
- Unclear business logic → ASK (you cannot guess business rules)
- Ambiguous scope → ASK ("这个功能需要支持移动端吗？")
- Multiple valid approaches → ASK with trade-off summary ("方案 A 更快但不灵活，方案 B 更灵活但复杂，你倾向哪个？")
- Pure implementation detail → PROCEED (the user trusts your judgment on how)

## 5W1H Requirement Analysis

Before starting any non-trivial feature, clarify through 5W1H:

| Dimension | Key Questions |
|-----------|--------------|
| **What** | 核心功能是什么？边界和范围？需要排除什么？ |
| **Why** | 解决什么问题？带来什么价值？成功标准？ |
| **Who** | 目标用户是谁？使用场景？权限角色？ |
| **When** | 时间要求？优先级？里程碑？ |
| **Where** | 技术平台？部署环境？集成点？ |
| **How** | 技术栈选择？架构模式？关键约束？ |

Not every dimension needs exhaustive answers. Focus on the ones that are **unclear or risky** for the current task.

## Task Routing — Match Task Type to Workflow

| Task Type | Signals | Workflow |
|-----------|---------|----------|
| **New Feature** | "实现", "添加", "创建", "开发" | 5W1H → Plan → TDD → Review → Ship |
| **Bug Fix** | "修复", "bug", "报错", "不工作" | Reproduce with test → Fix → Verify |
| **Build Error** | 编译错误, 类型错误, 依赖问题 | Diagnose → Fix → Verify build |
| **Code Review** | "检查", "审查", "review" | ce:review (multi-perspective) |
| **Security** | "安全", "漏洞", "审计" | ce:review (security focus) |
| **Refactoring** | "重构", "清理", "优化结构" | Ensure tests → Refactor → Review |
| **Architecture** | "架构", "技术选型", "设计" | Options + trade-offs → Recommend |
| **Testing** | "测试", "覆盖率", "TDD" | tdd-workflow skill |
| **Documentation** | "文档", "README", "CHANGELOG" | file-management skill |
| **Planning** | "规划", "分解", "任务列表" | ce:brainstorm → ce:plan |
| **Unclear** | 模糊需求, 多个可能方向 | **ASK** before proceeding |

For complex multi-phase tasks, use `@orchestrator` skill for structured execution with phase tracking.

## Feature Implementation Pipeline

1. **Explore & Define** (ce:brainstorm)
   - Use 5W1H to clarify requirements
   - Ask questions until scope is clear
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
