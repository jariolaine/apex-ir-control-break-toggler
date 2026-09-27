var fi_jaris_plugin = fi_jaris_plugin || {};

(function($, plugin) {

  plugin.ir = plugin.ir || {};

  const instances = new WeakMap();

  const STORAGE_PREFIX =
    "fi_jaris_plugin.irControlBreakToggler";

  const STORAGE_KEY =
    "state";

  const STORAGE_VERSION =
    2;

  const CONTROL_BREAK_SELECTOR =
    "th.a-IRR-header--group";

  const BUTTON_SELECTOR =
    ".ir-control-break-btn";

  const ICON_SELECTOR =
    ".ir-control-break-icon";

  const HEADER_CONTENT_SELECTOR =
    ".ir-control-break-header";

  const CHANGE_EVENT =
    "ircontrolbreakchange";

  const DEFAULTS = {
    initiallyExpanded : true,
    rememberState     : "NO",
    buttonPosition    : "START",
    collapseTitle     : apex.lang.getMessage("APEX.GV.BREAK_COLLAPSE") || "Collapse",
    expandTitle       : apex.lang.getMessage("APEX.GV.BREAK_EXPAND") || "Expand",
    collapseIcon      : "fa-chevron-down",
    buttonCssClasses  : "t-Button t-Button--noLabel t-Button--icon t-Button--small"
  };


  /*
   * Return the default directional expand icon.
   *
   * START and END are logical positions, so the icon direction
   * follows the text direction of the region.
   */
  function getDefaultExpandIcon(
    region$,
    buttonPosition
  ) {

    const isRtl =
      region$.css("direction") === "rtl";

    if (buttonPosition === "END") {

      return isRtl
        ? "fa-chevron-right"
        : "fa-chevron-left";

    }

    return isRtl
      ? "fa-chevron-left"
      : "fa-chevron-right";

  }


  /*
   * Resolve one or more regions.
   *
   * Initialization can accept multiple elements so that a Dynamic
   * Action using a jQuery selector can initialize multiple IRs.
   */
  function resolveRegions(region) {

    if (typeof region === "string") {

      /*
       * First treat the string as a possible region Static ID.
       */
      const element =
        document.getElementById(region);

      if (element) {
        return $(element);
      }

      /*
       * Otherwise treat it as a jQuery selector.
       */
      return $(region);

    }

    return $(region);

  }


  /*
   * Resolve exactly one region.
   *
   * Public API methods intentionally operate on one IR at a time.
   * A selector matching multiple elements is rejected.
   */
  function resolveRegion(region) {

    const regions$ =
      resolveRegions(region);

    return regions$.length === 1
      ? regions$
      : $();

  }


  /*
   * Normalize Remember State.
   *
   * Supported values:
   *
   *   NO
   *   SESSION
   *   PERSISTENT
   */
  function normalizeRememberState(value) {

    /*
     * Keep support for an older Boolean configuration.
     */
    if (value === true) {
      return "SESSION";
    }

    if (
      value === false ||
      value == null
    ) {
      return "NO";
    }

    const normalizedValue =
      String(value).toUpperCase();

    return [
      "NO",
      "SESSION",
      "PERSISTENT"
    ].includes(normalizedValue)
      ? normalizedValue
      : "NO";

  }


  /*
   * Normalize Button Position.
   *
   * Supported values:
   *
   *   START
   *   END
   */
  function normalizeButtonPosition(value) {

    const position =
      String(
        value || "START"
      ).toUpperCase();

    return position === "END"
      ? "END"
      : "START";

  }


  /*
   * Merge supplied plug-in settings with defaults.
   */
  function normalizeOptions(options) {

    const normalized =
      $.extend(
        {},
        DEFAULTS,
        options
      );

    normalized.rememberState =
      normalizeRememberState(
        normalized.rememberState
      );

    normalized.buttonPosition =
      normalizeButtonPosition(
        normalized.buttonPosition
      );

    normalized.collapseTitle =
      normalized.collapseTitle ||
      DEFAULTS.collapseTitle;

    normalized.expandTitle =
      normalized.expandTitle ||
      DEFAULTS.expandTitle;

    normalized.collapseIcon =
      normalized.collapseIcon ||
      DEFAULTS.collapseIcon;

    /*
     * Keep expandIcon null when no explicit value is supplied.
     *
     * initInstance() will derive the correct directional icon
     * from Button Position and the region text direction.
     */
    normalized.expandIcon =
      normalized.expandIcon ||
      null;

    normalized.buttonCssClasses =
      normalized.buttonCssClasses ||
      DEFAULTS.buttonCssClasses;

    return normalized;

  }


  /*
   * Used to return hashed group key.
   */
  function hashString(value) {

    let hash =
      0x811c9dc5;

    for (
      let i = 0;
      i < value.length;
      i += 1
    ) {

      hash ^=
        value.charCodeAt(i);

      hash =
        Math.imul(
          hash,
          0x01000193
        );

    }

    return (
      hash >>> 0
    ).toString(16);

  }

  /*
   * Return APEX scoped browser storage.
   */
  function getStateStorage(
    regionId,
    rememberState
  ) {

    if (
      !regionId ||
      rememberState === "NO"
    ) {
      return null;
    }

    const storageOptions = {
      prefix    : STORAGE_PREFIX,
      useAppId  : true,
      usePageId : true,
      regionId  : regionId
    };

    if (rememberState === "SESSION") {

      return apex.storage
        .getScopedSessionStorage(
          storageOptions
        );

    }

    if (rememberState === "PERSISTENT") {

      return apex.storage
        .getScopedLocalStorage(
          storageOptions
        );

    }

    return null;

  }


  /*
   * Create an empty stored-state object.
   *
   * initiallyExpanded is stored as metadata so changing that
   * plug-in setting invalidates previously remembered group states.
   */
  function createStoredState(instance) {

    return {
      version:
        STORAGE_VERSION,

      initiallyExpanded:
        instance.options.initiallyExpanded,

      states:
        {}
    };

  }


  /*
   * Validate remembered state loaded from browser storage.
   */
  function isValidStoredState(
    instance,
    state
  ) {

    return Boolean(
      state &&
      state.version === STORAGE_VERSION &&
      state.initiallyExpanded ===
        instance.options.initiallyExpanded &&
      state.states &&
      typeof state.states === "object" &&
      !Array.isArray(state.states)
    );

  }


  /*
   * Save remembered state.
   */
  function saveState(instance) {

    if (!instance.stateStorage) {
      return;
    }

    instance.stateStorage.setItem(
      STORAGE_KEY,
      JSON.stringify(
        instance.storedState
      )
    );

  }


  /*
   * Load remembered state.
   */
  function loadState(instance) {

    instance.storedState =
      createStoredState(instance);

    if (!instance.stateStorage) {
      return;
    }

    const storedValue =
      instance.stateStorage.getItem(
        STORAGE_KEY
      );

    if (!storedValue) {

      saveState(instance);

      return;

    }

    try {

      const parsedState =
        JSON.parse(storedValue);

      if (
        isValidStoredState(
          instance,
          parsedState
        )
      ) {

        instance.storedState =
          parsedState;

        return;

      }

    } catch {

      /*
       * Ignore invalid or obsolete stored data.
       */

    }

    /*
     * Storage format changed, stored data is invalid,
     * or Initially Expanded has changed.
     */
    instance.storedState =
      createStoredState(instance);

    saveState(instance);

  }


  /*
   * Remove remembered state from both browser storage types.
   *
   * Clearing both prevents an old state from unexpectedly
   * reappearing if Remember State mode is changed later.
   */
  function clearStoredState(regionId) {

    if (!regionId) {
      return;
    }

    const storageOptions = {
      prefix    : STORAGE_PREFIX,
      useAppId  : true,
      usePageId : true,
      regionId  : regionId
    };

    apex.storage
      .getScopedSessionStorage(
        storageOptions
      )
      .removeItem(
        STORAGE_KEY
      );

    apex.storage
      .getScopedLocalStorage(
        storageOptions
      )
      .removeItem(
        STORAGE_KEY
      );

  }


  /*
   * Return the rows controlled by one control-break header.
   */
  function getGroupRows(header$) {

    return header$
      .closest("tr")
      .nextUntil(
        `tr:has(${CONTROL_BREAK_SELECTOR})`
      );

  }


  /*
   * APEX-generated control-break header IDs are pagination-local
   * and can be reused on another report page. Use normalized
   * rendered control-break text as the logical group identity.
   */
  function getGroupKey(header$) {

    const clone$ =
      header$.clone();

    clone$
      .find(
        BUTTON_SELECTOR
      )
      .remove();

    const value =
      clone$
      .text()
      .replace(
        /\s+/g,
        " "
      )
      .trim();

    return hashString(
      value
    );

  }


  /*
   * Convert a value into a safe fragment for generated IDs.
   */
  function safeIdPart(value) {

    return String(value)
      .replace(
        /[^A-Za-z0-9_-]/g,
        "_"
      );

  }


  /*
   * Ensure every controlled row has an ID.
   *
   * IDs only need to be unique in the currently rendered document.
   * Reusing the same generated IDs after Interactive Report
   * pagination is valid because the previous report rows have been
   * replaced.
   */
  function ensureControlledRowIds(
    instance,
    header$,
    groupIndex
  ) {

    const rows$ =
      getGroupRows(header$);

    const ids =
      [];

    const headerId =
      header$.attr("id");

    const regionPart =
      safeIdPart(
        instance.regionId ||
        "ir"
      );

    const groupPart =
      safeIdPart(
        headerId ||
        `group_${groupIndex + 1}`
      );

    rows$.each(function(rowIndex) {

      const row$ =
        $(this);

      let rowId =
        row$.attr("id");

      if (!rowId) {

        const baseId =
          `${regionPart}_cb_${groupPart}_row_${rowIndex + 1}`;

        rowId =
          baseId;

        let counter =
          2;

        /*
         * Protect against a duplicate ID that exists
         * in the current document.
         */
        while (
          document.getElementById(rowId) &&
          document.getElementById(rowId) !== this
        ) {

          rowId =
            `${baseId}_${counter}`;

          counter += 1;

        }

        row$.attr(
          "id",
          rowId
        );

      }

      ids.push(
        rowId
      );

    });

    return ids;

  }


  /*
   * Ensure the control-break header has an inner layout container.
   *
   * The <th> remains a table cell. Only the generated inner container
   * uses flexbox, avoiding the vertical-alignment issues caused by
   * floating the button directly inside the table cell.
   */
  function ensureHeaderContent(header$) {

    let content$ =
      header$.children(
        HEADER_CONTENT_SELECTOR
      ).first();

    if (content$.length) {
      return content$;
    }

    /*
     * Preserve a button from an earlier initialization, if present,
     * while wrapping the original APEX control-break content.
     */
    const existingButton$ =
      header$.children(
        BUTTON_SELECTOR
      ).first().detach();

    const text$ =
      $("<span>", {
        class : "ir-control-break-text"
      });

    text$.append(
      header$.contents()
    );

    content$ =
      $("<span>", {
        class : "ir-control-break-header"
      });

    content$.append(
      text$
    );

    if (existingButton$.length) {

      content$.append(
        existingButton$
      );

    }

    header$.append(
      content$
    );

    return content$;

  }


  /*
   * Create or return the toggle button for one control break.
   */
  function ensureButton(
    instance,
    header$,
    groupIndex
  ) {

    const content$ =
      ensureHeaderContent(
        header$
      );

    let button$ =
      content$.children(
        BUTTON_SELECTOR
      ).first();

    /*
     * Create the button when it doesn't already exist.
     */
    if (!button$.length) {

      button$ =
        $("<button>", {
          type : "button"
        });

    }


    /*
     * Ensure the icon exists.
     */
    let icon$ =
      button$.children(
        ICON_SELECTOR
      );

    if (!icon$.length) {

      icon$ =
        $("<span>", {
          "aria-hidden" : "true",
          class         : "t-Icon fa ir-control-break-icon"
        });

      button$.append(
        icon$
      );

    }


    /*
     * Refresh button classes in case application-scope
     * plug-in configuration changed.
     */
    button$.attr(
      "class",
      `${instance.options.buttonCssClasses} ir-control-break-btn`
        .trim()
    );


    /*
     * Position is applied to the inner flex container rather than
     * floating the button inside the table cell.
     */
    content$
      .toggleClass(
        "ir-control-break-header--start",
        instance.options.buttonPosition ===
          "START"
      )
      .toggleClass(
        "ir-control-break-header--end",
        instance.options.buttonPosition ===
          "END"
      );


    /*
     * Keep DOM order aligned with the configured logical position.
     */
    if (
      instance.options.buttonPosition ===
      "END"
    ) {

      content$.append(
        button$
      );

    } else {

      content$.prepend(
        button$
      );

    }


    /*
     * Establish the ARIA relationship between the button
     * and the rows controlled by this group.
     */
    const controlledIds =
      ensureControlledRowIds(
        instance,
        header$,
        groupIndex
      );

    if (controlledIds.length) {

      button$.attr(
        "aria-controls",
        controlledIds.join(" ")
      );

    } else {

      button$.removeAttr(
        "aria-controls"
      );

    }

    return button$;

  }


  /*
   * Update title, accessible label, expanded state, and icon.
   */
  function setButtonState(
    instance,
    button$,
    isExpanded
  ) {

    const title =
      isExpanded
        ? instance.options.collapseTitle
        : instance.options.expandTitle;

    const icon =
      isExpanded
        ? instance.options.collapseIcon
        : instance.options.expandIcon;


    button$
      .attr({
        title:
          title,

        "aria-label":
          title,

        "aria-expanded":
          isExpanded.toString()
      });


    button$
      .children(
        ICON_SELECTOR
      )
      .removeClass(
        `${instance.options.collapseIcon} ${instance.options.expandIcon}`
      )
      .addClass(
        icon
      );

  }


  /*
   * Trigger one region-level change event.
   *
   * USER:
   *   One group key.
   *
   * EXPAND_ALL / COLLAPSE_ALL / RESET:
   *   All changed group keys in one event.
   */
  function triggerChangeEvent(
    instance,
    headerIds,
    isExpanded,
    source
  ) {

    apex.event.trigger(
      instance.region$,
      CHANGE_EVENT,
      {
        regionId:
          instance.regionId,

        headerIds:
          headerIds,

        expanded:
          isExpanded,

        source:
          source
      }
    );

  }


  /*
   * Set one control-break group to the requested state.
   *
   * persistState updates the in-memory remembered state.
   *
   * Storage is written by the caller so that bulk operations
   * only need to write once.
   *
   * eventSource:
   *
   *   USER
   *   null
   *
   * Bulk operations pass null here and emit one aggregate
   * event after all groups have been processed.
   */
  function setGroupExpanded(
    instance,
    header$,
    isExpanded,
    persistState,
    eventSource
  ) {

    const button$ =
      header$.find(
        BUTTON_SELECTOR
      ).first();

    const previousExpanded =
      button$.attr(
        "aria-expanded"
      ) === "true";

    const groupKey =
      getGroupKey(
        header$
      );

    setButtonState(
      instance,
      button$,
      isExpanded
    );

    getGroupRows(header$)
      .toggle(
        isExpanded
      );


    /*
     * Update remembered state.
     */
    if (
      persistState &&
      instance.stateStorage &&
      groupKey
    ) {

      instance.storedState
        .states[groupKey] =
          isExpanded;

    }

    const changed =
      previousExpanded !==
      isExpanded;

    if (
      changed &&
      eventSource
    ) {

      const headerId =
        header$.attr(
          "id"
        );

      triggerChangeEvent(
        instance,
        headerId
          ? [headerId]
          : [],
        isExpanded,
        eventSource
      );

    }

    return changed;

  }


  /*
   * Return all current control-break headers for one region.
   */
  function getBreakHeaders(instance) {

    return instance.region$
      .find(
        CONTROL_BREAK_SELECTOR
      );

  }


  /*
   * Initialize all current control-break groups.
   */
  function initializeGroups(instance) {

    getBreakHeaders(instance)
      .each(function(groupIndex) {

        const header$ =
          $(this);

        const groupKey =
          getGroupKey(
            header$
          );

        let isExpanded =
          instance.options
            .initiallyExpanded;


        /*
         * Remembered state takes precedence.
         */
        if (
          instance.stateStorage &&
          groupKey &&
          Object.prototype
            .hasOwnProperty.call(
              instance.storedState.states,
              groupKey
            )
        ) {

          isExpanded =
            instance.storedState
              .states[groupKey];

        }

        ensureButton(
          instance,
          header$,
          groupIndex
        );


        /*
         * Initialization/restoration does not:
         *
         * - create remembered state entries
         * - fire change events
         */
        setGroupExpanded(
          instance,
          header$,
          isExpanded,
          false,
          null
        );

      });

  }


  /*
   * Attach the delegated click handler.
   */
  function attachClickHandler(instance) {

    instance.region$
      .off(
        "click.controlBreakToggle"
      )
      .on(
        "click.controlBreakToggle",
        BUTTON_SELECTOR,
        function() {

          const button$ =
            $(this);

          const header$ =
            button$.closest(
              CONTROL_BREAK_SELECTOR
            );

          const isExpanded =
            button$.attr(
              "aria-expanded"
            ) === "true";

          /*
           * User interaction changes one group and therefore
           * emits one USER change event.
           */
          setGroupExpanded(
            instance,
            header$,
            !isExpanded,
            true,
            "USER"
          );

          saveState(
            instance
          );

        }
      );

  }


  /*
   * Return the initialized instance for exactly one region.
   *
   * Public API methods use this helper.
   */
  function getInstance(region) {

    const region$ =
      resolveRegion(
        region
      );

    if (!region$.length) {
      return null;
    }

    return instances.get(
      region$[0]
    ) || null;

  }


  /*
   * Initialize one Interactive Report region.
   */
  function initInstance(
    region,
    options
  ) {

    const region$ =
      $(region).first();

    if (!region$.length) {
      return false;
    }


    const normalizedOptions =
      normalizeOptions(
        options
      );


    /*
     * When Expand Icon is empty, automatically select
     * the directional icon based on:
     *
     * - Button Position
     * - LTR / RTL direction
     */
    if (!normalizedOptions.expandIcon) {

      normalizedOptions.expandIcon =
        getDefaultExpandIcon(
          region$,
          normalizedOptions.buttonPosition
        );

    }


    const regionId =
      region$.attr("id");


    const instance = {

      region$:
        region$,

      regionId:
        regionId,

      options:
        normalizedOptions,

      stateStorage:
        getStateStorage(
          regionId,
          normalizedOptions.rememberState
        ),

      storedState:
        null

    };


    loadState(
      instance
    );


    /*
     * Store this region as an independent plug-in instance.
     */
    instances.set(
      region$[0],
      instance
    );


    attachClickHandler(
      instance
    );


    initializeGroups(
      instance
    );


    return true;

  }


  /*
   * Initialize one or more matching Interactive Report regions.
   *
   * This allows a Dynamic Action using a jQuery selector to target
   * multiple IRs.
   *
   * Each matched region is still an independent plug-in instance.
   */
  function init(
    region,
    options
  ) {

    const regions$ =
      resolveRegions(
        region
      );

    if (!regions$.length) {
      return false;
    }


    let initialized =
      false;


    regions$
      .each(function() {

        if (
          initInstance(
            this,
            options
          )
        ) {

          initialized =
            true;

        }

      });


    return initialized;

  }


  /*
   * Apply one state to all control-break groups in exactly
   * one initialized region.
   *
   * Only one ircontrolbreakchange event is emitted after the
   * operation, regardless of how many groups changed.
   */
  function setAllExpanded(
    region,
    isExpanded,
    source
  ) {

    const instance =
      getInstance(
        region
      );

    if (!instance) {
      return false;
    }

    const changedHeaderIds =
      [];

    const changedGroupKeys =
      [];


    getBreakHeaders(
      instance
    )
      .each(function(groupIndex) {

        const header$ =
          $(this);


        /*
         * Normally already present, but ensure the button exists
         * in case the API is called after DOM changes.
         */
        ensureButton(
          instance,
          header$,
          groupIndex
        );


        const changed =
          setGroupExpanded(
            instance,
            header$,
            isExpanded,
            true,
            null
          );

        if (changed) {

          const headerId =
            header$.attr(
              "id"
            );
          if (headerId) {

            changedHeaderIds.push(
              headerId
            );

          }


          const groupKey =
            getGroupKey(
              header$
            );

          if (groupKey) {

            changedGroupKeys.push(
              groupKey
            );

          }

        }

      });


    /*
     * Persist all changed states with one storage write.
     */
    saveState(
      instance
    );


    /*
     * Emit one aggregate change event.
     */
    if (changedGroupKeys.length) {

      triggerChangeEvent(
        instance,
        changedHeaderIds,
        isExpanded,
        source
      );

    }


    return true;

  }


  /*
   * Expand every control-break group in one region.
   *
   * region must resolve to exactly one initialized region.
   */
  function expandAll(region) {

    return setAllExpanded(
      region,
      true,
      "EXPAND_ALL"
    );

  }


  /*
   * Collapse every control-break group in one region.
   *
   * region must resolve to exactly one initialized region.
   */
  function collapseAll(region) {

    return setAllExpanded(
      region,
      false,
      "COLLAPSE_ALL"
    );

  }


  /*
   * Clear remembered state for one region and restore
   * the configured Initially Expanded value.
   *
   * Both session and persistent browser state are cleared.
   *
   * One RESET event is emitted if one or more current groups
   * actually change state.
   */
  function resetState(region) {

    const instance =
      getInstance(
        region
      );

    if (!instance) {
      return false;
    }


    clearStoredState(
      instance.regionId
    );


    instance.storedState =
      createStoredState(
        instance
      );


    const changedHeaderIds =
      [];

    const changedGroupKeys =
      [];


    getBreakHeaders(
      instance
    )
      .each(function(groupIndex) {

        const header$ =
          $(this);

        ensureButton(
          instance,
          header$,
          groupIndex
        );


        const changed =
          setGroupExpanded(
            instance,
            header$,
            instance.options.initiallyExpanded,
            false,
            null
          );


        if (changed) {

          const headerId =
            header$.attr(
              "id"
            );

          if (headerId) {

            changedHeaderIds.push(
              headerId
            );

          }


          const groupKey =
            getGroupKey(
              header$
            );

          if (groupKey) {

            changedGroupKeys.push(
              groupKey
            );

          }

        }

      });


    /*
     * If remembering is enabled, recreate storage with:
     *
     * - current storage version
     * - current Initially Expanded setting
     * - no per-group overrides
     */
    saveState(
      instance
    );


    /*
     * Emit one aggregate RESET event.
     */
    if (changedGroupKeys.length) {

      triggerChangeEvent(
        instance,
        changedHeaderIds,
        instance.options.initiallyExpanded,
        "RESET"
      );

    }


    return true;

  }


  /*
   * Public API.
   *
   * init():
   *   May initialize one or more matched regions.
   *
   * expandAll():
   * collapseAll():
   * resetState():
   *   Intentionally operate on exactly one region.
   */
  plugin.ir.controlBreakToggler = {

    init:
      init,

    expandAll:
      expandAll,

    collapseAll:
      collapseAll,

    resetState:
      resetState

  };


})(apex.jQuery, fi_jaris_plugin);


/*
 * The Dynamic Action should normally be created with:
 *
 *   Event: After Refresh
 *
 * A Region selection normally supplies one triggering IR.
 *
 * A jQuery Selector can supply one or more matching IRs;
 * init() treats each as an independent plug-in instance.
 *
 * No Affected Elements configuration is required because
 * the plug-in uses daConfig.triggeringElement.
 */
window.irControlBreakTogglerInit = (
  settings,
  daConfig
) => {

  fi_jaris_plugin.ir
    .controlBreakToggler
    .init(
      daConfig.triggeringElement,
      settings
    );

};
