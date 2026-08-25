---
title: 一次 Hexo 布局崩溃的排查记录：同名样式文件覆盖了主题
date: 2026-08-26 23:00:00
tags:
  - 博客
  - Hexo
  - 踩坑记录
---

把博客从 WordPress 换到 Hexo + icarus 主题之后，我开始给博客加自定义样式。结果改完一部署，页面布局整个崩了：导航栏样式没了、卡片排版乱掉，几乎是"裸奔"状态。这篇文章记录一下这次事故的排查过程，以及 icarus 主题下自定义 CSS 的正确姿势。

## 事故现象

我给博客加了一套自定义配色（比如把链接改成蓝色 `#2563eb`），按直觉放在了一个很"合理"的位置：

```text
blog/source/css/default.css   ← 站点源码目录下新建的样式文件
```

然后 `git push`，等 CI 构建部署完，打开页面一看——**布局全崩了**。主题的卡片、导航栏、侧边栏样式全部消失，只剩下最基本的内容流。用浏览器检查一下，发现加载的 `/css/default.css` 只有区区几行（就是我自己写的那几句配色），整个主题的样式表不翼而飞。

## 排查过程

第一反应是 CI 构建缓存问题，`hexo clean` 重新构建，无效。于是直接抓取线上构建产物：

```bash
curl -s https://www.makiblog.cn/css/default.css | wc -c
# 输出：181   ← 只有我自己写的几行
```

正常情况这个文件应该有几百 KB（主题样式 + 自定义样式编译产物）。对比发现，**线上加载的 `default.css` 就是我自己建的那个文件**。

到这里基本定位了：我在站点 `source/css/` 下新建的 `default.css`，和主题编译产物 **重名** 了。

## 根因

icarus 主题的样式源文件是：

```text
themes/icarus/source/css/default.styl
```

hexo 生成时，会把主题的 `.styl` 编译成静态资源，输出路径恰好是：

```text
public/css/default.css
```

而我手贱在站点源码目录也建了同名文件：

```text
blog/source/css/default.css
```

hexo 对同名静态资源的处理规则是：**站点 `source/` 下的同名文件覆盖主题编译产物**。于是发布后线上 `/css/default.css` 被我的几行配色顶掉，主题几百 KB 的样式全部丢失，布局自然崩了。

## 修复

正确的做法是：**不要动主题的编译产物，而是去改主题的样式源文件**。icarus 主题本身支持多个配色变体（`default.css`、`cyberpunk.css` 等），这些变体都在主题源码里，通过 `_config.yml` 的 `style_variant` 配置选择。

自定义样式有两种推荐姿势：

1. **修改主题源码**：在 `themes/icarus/source/css/` 下新建 `makiblog.styl`，然后在 `default.styl` 末尾追加 `@import 'makiblog'`。这样编译时主题样式和自定义样式一起进同一个 `default.css`，互不覆盖。
2. **只加不改**：自定义内容很独立时，可以直接在主题配置里指向自己的变体文件，别去占用 `default.css` 这个名字。

我采用了第一种，最终结构是这样：

```text
themes/icarus/source/css/
├── default.styl        ← 主题样式源，末尾追加 @import 'makiblog'
└── makiblog.styl       ← 我的自定义样式
```

修改后重新构建，`/css/default.css` 恢复为几百 KB（主题样式 + 自定义配色），布局恢复正常。

## 经验总结

1. **不要和主题编译产物重名**。hexo 站点 `source/` 目录下的同名文件会覆盖主题资源，这是"按直觉做事"最容易踩的坑。
2. **自定义样式优先改主题源码**。对 icarus 来说，正确入口是 `themes/icarus/source/css/` 下的 `.styl` 文件，改完 `@import` 进去即可，干净且不破坏主题升级。
3. **排查时先看产物再怀疑缓存**。`curl` 线上文件对比大小，比反复 `hexo clean` 高效得多。

这次的教训说白了就一句：**在没搞清文件命名空间之前，别轻易在源码目录里建"看起来很合理"的同名文件。**
