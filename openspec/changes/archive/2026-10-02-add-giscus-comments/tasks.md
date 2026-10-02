# add-giscus-comments Tasks

## 1. 前置配置（用户在 GitHub 侧操作）
- [ ] 1.1 仓库 Settings → General → Features 开启 Discussions
- [ ] 1.2 Discussions 中创建分类（建议选 Announcements 类型，仅作者可发起、访客可回复）
- [ ] 1.3 安装 giscus GitHub App 并授权该仓库
- [ ] 1.4 在 giscus.app/zh-CN 填入仓库名，获取 data-repo-id 与 data-category-id

## 2. 站点配置（AI 操作）
- [ ] 2.1 在 `blog/_config.icarus.yml` 的 comment 段启用 giscus，填入 1.4 的参数
- [ ] 2.2 `npx hexo s` 本地验证：文章页底部出现评论区（未登录状态显示登录提示）

## 3. 部署与收尾
- [ ] 3.1 commit + push，确认 Actions 构建成功、线上评论区正常
- [ ] 3.2 `openspec archive add-giscus-comments`，更新 vault 侧进展记录
