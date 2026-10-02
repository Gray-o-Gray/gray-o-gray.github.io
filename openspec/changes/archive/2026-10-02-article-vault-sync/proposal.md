# Proposal: article-vault-sync

## Why
写作在 Obsidian vault（local-note）中进行，而 Hexo 文章目录在代码仓库 `blog/source/_posts/`，两处分离导致发布繁琐。需要自动化：vault 写作 → 一键同步发布。

## What Changes
- 新增 vault 侧同步脚本 `sync_blog.py`（存放于 vault `02-领域/自动化/`，不在本仓库）：
  - 扫描 vault 草稿区 `02-领域/博客/文章/待发布/*.md`，frontmatter `发布: 是` 才同步
  - 将 vault frontmatter（标题/分类/标签/日期）转换为 Hexo front-matter，写入 `_posts/`
  - 基于内容 hash 的状态文件：内容变更自动重新同步更新
  - `--push` 自动 commit + push 触发 Actions 部署；`--dry-run` 预览
  - 发布完成后源文件移入 vault `已发布/`；`已发布/` 中内容变更同样自动重新同步
- 修改 `content-publishing` spec：新增「vault 同步发布」要求

## Capabilities
### Modified
- `content-publishing`：新增 vault 草稿区同步发布流程

## Impact
- 本仓库：仅 `_posts/` 下的文章文件变更（由脚本写入），无代码改动
- vault 侧：新增目录结构、脚本、状态文件 `blog_sync_state.json`、文章模板
- 命名约定：vault 文件名即 Hexo 文件名（= 文章 URL slug），建议英文/拼音 kebab-case
