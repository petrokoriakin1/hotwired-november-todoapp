# Integrate turbo-streams UI changes

## Summary

Rebase `turbo-streams` branch onto `main` and integrate improved dashboard and templates UI. This PR merges two dashboard enhancement commits that were previously based on an older main branch, bringing them up-to-date with current development while preserving all UX improvements.

### Key Changes

- **Dashboard view refactor**: Improved task list and templates card UI with better styling, spacing, and responsiveness.
- **Templates preview system**: Added expandable "Sample Data" sections for templates with index-based toggles (fixes scope issues in the original inline script).
- **Quick template list**: Added a compact template list view at the bottom of the templates grid for quick scanning.
- **Improved form helpers**: Refactored inline JavaScript with parameterized `toggleSampleData()` function to support multiple template previews simultaneously.
- **Better accessibility**: Added semantic spacing, improved text colors, and button state management.

## Commits Included

```
a177158 (HEAD -> turbo-streams) few more dashboard things
cc041c2 init da thread
```

Both commits were rebased onto `origin/main` (c09f23c) and conflict-merged to preserve the best of both versions.

## Changed Files

```
app/views/home/dashboard.html.erb | 136 +++++++++++++++++++++++++++++++++++-----------------------------------------
1 file changed, 63 insertions(+), 73 deletions(-)
```

### File Details

#### `app/views/home/dashboard.html.erb`

**Before**: Two separate commits with conflicting template layouts (one card-based with sample data, one simpler list-based).

**After**: Unified layout combining:
- Task list grid with clean card UI
- Rich template cards with:
  - Title, description, action buttons (Use, Edit, Delete)
  - Expandable sample data preview per template
  - Index-based element IDs to avoid conflicts
- Quick template list at bottom for at-a-glance browsing
- Improved `toggleSampleData()` function with ID/buttonId params

**Changes**:
- Removed duplicated script logic
- Consolidated template rendering into single loop with index tracking
- Fixed sample data toggling to be per-template (not global)
- Improved Tailwind class consistency and spacing
- Added responsive grid layout with `col-span-full` for quick list

## Testing

✅ **All tests passing**: 36 examples, 0 failures
```
bundle exec rspec --format documentation
```

Test coverage includes:
- Task marking and listing
- List CRUD operations
- Service layer composition and promotion
- Template application
- Data seeding and cleanup

## Rebase Notes

This branch was originally diverged from an earlier `main`. The rebase resolved conflicts in `app/views/home/dashboard.html.erb` by:
1. Keeping the richer card-based UI from `origin/main`'s HEAD
2. Incorporating the template improvements from the incoming `turbo-streams` commits
3. Merging both approaches into a single cohesive template

Commits automatically dropped during rebase:
- `d269b08` (some basic wireframes) — patch contents already upstream
- `b70ab19` (minor tweaks: the useless) — patch contents already upstream

**Current state**:
- `turbo-streams` is 2 commits ahead of `origin/main`
- Clean working tree
- All tests pass

## How to Review

1. **Visual review**: Open the dashboard at `http://localhost:3000` and check:
   - Task list cards render correctly
   - Template cards display with proper spacing
   - "Use Template", "Edit", and "Delete" buttons are styled consistently
   - "Show More" button toggles sample data correctly for each template
   - Quick template list at bottom is readable

2. **Code review**:
   - Check `app/views/home/dashboard.html.erb` for ERB template clarity
   - Verify Tailwind classes are consistent with app's design system
   - Confirm no inline scripts conflict with Turbo Stream behavior

3. **Testing**:
   - Run `bundle exec rspec` locally (all pass)
   - Test template preview expansion/collapse
   - Verify no JavaScript console errors

## Checklist

- [ ] Code review passed
- [ ] Visual review in browser confirmed
- [ ] All tests passing locally
- [ ] No conflicts with Turbo Streams or other JS behaviors
- [ ] Tailwind classes consistent with design system
- [ ] Inline script to be refactored into proper JS (noted in code comment)
- [ ] Ready to merge to `main`

## Future Improvements

- **TODO**: Extract inline JavaScript helpers into a proper Stimulus controller or shared JavaScript module
- **TODO**: Add model-level sample data association if templates expand to use dynamic sample sections
- **TODO**: Consider adding animation transitions for expand/collapse (Tailwind transitions or HTMX)

## Context Dump

### Branch Information
```
Current branch: turbo-streams
Tracking: origin/turbo-streams
Status: ahead 2, behind 0 (vs origin/main)
```

### Rebase Timeline
- **Original turbo-streams branch**: Diverged ~2 years ago from main
- **Commits rebase**: 2 commits brought onto current main (c09f23c)
- **Conflicts resolved**: 1 file (`app/views/home/dashboard.html.erb`)
- **Test result**: ✅ All 36 examples pass

### Affected Views
- `app/views/home/dashboard.html.erb` — dashboard landing page

### Models Involved
- `List` — task list/project
- `Task` — individual task with completion status
- `Section` — task grouping within a list
- `Template` — reusable task list template

### Controllers Referenced
- `HomeController` — serves dashboard view (populates `@tasklists`, `@templates`)

---

**PR Author**: GitHub Copilot (via rebase & conflict resolution)  
**Date**: November 27, 2025  
**Base Branch**: main  
**Compare Branch**: turbo-streams  
