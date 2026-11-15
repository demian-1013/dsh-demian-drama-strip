# 上架清单（两条路线，先走 B）

包已经做完、本机装好、验证过。剩下的全在浏览器里，不需要终端。

---

## 路线 B：只发 GitHub（零安装，现在就能做）

市场认 GitHub-only 条目——列表里写明"GitHub 上的条目仍可用旁边那条命令安装"，所以不发 npm 也能被收录。

### B1. 建仓库

打开 <https://github.com/new>

- Repository name：`dsh-demian-drama-strip`
- 选 **Public**
- **不要**勾 Add a README / .gitignore / license（勾了就不能直接拖文件）
- Create repository

### B2. 拖文件上去

空仓库页面上有一行 `…or upload an existing file`，点它。

然后打开资源管理器到：

```
C:\Users\PC\Documents\deepseek-harness\default-workspace\demian-drama-strip
```

`Ctrl+A` 全选（会带上 `skills`、`locale`、`market` 三个文件夹），拖进浏览器上传区，等它把 11 个文件列出来，点 **Commit changes**。

> 用 Chrome / Edge。拖文件夹进去 GitHub 会自己递归展开。
> 上传完点进仓库根目录，应该能看到 `package.json`、`index.js`、`skills/`——如果只看到文件夹没有 `package.json`，说明拖的时候选错了层级。

### B3. 提收录 PR

1. 打开 <https://github.com/awesome-dsh-plugin/awesome-dsh-plugin> → 右上 **Fork** → Create fork
2. 在你 fork 的仓库里点开 `README.md` → 右上铅笔图标（Edit）
3. 找到 `### Skills` 这一段，在**这段最后一条之后**粘一行 —— 内容在 [PR.md](PR.md) 的"英文 README.md 要加的行"
4. 往下滚，Commit changes（commit message 随便写，如 `Add dsh-demian-drama-strip`）
5. 同样的操作对 `README.zh.md` 做一次（用 PR.md 里的中文行）
6. 回到你 fork 的仓库首页，会出现 **Contribute → Open pull request**，标题和正文照抄 [PR.md](PR.md)

---

## 路线 A：发 npm（可选，装了 Node.js 之后）

npm 装起来更快（用户 `dsh plugin add dsh-demian-drama-strip` 就行，不用克隆仓库），所以值得补。

1. 装 Node.js LTS：<https://nodejs.org/zh-cn>（自带 npm）；再装 Git：<https://git-scm.com/download/win>
2. 双击本目录的 `发布.cmd`，它依次做：检查打包清单 → `npm login` → `npm publish --access public` → `git init/commit/push` → 回填 `entry.json`
3. 发完之后把 `market/entry.json` 里的
   - `"npm": ""` → `"npm": "dsh-demian-drama-strip"`
   - `"install": "...github:..."` → `"install": "dsh plugin --profile web add dsh-demian-drama-strip"`
   再走一次 B3 的 PR（如果 B3 已经合并了，就单独提一个小 PR 改这两行，或者直接给维护者留言）。

---

## 已经准备好的东西

| 文件 | 用途 |
|---|---|
| `market/entry.json` | 市场条目（owner 已填 `demian-1013`，GitHub-only 形式） |
| `market/PR.md` | PR 标题 + 正文 + 中英双语两行条目，复制即用 |
| `发布.cmd` | 路线 A 的一键脚本（npm + git 都齐了才有用） |
| `README.md` | 仓库首页说明，已写两种安装方式 |

## 常见卡点

- **拖上去了但技能不生效**：`skills/drama-strip/SKILL.md` 必须保持这个层级，`index.js` 是按相对路径读它的。
- **PR 被要求补 npm 包**：维护者偶尔会这么要求，那时再走路线 A。
- **仓库名带大写或空格**：不行，DSh 的 `github:owner/repo` 标识区分大小写，保持全小写带连字符。
