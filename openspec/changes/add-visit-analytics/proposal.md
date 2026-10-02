# Proposal: add-visit-analytics

## Why
站点目前仅有 busuanzi 阅读计数，无独立访客、来源、留存等统计，无法评估内容效果（OPTIMIZATION.md P2-11）。

## What Changes
- 选型 **Google Analytics 4**：
  - 零服务器维护，与 GitHub Pages 静态方案契合（umami 自建需要服务器，腾讯云服务器已停用）
  - icarus 主题原生支持 analytics 配置
- 在 `blog/_config.icarus.yml` 启用 Google Analytics，填入 Measurement ID
- 新增 `site-analytics` 基线 spec

## Capabilities
### Added
- `site-analytics`：访问统计接入要求

## Impact
- 代码：仅 `blog/_config.icarus.yml`（analytics 段）
- 前置条件（需用户操作）：
  1. 用 Google 账号创建 GA4 媒体资源（https://analytics.google.com）
  2. 获取 Measurement ID（格式 G-XXXXXXXXXX）
- 提示：GA 在国内访问可能受网络环境影响；若在意可后续换用 umami/Cloudflare Analytics，配置点相同
