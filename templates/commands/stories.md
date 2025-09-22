---
description: Generate User Stories from an Epic description and render a markdown document.
scripts:
  sh: scripts/bash/create-stories.sh --json "{ARGS}"
  ps: scripts/powershell/create-new-feature.ps1 -Json "{ARGS}"
---

The user input to you can be provided directly by the agent or in `$ARGUMENTS` — you **MUST** consider it before proceeding with the prompt (if not empty).

User input:

$ARGUMENTS

The text the user typed after `/stories` in the triggering message **is** the epic description. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that project description, do this:

1. Run the script `{SCRIPT}` from repo root and parse its JSON output for BRANCH_NAME and STORIES_FILE. All file paths must be absolute.  
   **IMPORTANT** You must only ever run this script once. The JSON is provided in the terminal as output — always refer to it to get the actual content you're looking for.  
2. Load `templates/stories-template.md` to understand required sections.  
3. Write the stories breakdown to STORIES_FILE using the template structure, replacing placeholders with concrete details derived from the epic description (arguments) while preserving section order and headings.  
   - Fill in the Execution Flow, Guidelines, User Stories (≤MAX_STORIES with Title, Statement, Acceptance Criteria (GWTS / ITS)), and Checklists as per template.
   - Mark missing information with `[NEEDS CLARIFICATION: specific question]`.  
4. Report completion with branch name, spec file path, and readiness for the next phase.

Note: The script creates and checks out the new branch and initializes the spec file before writing.
