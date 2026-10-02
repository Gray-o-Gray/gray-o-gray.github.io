# site-deployment Specification

## Purpose
博客静态站点的构建与自动部署：Hexo + icarus 主题，push 到 master 后由 GitHub Actions 自动构建并部署到 GitHub Pages，绑定自定义域名 makiblog.cn。

## Requirements

### Requirement: 推送自动部署
仓库 SHALL 在 push 到 master 分支后由 GitHub Actions（`blog/.github/workflows/`）自动执行 `hexo generate` 并将产物部署到 GitHub Pages；checkout 时 SHALL 带 `submodules: recursive`（icarus 主题为 submodule）。

#### Scenario: push 触发构建
- WHEN 新提交 push 到 master
- THEN Actions 自动构建并部署，1-2 分钟内线上生效

### Requirement: 自定义域名
部署产物 SHALL 包含 CNAME（构建后在 workflow 中写入 `public/CNAME`），域名 makiblog.cn 经腾讯云 DNS 转发接入 `gray-o-gray.github.io`。

#### Scenario: 访问自定义域名
- WHEN 用户访问 makiblog.cn
- THEN 正常展示博客站点内容

### Requirement: 主题样式隔离
站点 `source/css/` 下 SHALL NOT 存在与主题编译产物同名的文件（如 `default.css`），否则会覆盖主题样式导致布局崩溃；自定义样式 SHALL 写在 `themes/icarus/source/css/` 下的 `.styl` 源文件并在 `default.styl` 中 `@import`。

#### Scenario: 自定义样式生效
- WHEN 修改自定义样式并重新构建
- THEN 主题样式与自定义样式一起编译进同一个 default.css，布局正常
