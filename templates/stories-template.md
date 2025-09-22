# STORIES BREAKDOWN

**Created**: [DATE]
**Epic Ticket**: [EPIC_TICKET]
**Max Stories**: [MAX_STORIES]
**Input**: User description: "$ARGUMENTS"

## Execution Flow (main)
```
1. Parse epic description from Input
   → If empty: ERROR "No epic description provided"
2. Extract business goals and high-level outcomes
   → Identify: target users, problems, expected value, constraints
3. Determine number of User Stories for each Epic (≤ [MAX_STORIES])
   → If fewer than 1: ERROR "Cannot generate user stories"
   → If more than [MAX_STORIES]: merge related ones
4. For each User Story:
   → Assign short Title (≤ 6 words, business-oriented)
   → Write Statement in the format: "As a [persona], I want to [action], so that [desired outcome]"
       → If missing info: mark with [NEEDS CLARIFICATION: specific question]
   → Write Acceptance Criteria:
       → Use GWTS (GIVEN–WHEN–THEN–SHALL) and/or ITS (IF–THEN–SHALL) formats
       → Each criterion must be testable, ≤ 10 words per part
       → Include edge cases
       → No more than 7 criteria per story
       → If missing info: mark with [NEEDS CLARIFICATION: specific question]
5. Run Review Checklist
   → If any technical implementation details detected: ERROR "Remove technical details"
   → If Statement or Acceptance Criteria missing mandatory parts: ERROR "Incomplete user story"
   → Check against Review & Acceptance Checklist” (so it’s explicitly connected)
6. Return: SUCCESS (user stories ready for task decomposition)
```

---

## ⚡ Quick Guidelines
- ✅ Focus on WHAT users need and WHY
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure)
- 👥 Written for business stakeholders, not developers

### For AI Generation
When creating this spec from a user prompt:
1. **Mark all ambiguities**: Use [NEEDS CLARIFICATION: specific question] for any missing or unclear part (persona, action, outcome, acceptance criteria, dependencies)
2. **Don't guess**: If the prompt doesn’t specify something (e.g., who the persona is, or what happens in an edge case), mark it instead of inventing
3. **Think like a product manager**: Each User Story must represent clear business value; vague or overlapping stories should be flagged
4. **Common underspecified areas**:
 - Persona (who exactly performs the action)
 - Desired outcome (why the action is valuable)
 - Acceptance Criteria (edge cases, negative scenarios, measurable results)

---

## User Stories
### User Story 1
**Title**: [short story name]
**Statement**: [AS A `persona`, I `want to action`, `SO that desired outcome`. Example: As a registered customer, I want to save items to a wishlist, so that I can purchase them later without searching again.]
**Acceptance Criteria (GWTS)**: [GIVEN `the beginning state of the scenario` WHEN `specific action that the user makes` THEN `the entity that is affected by the action` SHALL `the expected outcome or result`. Example:
1. GIVEN the user is logged in WHEN the user clicks "Add to Wishlist" on a product page THEN the wishlist entity SHALL include that product
2. GIVEN the user has an active subscription WHEN the user clicks "Download Report" THEN the reporting service SHALL generate the file and make it available for download]
**Acceptance Criteria (ITS)**: [IF `a certain state or event that occurs` THEN `the entity that is affected` SHALL `the expected outcome or result`. Example:
1. IF the product is already in the wishlist THEN the wishlist SHALL not create a duplicate entry
2. IF the product is out of stock THEN the checkout button SHALL be disabled]

<!-- Repeat ≤[MAX_STORIES] stories -->

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [ ] No implementation details (languages, frameworks, APIs)
- [ ] Focused on user value and business needs
- [ ] Written for non-technical stakeholders
- [ ] **Statement**: all parts filled (persona, want to action, desired outcome)
- [ ] **Statement**: written as a single sentence
- [ ] **Statement**: contains no technical details
- [ ] **Acceptance Criteria**: each criterion is testable (can be verified)
- [ ] **Acceptance Criteria**: all parts are filled (GIVEN, WHEN, THEN, SHALL / IF, THEN, SHALL)
- [ ] **Acceptance Criteria**: each part ≤ 10 words
- [ ] **Acceptance Criteria**: criteria include edge cases
- [ ] **Acceptance Criteria**: max 7 criteria per User Story
- [ ] **Acceptance Criteria**: contain no technical details

### Requirement Completeness
- [ ] Statement contains all required parts (persona, want to action, desired outcome)
- [ ] Statement is written as one complete sentence
- [ ] Acceptance Criteria are present for the User Story
- [ ] Each Acceptance Criterion contains all mandatory parts (GIVEN, WHEN, THEN, SHALL / IF, THEN, SHALL)
- [ ] No unresolved [NEEDS CLARIFICATION] markers remain (or collected under Open Questions)

---

## Execution Status
*Updated by main() during processing*

- [ ] Epic description parsed
- [ ] Business goals and outcomes extracted
- [ ] Ambiguities marked
- [ ] User Stories generated with Titles
- [ ] Statements written (persona, action, desired outcome)
- [ ] Acceptance Criteria (GWTS/ITS) defined and validated
- [ ] Review checklist passed

---
