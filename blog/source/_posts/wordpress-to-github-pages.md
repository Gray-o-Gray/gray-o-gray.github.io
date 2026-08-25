---
title: 从 WordPress 到 GitHub Pages：一次博客平台的"换轨"记录
date: 2026-08-26 01:40:00
tags:
  - 博客
  - Hexo
  - GitHub
  - WordPress
---

# 从 WordPress 到 GitHub Pages：一次博客平台的"换轨"记录

折腾了两天，我的博客终于完成了从「云服务器 + WordPress」到「GitHub Pages + Hexo」的平台切换。这篇文章记录一下切换的过程、分支迁移的思路，以及一些踩坑经验，希望能帮到同样想"换轨"的朋友。

## 为什么要换

原来的方案是：腾讯云服务器 + 宝塔面板 + WordPress。这套方案本身很成熟，功能强大，但对我这种以技术笔记为主的轻量博客来说，有几个痛点：

- **成本**：云服务器每年要续费，域名解析、备案、安全组配置都挂在服务器上。
- **维护负担**：WordPress 生态需要关注 PHP 版本、插件安全更新、备份策略，对"只想安静写文章"的人来说是额外的心理负担。
- **内容形态**：我的博客内容几乎全是 Markdown，而 WordPress 的富文本编辑器反而不如本地编辑器顺手。

而 GitHub Pages + Hexo 的组合恰好对症：免费托管、原生 Markdown、Git 版本控制、push 即部署。缺点是需要接受"静态站点"的定位，以及托管在境外平台这一事实——关于备案，后面单独说。

## 新旧架构对比

| 维度 | 旧方案 | 新方案 |
|------|--------|--------|
| 托管 | 腾讯云服务器 | GitHub Pages |
| 建站 | WordPress + 宝塔 | Hexo + icarus 主题 |
| 写作 | 浏览器后台 | 本地 Markdown |
| 部署 | 手动/脚本 | push 即自动构建 |
| 费用 | 服务器年费 + 域名 | 域名 + 0 服务器费用 |
| 备案 | ICP + 公安备案 | 域名保留，DNS 转发接入 |

域名 `makiblog.cn` 没有变，只是把 DNS 解析从"指向服务器 IP"改成了"转发到 gray-o-gray.github.io"。原先的 ICP 备案和公安备案依然保留——域名还在使用，备案信息就继续有效。

## 分支迁移：两个分支的合流

这次切换最核心的部分是 Git 分支的处理。旧的博客仓库一直保持"双分支"结构：

- **hexo 分支**：Hexo 源码（文章、主题配置、构建脚本）
- **master 分支**：构建产物（`hexo generate` 生成的静态文件）

旧流程是本地手动构建：`hexo d -g`，然后由 `hexo-deployer-git` 把产物推送到 master 分支，Pages 从 master 直接提供静态文件。写一篇文章要走"源码分支 → 本地构建 → 产物分支"三个环节，中间还得保证本地 Node 环境版本一致，一旦换电脑或者忘记 `hexo clean`，就容易出一些莫名其妙的构建差异。

既然决定引入 GitHub Actions 做自动部署，我索性把两个分支"合流"：**源码直接放 master**，push 后由 CI 自动构建，产物由 GitHub Pages 的 Actions 托管。

这样做的好处很直接：

1. **心智负担降到最低**：只有一个分支，写文章、提交、推送，三个动作全部发生在 master。
2. **不再依赖本地环境**：构建在 CI 的 Ubuntu 环境里完成，本地只需一个编辑器。
3. **产物永不脏**：master 上只有源码，每次部署的产物都是全新构建的。

迁移本身很朴素：在 master 上删掉旧的产物文件，把 hexo 分支的内容复制过来，生成一个新的迁移 commit（保留历史，不需要 force push）。

## GitHub Actions 自动部署

部署 workflow 的核心逻辑是这样的：

```yaml
name: Deploy Hexo Site to GitHub Pages

on:
  push:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20

      - name: Install dependencies
        run: |
          cd blog
          npm install

      - name: Build site
        run: |
          cd blog
          npx hexo generate

      - name: Add CNAME
        run: echo "www.makiblog.cn" > blog/public/CNAME

      - name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v4
```

几个关键点：

- **`submodules: recursive`**：我的 icarus 主题是通过 git submodule 引入的，构建时如果不拉取子模块，生成会直接失败。
- **CNAME**：自定义域名需要 CNAME 文件出现在构建产物里，所以构建后单独写一次，比手动维护 `source/CNAME` 更不容易遗漏。
- **`actions/deploy-pages`**：这是 GitHub 官方的 Pages 部署 action，配合 Pages 的 "Source: GitHub Actions" 设置，部署完全由 CI 掌控，不再依赖某个分支的静态文件。

## 踩坑记录

1. **子模块主题拉取失败**：第一次构建报错找不到主题，就是忘了在 checkout 时加 `submodules: recursive`。
2. **`_config.yml` 里的占位 url**：Hexo 初始化时默认是 `http://example.com`，不改成真实域名会导致 sitemap、og 标签、canonical 链接全部指向错误地址。
3. **Pages Source 切换**：从"部署分支"切到"GitHub Actions"后，自定义域名有可能需要重新在 Settings → Pages 里确认一次，并等 HTTPS 证书重新签发。

## 现在的发布流程

切换完成之后，发布一篇文章只需要三步：

```
写文章（blog/source/_posts/）
git add + git commit
git push
```

push 出去 1-2 分钟，站点自动更新。本地不用装 Node、不用跑构建，换任何一台电脑只要 git 和编辑器就能继续写。

## 结语

这次"换轨"最大的收获，是把"写博客"这件事从"运维一台服务器"里剥离了出来。GitHub Actions 自动部署让发布变成了纯粹的写作行为，而 Git 历史天然就是文章的版本管理。

平台的切换和 git 分支的合流其实是一回事：**把复杂的东西收拢到一条主线里**，让日常的操作路径短一点、确定一点。剩下的精力，就留给内容本身吧。
