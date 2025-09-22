---
description: Create or update the epic breakdown from a natural language project description.
scripts:
  sh: scripts/bash/create-epics.sh --json "{ARGS}"
  ps: scripts/powershell/create-new-feature.ps1 -Json "{ARGS}"
---

The user input to you can be provided directly by the agent or in `$ARGUMENTS` — you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/epics` in the triggering message **is** the project description. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that project description, do this:

1. Run the script `{SCRIPT}` from repo root and parse its JSON output for BRANCH_NAME and EPIC_FILE. All file paths must be absolute.  
   **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output — always refer to it to get the actual content you're looking for.  
2. Load `templates/epic-template.md` to understand required sections.  
3. Write the epic breakdown to EPIC_FILE using the template structure, replacing placeholders with concrete details derived from the project description (arguments) while preserving section order and headings.  
   - Fill in the Execution Flow, Guidelines, Epics (N epics with business goals, scope in/out, notes), and Checklists as per template.  
   - Mark missing information with `[NEEDS CLARIFICATION: specific question]`.  
4. Report completion with branch name, spec file path, and readiness for the next phase.

Note: The script creates and checks out the new branch and initializes the spec file before writing.
