"""Check recommendation files, the index, Cursor rules, and agent prompts."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REC_ROOT = ROOT / ".cursor" / "recommendations"
RULES_ROOT = ROOT / ".cursor" / "rules"
AGENTS_ROOT = ROOT / ".cursor" / "agents"
INDEX_PATH = REC_ROOT / "index.md"

SCOPES = {
    "stack",
    "backend",
    "frontend",
    "comments",
    "naming",
    "docs",
    "cicd",
    "modularity",
}
STATUSES = {"draft", "active"}
SECTIONS = ("## Rule", "## Why", "## Exceptions")
LINK_RE = re.compile(r"(?<![\w])\[[^\]]+\]\(([^)\s]+)")


def parse_frontmatter(text: str) -> tuple[dict[str, str], str]:
    if not text.startswith("---"):
        return {}, text
    parts = text.split("---", 2)
    if len(parts) < 3:
        return {}, text
    fields: dict[str, str] = {}
    for line in parts[1].splitlines():
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        fields[key.strip()] = value.strip().strip("\"'")
    return fields, parts[2]


def recommendation_files() -> list[Path]:
    return sorted(
        path
        for path in REC_ROOT.rglob("*.md")
        if path.name != "index.md"
    )


def check_recommendations(errors: list[str]) -> dict[Path, dict[str, str]]:
    found: dict[Path, dict[str, str]] = {}
    ids: dict[str, Path] = {}
    for path in recommendation_files():
        rel = path.relative_to(ROOT).as_posix()
        fields, body = parse_frontmatter(path.read_text(encoding="utf-8"))
        found[path] = fields
        for key in ("id", "scope", "status"):
            if not fields.get(key):
                errors.append(f"{rel} is missing {key}")
        scope = fields.get("scope", "")
        status = fields.get("status", "")
        rec_id = fields.get("id", "")
        if scope and scope not in SCOPES:
            errors.append(f"{rel} has unknown scope {scope}")
        if scope and path.parent.name != scope:
            errors.append(f"{rel} lives outside the {scope} folder")
        if status and status not in STATUSES:
            errors.append(f"{rel} has unknown status {status}")
        if rec_id:
            previous = ids.get(rec_id)
            if previous is not None:
                errors.append(
                    f"{rel} repeats id {rec_id} from "
                    f"{previous.relative_to(ROOT).as_posix()}"
                )
            ids[rec_id] = path
        body_lines = body.splitlines()
        for section in SECTIONS:
            if section not in body_lines:
                errors.append(f"{rel} is missing {section}")
        if "## Examples" in body_lines:
            errors.append(f"{rel} must not have an Examples section")
        if "```" in body:
            errors.append(f"{rel} must not contain a code block")
    return found


def check_index(errors: list[str], found: dict[Path, dict[str, str]]) -> None:
    if not INDEX_PATH.is_file():
        errors.append(".cursor/recommendations/index.md is missing")
        return
    listed: dict[Path, tuple[str, str, str]] = {}
    for line in INDEX_PATH.read_text(encoding="utf-8").splitlines():
        if not line.startswith("|"):
            continue
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if len(cells) != 4 or cells[0] in {"id", "---"} or set(cells[0]) <= {"-"}:
            continue
        rec_id, file_cell, scope, status = cells
        path = ROOT / Path(file_cell)
        listed[path] = (rec_id, scope, status)
        rel = file_cell.replace("\\", "/")
        if not path.is_file():
            errors.append(f"index lists missing file {rel}")
            continue
        fields = found.get(path)
        if fields is None:
            errors.append(f"index lists a non-recommendation file {rel}")
            continue
        if fields.get("id") != rec_id:
            errors.append(f"{rel} id does not match the index")
        if fields.get("scope") != scope:
            errors.append(f"{rel} scope does not match the index")
        if fields.get("status") != status:
            errors.append(f"{rel} status does not match the index")
    for path in found:
        if path not in listed:
            rel = path.relative_to(ROOT).as_posix()
            errors.append(f"{rel} is missing from the index")


def check_rules(errors: list[str]) -> None:
    if not RULES_ROOT.is_dir():
        errors.append(".cursor/rules is missing")
        return
    for path in sorted(RULES_ROOT.glob("*.mdc")):
        text = path.read_text(encoding="utf-8")
        rel = path.relative_to(ROOT).as_posix()
        fields, _body = parse_frontmatter(text)
        if not fields.get("description"):
            errors.append(f"{rel} is missing description")
        always = fields.get("alwaysApply", "").lower() == "true"
        if not always and not fields.get("globs"):
            errors.append(f"{rel} needs alwaysApply or globs")
        for match in LINK_RE.finditer(text):
            target = match.group(1).split("#", 1)[0]
            if not target or target.startswith(("http://", "https://", "mailto:")):
                continue
            resolved = (path.parent / target).resolve()
            if not resolved.exists():
                errors.append(f"{rel} links to missing {target}")


def check_agents(errors: list[str]) -> None:
    if not AGENTS_ROOT.is_dir():
        errors.append(".cursor/agents is missing")
        return
    for path in sorted(AGENTS_ROOT.glob("*.md")):
        rel = path.relative_to(ROOT).as_posix()
        fields, _body = parse_frontmatter(path.read_text(encoding="utf-8"))
        if not fields.get("name"):
            errors.append(f"{rel} is missing name")
        if not fields.get("description"):
            errors.append(f"{rel} is missing description")


def main() -> int:
    errors: list[str] = []
    found = check_recommendations(errors)
    check_index(errors, found)
    check_rules(errors)
    check_agents(errors)
    if errors:
        for error in errors:
            print(f"ERROR {error}")
        return 1
    print(f"OK {len(found)} recommendations")
    return 0


if __name__ == "__main__":
    sys.exit(main())
