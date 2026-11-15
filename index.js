// Demian Drama Strip — registers the "demian-drama-strip" skill.
//
// The skill body lives next to this file in skills/drama-strip/SKILL.md and is
// registered into this profile's global skill layer, so every session in the
// profile can invoke it with the `skill` tool.

import { readFileSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

export const name = 'demian-drama-strip'
export const inject = ['skills']

const SKILL_NAME = 'demian-drama-strip'
const SKILL_DIR = join(dirname(fileURLToPath(import.meta.url)), 'skills', 'drama-strip')
const SKILL_FILE = join(SKILL_DIR, 'SKILL.md')

function frontmatterField(source, field) {
  const block = /^---\r?\n([\s\S]*?)\r?\n---/.exec(source)
  if (!block) return undefined
  const line = new RegExp(`^${field}:\\s*(.+)$`, 'm').exec(block[1])
  return line ? line[1].trim() : undefined
}

export function apply(ctx) {
  const content = readFileSync(SKILL_FILE, 'utf8')
  const description = frontmatterField(content, 'description') ?? 'Turn a short drama episode into a storyboard and screenplay.'
  const whenToUse = frontmatterField(content, 'whenToUse')

  ctx.effect(() =>
    ctx.skills.register({
      name: SKILL_NAME,
      description,
      ...(whenToUse ? { whenToUse } : {}),
      content,
      source: 'bundled',
      invocation: { modelInvocable: true, userInvocable: true },
      resourceBase: { kind: 'directory', path: SKILL_DIR },
    }),
  )
}
