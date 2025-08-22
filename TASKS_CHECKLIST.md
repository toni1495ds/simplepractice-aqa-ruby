# Tasks – Happy-Path Checklist

## 1. Navigation & Visibility

- [ ] From the dashboard after login, user can open **Tasks** from the sidebar.
- [ ] **Tasks** page loads without errors and shows key controls: _Add quick task_, _Create task_, **All/Incomplete/Completed**, **Assigned to…**, and sorting options (**Custom/Due date/Date created/Priority**).
- [ ] By default, **Assigned to you** + **All** filter displays the user’s tasks.

## 2. Quick Add – Create

- [ ] Create a task with **Add quick task** by typing a title and pressing **Enter**.
- [ ] The new task appears in the **Incomplete** list with the correct title.
- [ ] Task title is clickable (opens detail or inline view).
- [ ] Task persists after refreshing the page.

## 3. Full Form – Create

- [ ] Open **Create task** and create a task with only a **Title** → **Save** works.
- [ ] Create with **Title + Description** → task saves and description is visible in detail.
- [ ] Create with **Due on (date & time)** → task saves and due date displays correctly.
- [ ] Create with **Priority** (e.g., Medium/High) → priority is visible on the task.
- [ ] Create with **Client** (if available) → client displays in the task.
- [ ] Create with **Assigned to (team member)** → task shows up when filtered by that member.
- [ ] Attach a **file** within limits and save → attachment is visible in the task.
- [ ] **Cancel** button closes modal without creating a task.

## 4. Complete (mark as done)

- [ ] Mark an **Incomplete** task as **Completed** via checkbox.
- [ ] Task disappears from **Incomplete** (depending on active filter).
- [ ] Switch to **Completed** filter → task appears with green check.
- [ ] Open completed task → confirmation message is shown (e.g., _“Task marked as completed on …”_).

## 5. Filters

- [ ] **All** shows both completed and incomplete tasks.
- [ ] **Incomplete** shows only active tasks.
- [ ] **Completed** shows only done tasks.
- [ ] **Assigned to you** filter shows only user’s tasks.
- [ ] Switch **Assigned to** another role/member → tasks for that member appear.
- [ ] **Search** finds tasks by title.

## 6. Sorting

- [ ] **Custom** (default) keeps manual/creation order.
- [ ] **Date created** sorts by creation time.
- [ ] **Due date** sorts by due dates (if set).
- [ ] **Priority** sorts by assigned priority.

## 7. Task Details (View)

- [ ] Clicking an **Incomplete** task opens detail view with **Title** and **Description**.
- [ ] Clicking a **Completed** task shows completion info with **date/time**.
- [ ] Detail view can be closed with **Okay** or **X**.

## 8. Assignment

- [ ] Create task **Assigned to you** → appears under “Assigned to you.”
- [ ] Create task assigned to **another member** → appears when filter switched to that member or **All**.

## 9. Persistence & Refresh

- [ ] After creating or completing a task, refreshing the page preserves state (created/completed) and respects filters/sorting.

---

### Scope

- Covers **happy paths only** (positive flows, expected results).
- Excludes negative/edge cases (empty fields, invalid data, large attachments, network errors).
