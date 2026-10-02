# content-publishing 变更（delta）

## ADDED Requirements

### Requirement: vault 同步发布
系统 SHALL 支持从 Obsidian vault 草稿区（`02-领域/博客/文章/待发布/`）同步文章到 `blog/source/_posts/`：仅同步 frontmatter `发布: 是` 的文章；vault frontmatter（标题/分类/标签/日期）SHALL 转换为 Hexo front-matter；同步脚本 SHALL 基于内容 hash 检测变更并自动重新同步；支持 `--push` 触发部署与 `--dry-run` 预览。

#### Scenario: 草稿未就绪跳过
- GIVEN vault 文件 frontmatter `发布: 否` 或缺失
- WHEN 运行同步脚本
- THEN 该文件被跳过并提示未就绪，`_posts/` 不产生文件

#### Scenario: 定稿发布
- GIVEN vault 文件 frontmatter `发布: 是`
- WHEN 运行同步脚本
- THEN 转换后的文章写入 `_posts/`，源文件移入 `已发布/`，加 `--push` 时自动 commit + push 触发 Actions 部署

#### Scenario: 已发布内容更新
- GIVEN `已发布/` 中的文件内容被修改
- WHEN 运行同步脚本
- THEN 脚本检测到 hash 变化并重新同步更新 `_posts/` 中的对应文章
