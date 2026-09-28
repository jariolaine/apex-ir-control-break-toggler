# Oracle APEX IR Control Break Toggler

**IR Control Break Toggler** is a Dynamic Action plug-in for Oracle APEX that
adds expand/collapse controls to control-break groups in an Interactive Report.

Release 1.1.0 also includes the optional **IR Control Break Action** companion
plug-in for declarative APEX 26.1 Button Trigger Actions such as Expand All,
Collapse All, and Reset State.

## Compatibility

- Oracle APEX 26.1 or later
- Interactive Report regions
- Release version: **1.1.0**

## Features

- Adds an icon toggle button to each Interactive Report control-break header.
- Expands or collapses individual control-break groups.
- Supports an initial expanded or collapsed state.
- Can remember the state of individual control-break groups.
- Supports session-based and persistent browser storage.
- Supports logical start or end button positioning, including RTL layouts.
- Provides application-scope attributes for button titles, icons, and CSS
  classes.
- Provides component-scope settings for initial state, remembered state, and
  button position.
- Maintains `aria-expanded` and accessible button labels.
- Adds `aria-controls` relationships between each toggle button and the rows it
  controls.
- Provides declarative Expand All, Collapse All, and Reset State Button Trigger
  Actions through the optional companion plug-in.
- Provides public JavaScript API methods to expand all groups, collapse all
  groups, and reset remembered state for an individual report region.
- Exposes the **Control Break Change** Dynamic Action event when control-break
  state changes.
- Uses the APEX JavaScript debug API for useful initialization, action, warning,
  error, and event-data diagnostics.
- Safely supports repeated initialization without duplicate event handlers or
  toggle buttons.

## Installation

Download the latest plug-in exports from the
[GitHub Releases](https://github.com/jariolaine/apex-ir-control-break-toggler/releases/latest)
page.

The main plug-in is required:

```text
dynamic_action_plugin_fi_jaris_ir_control_break_toggler.sql
```

For declarative Button Trigger Actions, also install the optional companion
plug-in:

```text
dynamic_action_plugin_fi_jaris_ir_control_break_action.sql
```

Import the required exports into `Shared Components > Plug-ins`.

The **IR Control Break Action** companion plug-in does not initialize an
Interactive Report. Its target report must already be initialized by
**IR Control Break Toggler**.

## Usage

For a typical single Interactive Report, create a Dynamic Action on the report
region.

Configure it as follows:

| Property | Value |
| --- | --- |
| Event | **After Refresh** |
| Selection Type | **Region** |
| Region | *Your Interactive Report* |

Add a True Action and configure it as follows:

| Property | Value |
| --- | --- |
| Action | **IR Control Break Toggler [Plug-In]** |
| Fire on Initialization | **Yes** |

The plug-in operates on the Interactive Report that triggers the Dynamic Action.
No Affected Elements configuration is required.

The plug-in runs when the page loads and after the Interactive Report is
refreshed, adding a toggle button to each control-break header.

If the report contains no control breaks, the plug-in makes no changes.

Initialization can also receive multiple matched region elements, for example
from a Dynamic Action that uses a jQuery Selector. Each matched report is
initialized as an independent plug-in instance.

## Component Settings

### Initially Expanded

Scope: **Component**

Controls the initial state of the control-break groups for the Dynamic Action
instance.

- **Yes** — groups start expanded.
- **No** — groups start collapsed.

Default: **Yes**

If remembered state exists for a group, the remembered state takes precedence
over **Initially Expanded**.

If **Initially Expanded** is later changed, previously remembered group states
are discarded and the new initial setting is applied.

### Remember State

Scope: **Component**

Controls whether the expand/collapse state of each control-break group is
remembered.

| Value | Behavior |
| --- | --- |
| **Do Not Remember** | No state is stored. Groups use **Initially Expanded** whenever the plug-in initializes. |
| **Browser Session** | State is remembered for the current browser session. |
| **Future Sessions** | State is stored persistently in the current browser profile. |

Default: **Do Not Remember**

Browser-session storage survives Interactive Report refreshes and page
navigation during the current browser session.

Persistent storage survives browser restarts until the browser storage is
cleared or the plug-in configuration invalidates the stored state.

Persistent state belongs to the current browser and browser profile. It does
not follow the authenticated user to another browser or device.

### Button Position

Scope: **Component**

Controls where the control-break toggle button is displayed within the
control-break header.

| Value | Behavior |
| --- | --- |
| **Start** | Places the button at the logical start of the control-break header. |
| **End** | Places the button at the logical end of the control-break header. |

Default: **Start**

The position follows the report text direction, so start and end also work
correctly in right-to-left layouts.

When **Expand Icon** is not explicitly configured, the plug-in automatically
selects a directional chevron based on the button position and the computed
text direction of the report region.

## Application-Scope Attributes

The following plug-in attributes have **Application** scope and are shared by
all instances of the plug-in in the application.

| Attribute | Purpose | Default / Example |
| --- | --- | --- |
| Collapse Title | Button title and accessible label when a group is expanded | `Collapse` |
| Expand Title | Button title and accessible label when a group is collapsed | `Expand` |
| Collapse Icon | Font APEX icon used for the collapse action | `fa-chevron-down` |
| Expand Icon | Font APEX icon used for the expand action | Automatic when empty |
| Button CSS Classes | CSS classes applied to the toggle button | `t-Button t-Button--noLabel t-Button--icon t-Button--small` |

**Collapse Title** and **Expand Title** support APEX substitution processing.

When **Expand Icon** is empty, the plug-in automatically selects a directional
chevron based on **Button Position** and the report text direction.

For example, in a left-to-right layout:

- **Start** uses `fa-chevron-right`.
- **End** uses `fa-chevron-left`.

The plug-in automatically adds the internal class:

```text
ir-control-break-btn
```

Do not add that class to **Button CSS Classes**.

## Accessibility

Each control-break toggle is rendered as a native icon-only `<button>`.

The plug-in:

- Maintains `aria-expanded` to reflect the current state.
- Uses **Collapse Title** and **Expand Title** as the button title and accessible
  label.
- Marks the icon as decorative with `aria-hidden="true"`.
- Adds `aria-controls` to associate the button with the report rows controlled
  by that control break.

If a controlled row does not already have an `id`, the plug-in assigns one so
it can be referenced by `aria-controls`. Existing row IDs are preserved.

Generated row IDs only need to identify elements in the currently rendered
report markup. Reusing the same generated IDs after Interactive Report
pagination is valid because the previous page rows have been replaced.

Use short, action-oriented values for **Collapse Title** and **Expand Title**,
for example `Collapse` and `Expand`.

## Remembered State

Remembered state is scoped to the application, page, and Interactive Report
region.

APEX-generated control-break header IDs are not used as persistent state keys
because those IDs can be reused when the report is paginated. Instead, the
plug-in uses a hashed logical key derived from the normalized rendered
control-break header text.

The stored data includes:

- A storage format version.
- The configured **Initially Expanded** value.
- The remembered expanded/collapsed state for each control-break group.

The configured **Initially Expanded** value is stored as metadata. If that
setting changes, old remembered group states are discarded automatically.

### Storage Modes

**Browser Session** uses APEX scoped `sessionStorage`.

**Future Sessions** uses APEX scoped `localStorage`.

The stored state is client-side UI state. Persistent storage is associated with
the current browser profile and is not an APEX user preference.

## Refresh Behavior

Interactive Report refreshes replace the generated report markup, so the toggle
buttons and ARIA relationships are recreated after each refresh.

The plug-in is safe to initialize repeatedly:

- Existing namespaced click handlers are removed before a new handler is
  attached.
- Toggle buttons are only added when they do not already exist.
- Remembered group states are restored after refresh.

Restoring state during initialization or after a report refresh does not raise
the `ircontrolbreakchange` event.

## Declarative Button Trigger Actions

The optional **IR Control Break Action** plug-in provides declarative APEX 26.1
Button Trigger Actions without page-level JavaScript.

The target Interactive Report must already be initialized by
**IR Control Break Toggler**.

Create a button and set `Behavior > Type` to **Trigger Action**. Select the
Triggered Action beneath the button and configure it as follows:

| Property | Value |
| --- | --- |
| Action | **IR Control Break Action [Plug-In]** |
| Selection Type | **Region** |
| Region | *Your Interactive Report* |
| Plug-in Action | **Expand All**, **Collapse All**, or **Reset State** |

The companion plug-in requires exactly one affected region.

### Button Action: Expand All

Expands all currently displayed control-break groups in the affected report.
If remembered state is enabled, the expanded states are saved.

### Button Action: Collapse All

Collapses all currently displayed control-break groups in the affected report.
If remembered state is enabled, the collapsed states are saved.

### Button Action: Reset State

Clears remembered state and restores the affected report to its configured
**Initially Expanded** state.

Reset State clears both session and persistent stored state for the report so
an old value cannot reappear if the **Remember State** mode is changed later.

The companion plug-in calls the same operations as the public JavaScript API,
so persistence and `ircontrolbreakchange` event behavior are the same.

## Public JavaScript API

The plug-in exposes a public API under:

```javascript
fi_jaris_plugin.ir.controlBreakToggler
```

`expandAll`, `collapseAll`, and `resetState` intentionally operate on exactly
one initialized Interactive Report region.

Pass a region Static ID, DOM element, or single-element jQuery object. A
selector that resolves to multiple regions is not accepted by these methods.

### Expand All

```javascript
fi_jaris_plugin.ir.controlBreakToggler.expandAll(
  "employees_ir"
);
```

Expands every control-break group in one report. If remembered state is
enabled, the expanded state is saved.

One aggregate `ircontrolbreakchange` event is raised if one or more groups
change state.

### Collapse All

```javascript
fi_jaris_plugin.ir.controlBreakToggler.collapseAll(
  "employees_ir"
);
```

Collapses every control-break group in one report. If remembered state is
enabled, the collapsed state is saved.

One aggregate `ircontrolbreakchange` event is raised if one or more groups
change state.

### Reset State

```javascript
fi_jaris_plugin.ir.controlBreakToggler.resetState(
  "employees_ir"
);
```

Clears remembered state and restores the configured **Initially Expanded**
state.

`resetState` clears both session and persistent stored state for the report so
an old value cannot reappear if the **Remember State** mode is changed later.

One aggregate `ircontrolbreakchange` event is raised if resetting changes one
or more currently displayed groups.

## Dynamic Action Event

The main plug-in exposes the following Dynamic Action event:

```text
Control Break Change [IR Control Break Toggler]
```

The underlying JavaScript event name is:

```text
ircontrolbreakchange
```

The event is raised on the Interactive Report region when the state of one or
more control-break groups changes.

A user toggling an individual control-break group raises one event for that
group.

The `expandAll`, `collapseAll`, and `resetState` operations raise one aggregate
event after all affected groups have been processed, provided at least one
group changed state. This includes operations invoked by the companion
**IR Control Break Action** plug-in.

State restoration during initialization or after an Interactive Report refresh
does not raise the event.

### Event Data

The event provides the following data:

| Property | Description |
| --- | --- |
| `regionId` | Static ID of the Interactive Report region |
| `headerIds` | Array containing the IDs of all currently rendered control-break headers changed by the operation |
| `expanded` | `true` when groups were expanded, `false` when groups were collapsed |
| `source` | Source of the state change |

The `headerIds` values refer to the current report DOM. They are useful for
identifying the affected rendered headers but are not used as persistent group
identifiers.

Possible `source` values are:

| Source | Meaning |
| --- | --- |
| `USER` | A user clicked an individual control-break toggle |
| `EXPAND_ALL` | Expand All changed one or more groups |
| `COLLAPSE_ALL` | Collapse All changed one or more groups |
| `RESET` | Reset State restored one or more groups to the configured initial state |

### Using the Event in a Dynamic Action

Create a Dynamic Action on the Interactive Report region and select the plug-in
event directly.

| Property | Value |
| --- | --- |
| Event | **Control Break Change [IR Control Break Toggler]** |
| Selection Type | **Region** |
| Region | *Your Interactive Report* |

## Debugging

The plug-in uses the Oracle APEX `apex.debug` JavaScript API for client-side
diagnostics.

When the corresponding APEX debug level is enabled, the browser developer
console can include information such as:

- The number of regions being initialized.
- The region ID after successful initialization.
- A message when the current report contains no control-break groups.
- Declarative Button Action execution details.
- Warnings for invalid configuration or an uninitialized target region.
- Errors when an action does not resolve to the required report region.
- The exact `ircontrolbreakchange` event name and event-data object before the
  event is triggered.

The event-data debug entry is useful when building Dynamic Actions that react to
**Control Break Change** because it shows the same object passed to the event
consumer.

## Button Position Styling

The plug-in keeps the Interactive Report `<th>` as a normal table cell and
creates an inner flex container for the control-break content and toggle button.

The generated layout classes are:

```text
ir-control-break-header
ir-control-break-header--start
ir-control-break-header--end
ir-control-break-text
ir-control-break-btn
```

For **Start**, the button is inserted before the header text. For **End**, the
button is inserted after the header text and pushed to the logical end of the
flex container.

This avoids changing the table-cell layout itself and works with both
left-to-right and right-to-left directions.

## Implementation Notes

The plug-in targets Interactive Report control-break headers using:

```text
th.a-IRR-header--group
```

The generated icon uses:

```text
ir-control-break-icon
```

The delegated click handler uses the namespace:

```text
click.controlBreakToggle
```

Remembered state uses APEX scoped browser storage:

- Session mode uses scoped `sessionStorage`.
- Persistent mode uses scoped `localStorage`.

Persistent state uses a logical group key rather than the pagination-local APEX
control-break header DOM ID.

The **IR Control Break Action** plug-in is a companion action layer. It operates
on the same initialized report instance and does not replace the main
**IR Control Break Toggler** initialization Dynamic Action.

Because the plug-in relies on generated Oracle APEX Interactive Report markup,
test it when upgrading to a newer APEX release.

## Development

Install development dependencies with:

```bash
npm install
```

Run the same checks used by the pre-commit hook and GitHub Actions with:

```bash
npm run check
```

The checks include ESLint, Stylelint, markdownlint, and a JavaScript syntax
check.

## License

This project is released under the [MIT License](LICENSE) by Jari Laine.
