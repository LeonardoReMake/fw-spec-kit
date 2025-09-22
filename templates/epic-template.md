# EPIC BREAKDOWN

**Created**: [DATE]
**Max Epics**: [MAX_EPICS]
**Input**: User description: "$ARGUMENTS"

## Execution Flow (main)
```
1. Parse project description from Input
   → If empty: ERROR "No project description provided"
2. Extract business goals and high-level outcomes
   → Identify: target users, problems, expected value, constraints
3. Determine number of Epics (≤ [MAX_EPICS])
   → If fewer than 1: ERROR "Cannot generate epics"
   → If more than max_epics: merge related ones
4. For each Epic:
   → Assign short name (≤ 6 words, business-oriented)
   → Write Business Goal (2–3 sentences, value only)
   → Fill all template fields: Scope in/out, Notes
   → If missing info: mark with [NEEDS CLARIFICATION: specific question]
5. Run Review Checklist
   → If any technical implementation details detected: ERROR "Remove technical details"
   → If Epics overlap strongly: WARN "Revise epic boundaries"
   → Check against Review & Acceptance Checklist” (so it’s explicitly connected)
6. Return: SUCCESS (epic breakdown ready for planning)
```

---

## ⚡ Quick Guidelines
- ✅ Focus on WHAT users need and WHY
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure)
- 👥 Written for business stakeholders, not developers

### For AI Generation
When creating this spec from a user prompt:
1. **Mark all ambiguities**: Use [NEEDS CLARIFICATION: specific question] for any assumption you'd need to make
2. **Don't guess**: If the prompt doesn't specify something (e.g., "login system" without auth method), mark it
3. **Think like a product manager**: Each epic must represent a clear business value; vague or overlapping items should be flagged
4. **Common underspecified areas**:
 - Target user segments and their needs
 - Business goals
 - Boundaries of each epic (what’s in vs. out of scope)

---

## Epics
### EPIC 1 — [short epic name]
**Business goal**: [epic business goal, e.g. Enable business users to easily create, update, and organize product listings so customers can quickly discover available offerings.]
**Scope (in)**: [list of the main areas of work, example: 
- Create and edit product records  
- Categorize products and manage tags  
- Upload images and descriptions]  
**Scope (out)**: [what is explicitly NOT included in this epic, example:
- Automated inventory replenishment  
- Supplier contract management  
- Advanced pricing optimization features]  
**Notes for refinement**: [what should be clarified at the next level of detail, example:
- Clarify who has permission to manage product data (admins vs. regular staff)  
- Define maximum expected catalog size to guide performance considerations  
- Confirm whether multilingual product descriptions are required]  

<!-- Repeat until [MAX_EPICS] epics -->

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [ ] No implementation details (languages, frameworks, APIs)
- [ ] Focused on user value and business needs
- [ ] Written for non-technical stakeholders

### Requirement Completeness
- [ ] Scope is clearly bounded
- [ ] No unresolved [NEEDS CLARIFICATION] markers remain (or collected under Open Questions)
- [ ] Notes for refinement highlight open points for next-level planning

---

## Execution Status
*Updated by main() during processing*

- [ ] User description parsed
- [ ] Business goals and outcomes extracted
- [ ] Ambiguities marked
- [ ] Epics generated with business goals
- [ ] Scope (in/out) defined for each epic
- [ ] Notes for refinement captured
- [ ] Review checklist passed

---
