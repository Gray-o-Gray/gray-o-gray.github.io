# Proposal: add-giscus-comments

## Why
博客当前无评论系统（无效 disqus 配置已移除）。需要一个零服务器维护、与 GitHub Pages 方案天然契合的评论方案。

## What Changes
- 选型 **giscus**（基于 GitHub Discussions）：
  - 无需服务器（旧的腾讯云服务器已停用，waline/自建方案不合适）
  - 评论数据存放在仓库 Discussions，免费、无广告、支持中文
- 在 `blog/_config.icarus.yml` 中启用并配置 giscus 评论组件
- 更新 `site-interaction` spec：评论系统从「禁用」变更为「giscus 已启用」

## Capabilities
### Modified
- `site-interaction`：新增 giscus 评论要求；保留「无效配置必须禁用」约束

## Impact
- 代码：仅 `blog/_config.icarus.yml`（comment widget 段）
- 前置条件（需用户操作）：
  1. 在 GitHub 仓库 gray-o-gray.github.io 开启 Discussions
  2. 安装 giscus GitHub App（https://github.com/apps/giscus）
  3. 在 giscus.app 生成配置参数（repo-id、category-id）
- 隐私提示：评论者需 GitHub 账号登录
