# article-vault-sync Tasks

## 1. vault 侧基础设施（AI 操作）
- [ ] 1.1 创建 `02-领域/博客/文章/{待发布,已发布}/` 目录
- [ ] 1.2 创建文章模板 `92-模板库/博客文章模板.md`（含 frontmatter 字段说明）
- [ ] 1.3 实现 `02-领域/自动化/sync_blog.py`（frontmatter 转换、hash 状态、--push/--dry-run）
- [ ] 1.4 用测试文章验证：跳过未就绪 → 同步 → 更新 → 发布移位 全流程

## 2. 收尾
- [ ] 2.1 归档本 change，更新 vault 侧文档（项目大纲/进展/变更记录）
