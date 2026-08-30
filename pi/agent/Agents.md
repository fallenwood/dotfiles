## Search Discipline

1. Search with built-in grep / find.
   For multiple OR terms, use one multi_grep.
   If Bash is unavoidable, use rg instead of grep.

2. After locating the target, use read with offset / limit
   and only inspect nearby lines.
   For known files outside the workspace, use read directly.

## Others
1. Reads `$HOME/.agents/Agents.md` if present

