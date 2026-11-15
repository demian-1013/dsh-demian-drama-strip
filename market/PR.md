# 收录 PR：awesome-dsh-plugin

仓库：<https://github.com/awesome-dsh-plugin/awesome-dsh-plugin>
要改的文件：`README.md`（英文列表）+ `README.zh.md`（中文列表）
账号：`demian-1013`

## 加在哪

`README.md` 里 `### Skills` 这一段，**插在这一段最后一条之后**（不要新开小节，不要动排列顺序）。
`README.zh.md` 里对应的中文 Skills 小节，同级位置。

## 英文 README.md 要加的行（直接复制）

```markdown
- [demian-1013/dsh-demian-drama-strip](https://github.com/demian-1013/dsh-demian-drama-strip) - Turns a short-drama episode into a shot-by-shot storyboard and a shootable screenplay: one representative frame per shot gives only composition, so camera moves and subject motion come from ffmpeg 4fps frame-diff contact sheets, luma jumps (signalstats YAVG) locate transitions and flashbacks where blackdetect misses the fade-in cut, hard subtitles are read from a cropped bottom-band sheet, and fight or crowd scenes get their own sampling rates; scripts follow Kenny SOP 1.7.2 strict mode and are machine-checked for length, scene count, consecutive shot lines and OS/VO ratio. Needs ffmpeg; no network and no credentials. Install: `dsh plugin --profile web add github:demian-1013/dsh-demian-drama-strip`
```

## 中文 README.zh.md 要加的行

```markdown
- [demian-1013/dsh-demian-drama-strip](https://github.com/demian-1013/dsh-demian-drama-strip) - 把短剧/短视频扒成「运镜分镜表 + 可拍摄剧本」：每个镜头只取一帧只能读构图，运镜和主体运动靠 ffmpeg 4fps 连拍拼图做帧间差分，亮度跳变（signalstats YAVG）定位转场与闪回（blackdetect 会漏掉淡出型回忆切入），硬字幕从底部条带裁切拼图读，打戏与群戏各有自己的采样率；剧本按 Kenny SOP 1.7.2 严格版产出并机器自检字数、场次、连续画面行与 OS/VO 占比。依赖 ffmpeg，不联网、不读凭据。安装：`dsh plugin --profile web add github:demian-1013/dsh-demian-drama-strip`
```

## PR 标题

```
Add dsh-demian-drama-strip (Skills)
```

## PR 正文

```markdown
Adds `dsh-demian-drama-strip`, a skills bundle that turns a short-drama episode into a
shot-by-shot storyboard and a shootable screenplay. GitHub-only for now (no npm release yet).

**Why it is not just "describe the frames":** a storyboard tool samples one frame per shot,
which only ever yields composition. Camera moves and subject motion are not in a still, so this
skill pulls 4fps frame-diff contact sheets with ffmpeg (`fps=4,scale=...,tile=5x8` with a burned
timecode), reads motion off those, and refuses to write movement lines it has not actually seen.
Transitions come from `signalstats` luma jumps (`|ΔYAVG|>25`, dark at `<20`), because
`blackdetect` misses the fade-in cut into a flashback. Hard subtitles are read from a cropped
bottom band rather than a lossy strip OCR. Fight scenes (5–6fps for grappling, 8–10fps for real
choreography) and crowd scenes (2–3fps for density, one full-res still for symmetry) get their
own rates. The screenplay step follows Kenny SOP 1.7.2 strict mode and is checked by script for
character count, scene count, consecutive shot lines and OS/VO ratio.

**Install**

```sh
dsh plugin --profile web add github:demian-1013/dsh-demian-drama-strip
```

**Claims, so they can be counted:** one skill, zero tools, zero commands, no network calls, no
credential reads. It reads video files the user points it at and writes storyboard images and
markdown reports into the workspace.

**Dependency:** ffmpeg on PATH (README documents a fallback lookup order).

Verified locally: installs with `dsh plugin add`, the skill appears in the catalog with the
description above, and the one-line entry matches what it does.
```
