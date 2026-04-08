---
description: "Forge scripts audit: verify scripts/ match current rules after every rule change"
globs: [".cursor/rules/**/*.md", "scripts/**/*.bat"]
---
# Forge Scripts Audit — 规则变更时脚本同步检查

本规则仅适用于 Forge 规则源项目（everything-cursor_V2）。

## 核心要求

**每次 `.cursor/rules/` 中的规则文件发生变更（新增、删除、重命名、修改前缀），必须审查 `scripts/` 下的脚本并同步更新。**

## 审查清单

### forge-new.bat

| 检查项 | 如何验证 |
|--------|---------|
| 版本号与 `forge-identity.md` 一致 | 搜索 `Forge v` 字样 |
| `common-*.md` 通配符覆盖所有 common 规则 | 对比 `ls .cursor/rules/common-*.md` |
| `forge-*.md` 显式复制条目完整 | 对比 `ls .cursor/rules/forge-*.md` |
| 每种语言 `{lang}-*.md` 通配符正确 | 新增语言时必须加对应 for 循环 |
| `frontend-*.md` 通配符覆盖所有前端规则 | 对比 `ls .cursor/rules/frontend-*.md` |
| 新增前缀规则有匹配路径 | 若规则文件前缀不在 common/forge/frontend/{lang} 中，脚本**必须新增**复制逻辑 |
| Experience Store 目录结构完整 | 新增分类时同步更新 mkdir 列表 |
| 菜单选项和 type 分支完整 | 新增语言时同步更新菜单和 if 分支 |

### forge-sync.bat

| 检查项 | 如何验证 |
|--------|---------|
| Experience Store 分类目录列表完整 | 对比 `~/.cursor/experiences/` 下的目录 |
| 新增全局组件有同步逻辑 | 若引入新的用户级目录（类似 experiences），脚本必须处理 |

## 触发时机

- `.cursor/rules/` 下**新增**文件 → 检查脚本中是否有通配符覆盖
- `.cursor/rules/` 下**删除**文件 → 无需操作（通配符自动跳过）
- `.cursor/rules/` 下**重命名/改前缀** → 检查是否脱离现有通配符范围
- `~/.cursor/experiences/` 下**新增分类目录** → 同步两个脚本中的 mkdir 列表
- `forge-identity.md` 中**版本号变更** → 同步脚本中的版本显示
- 新增**语言类型** → 脚本菜单、type 判断、for 循环三处同步

## 执行方式

规则变更完成后，AI 必须：

1. 读取 `scripts/forge-new.bat` 和 `scripts/forge-sync.bat`
2. 按上方清单逐项核对
3. 发现不一致 → 立即修复
4. 无不一致 → 在输出中确认"脚本审查通过，无需更新"
