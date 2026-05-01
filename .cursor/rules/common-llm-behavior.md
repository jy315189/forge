---
description: "LLM behavior constraints: surgical changes, simplicity first, goal-driven execution"
alwaysApply: true
---
# LLM Behavioral Constraints

行为层元规则，对抗 LLM 编码三大顽疾：过度复杂化、无关联改动、模糊指令。

**Tradeoff**: 偏向谨慎而非速度。琐碎任务（typo、显而易见的一行修改）自行判断。

> 关于「编码前思考 / 先提问再执行」请遵循 `common-development-workflow.md` 中的 **Clarify First** 与 **5W1H** 章节。本文件不重复，只补充其无覆盖的三条行为约束。

## 1. Surgical Changes — 精准修改

**只碰必须碰的。只清理自己制造的混乱。**

编辑现有代码时：
- 不要"改进"相邻的代码、注释或格式
- 不要重构没坏的东西
- 匹配现有风格，即使你更倾向于另一种写法
- 注意到无关死代码时，**指出**它 —— 不要删除它

当你的改动产生孤儿时：
- 删除因 **你的改动** 而变得无用的 import / 变量 / 函数
- 不要删除预先存在的死代码，除非用户明确要求

**检验标准**：每一行修改都能直接追溯到用户的请求。

## 2. Simplicity First — 简洁优先

**用最少的代码解决问题。不做投机性扩展。**

- 不添加要求之外的功能
- 不为一次性代码创建抽象
- 不添加未要求的"灵活性"或"可配置性"
- 不为不可能发生的场景做错误处理
- 200 行能写成 50 行 → 重写

**检验启发**：资深工程师会觉得这过于复杂吗？是 → 简化。

> 与 `common-coding-style.md` 的"函数 <50 行 / 文件 <800 行 / 嵌套 ≤4 层"是结果指标互补关系：本节是判断启发式，那里是度量边界。

## 3. Goal-Driven Execution — 目标驱动执行

**定义成功标准。循环验证直到达成。**

把指令式任务转成可验证目标：

| 不要这样做 | 转化为 |
|-----------|--------|
| "添加验证" | "为无效输入写测试，让它们通过" |
| "修复 bug" | "写一个能复现 bug 的测试，让它通过" |
| "重构 X" | "确保重构前后测试都通过" |

多步骤任务，先写一个简短计划：

```
1. [步骤] → 验证: [检查]
2. [步骤] → 验证: [检查]
3. [步骤] → 验证: [检查]
```

强成功标准 → LLM 可独立循环执行。
弱成功标准（"让它工作"）→ 不断澄清。

> 任务路由（什么类型走什么流程）见 `common-development-workflow.md` 的 Task Routing 表；TDD 具体节奏见 `common-testing.md`。本节是元方法论：任意任务都先想"成功标准如何验证"。

## 起作用的信号

如果你看到以下情况，说明这三条规则在生效：
- diff 中只有被请求的改动，没有顺带"美化"
- 第一次写就足够简洁，重写次数下降
- 实现前先提出澄清问题，而不是事后补救
- PR 干净、最小、目标明确

---

**出处**：本规则提炼自 [Andrej Karpathy 关于 LLM 编码顽疾的观察](https://x.com/karpathy/status/2015883857489522876)，原始整合见 [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)。本地镜像：`external/andrej-karpathy-skills/`。
