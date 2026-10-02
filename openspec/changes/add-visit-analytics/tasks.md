# add-visit-analytics Tasks

## 1. 前置配置（用户操作）
- [ ] 1.1 登录 analytics.google.com，创建 GA4 媒体资源（网站 makiblog.cn）
- [ ] 1.2 创建数据流，获取 Measurement ID（G-XXXXXXXXXX）

## 2. 站点配置（AI 操作）
- [ ] 2.1 在 `blog/_config.icarus.yml` 的 analytics 段启用 google-analytics 并填入 Measurement ID
- [ ] 2.2 本地验证：页面 head 中包含 gtag 脚本

## 3. 部署与收尾
- [ ] 3.1 commit + push，确认 Actions 构建成功
- [ ] 3.2 GA 实时报告验证：访问站点后出现活跃用户
- [ ] 3.3 `openspec archive add-visit-analytics`，更新 vault 侧进展记录
