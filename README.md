# gray-o-gray.github.io

个人博客源码仓库：Hexo + icarus 主题，GitHub Pages 自动部署（Actions）。

## 本地开发

```bash
# 进入博客目录
cd blog

# 安装依赖
npm install

# 生成本地服务（默认 http://localhost:4000）
npx hexo s

# 生成静态文件
npx hexo generate
```

## 写作流程

```bash
# 创建草稿
npx hexo new draft <title>

# 将草稿发布为文章
npx hexo publish <title>

# 本地预览草稿
npx hexo s --draft
```

发布：写文章 → `git add` + `git commit` + `git push`，CI 自动构建部署，1-2 分钟后线上生效。

## 部署

- GitHub Actions（`blog/.github/workflows/`）在 push 到 master 后自动执行 `hexo generate` 并部署到 Pages。
- 自定义域名 `www.makiblog.cn`，通过 CNAME 文件接入（构建后在 workflow 中写入 `public/CNAME`）。
- icarus 主题通过 git submodule 引入，checkout 时必须带 `submodules: recursive`。

## icarus 自定义样式（重要经验）

**不要**在 `blog/source/css/` 下新建与主题编译产物同名的文件（如 `default.css`）。
hexo 站点 `source/` 下的同名文件会**覆盖主题编译产物**，导致主题全部样式丢失、页面布局崩溃（2026-08-26 实际踩过）。

正确做法：修改主题源码

```bash
# 1. 在主题样式目录新建自定义样式
#    themes/icarus/source/css/makiblog.styl

# 2. 在主题样式源 default.styl 末尾追加
#    @import 'makiblog'
```

这样编译时主题样式与自定义样式一起进入同一个 `default.css`。

## 目录结构

```text
blog/
├── _config.yml              # Hexo 站点配置
├── source/
│   ├── _posts/              # 文章（Markdown）
│   ├── css/                 # 站点静态资源（勿放 default.css）
│   └── img/                 # 站点图片
└── themes/icarus/           # icarus 主题（submodule）
    └── source/css/          # 主题样式源（default.styl / makiblog.styl）
```

## Tools

1. hexo icarus
2. PicGo

## PicGo

图床工具，配合 github.io 使用非常舒适。

拖拽图片可自动上传 github 图床，并生成 markdown 形式的 url，直接粘贴即可。

感谢大佬分享，顺便贴一下大佬博客
https://removeif.github.io/
