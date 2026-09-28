var fi_jaris_plugin = fi_jaris_plugin || {};

(function($, plugin) {

  plugin.ir = plugin.ir || {};

  const instances = new WeakMap();

  const DEFAULT_PLUGIN_NAME =
    "IR Control Break Toggler";

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

  const BUTTON_EVENT_HANDLER =
    "click.controlBreakToggle";

  const CHANGE_EVENT =
    "ircontrolbreakchange";


  /*
  * Return the Dynamic Action plug-in name for debug messages.
  */
  function getPluginName(daConfig) {

    return (
      daConfig &&
      daConfig.action &&
      daConfig.action.action
    ) || DEFAULT_PLUGIN_NAME;

  }


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
  function resolveRegion(
    region,
    pluginName
  ) {

    const regions$ =
      resolveRegions(region);

    if (regions$.length > 1) {

      apex.debug.warn(
        pluginName || DEFAULT_PLUGIN_NAME,
        "Expected one region but multiple regions matched:",
        regions$.length
      );

    }

    return regions$.length === 1
      ? regions$
      : $();

  }


  /*
   * Return APEX scoped browser storage.
   */
  function getStateStorage(
    regionId,
    rememberState,
    pluginName
  ) {

    if (rememberState === "NO") {
      return null;
    }

    if (!regionId) {

      apex.debug.warn(
        pluginName,
        "Remember State is enabled, but the region has no ID."
      );

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

    apex.debug.warn(
      pluginName,
      "Unsupported Remember State value:",
      rememberState
    );

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
   * Return a compact deterministic hash for a string.
   */
  function hashString(value) {

    let hash =
      0x811c9dc5;

    for (
      let index = 0;
      index < value.length;
      index += 1
    ) {

      hash ^=
        value.charCodeAt(index);

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
   * APEX-generated control-break header IDs are pagination-local
   * and can be reused on another report page.
   *
   * Use normalized rendered control-break text as the logical group
   * identity and hash it before using it as a browser-storage key.
   */
  function getGroupKey(header$) {

    const clone$ =
      header$.clone();

    clone$
      .find(
        BUTTON_SELECTOR
      )
      .remove();

    const headerText =
      clone$
        .text()
        .replace(
          /\s+/g,
          " "
        )
        .trim();

    return headerText
      ? hashString(
          headerText
        )
      : "";

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
   * The <th> remains a table cell. Only the generated inner
   * container uses flexbox.
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
      )
        .first()
        .detach();

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
  *   One current control-break header ID.
  *
  * EXPAND_ALL / COLLAPSE_ALL / RESET:
  *   All changed current control-break header IDs in one event.
  */
  function triggerChangeEvent(
    instance,
    headerIds,
    isExpanded,
    source
  ) {

    const eventData = {
      regionId:
        instance.regionId,

      headerIds:
        headerIds,

      expanded:
        isExpanded,

      source:
        source
    };

    apex.debug.info(
      instance.pluginName,
      "Triggering event:",
      CHANGE_EVENT,
      "Event Data:",
      eventData
    );

    apex.event.trigger(
      instance.region$,
      CHANGE_EVENT,
      eventData
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
   * Bulk operations pass null for eventSource and emit one
   * aggregate event after all groups have been processed.
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

    const headerId =
      header$.attr(
        "id"
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

    const headers$ =
      getBreakHeaders(
        instance
      );

    if (!headers$.length) {

      apex.debug.info(
        instance.pluginName,
        "No control-break groups found in region:",
        instance.regionId
      );

      return;

    }

    headers$
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
        BUTTON_EVENT_HANDLER
      )
      .on(
        BUTTON_EVENT_HANDLER,
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
  function getInstance(
    region,
    pluginName
  ) {

    const debugName =
      pluginName ||
      DEFAULT_PLUGIN_NAME;

    const region$ =
      resolveRegion(
        region,
        debugName
      );

    if (!region$.length) {

      apex.debug.error(
        debugName,
        "Public API call requires exactly one region.",
        region
      );

      return null;

    }

    const instance =
      instances.get(
        region$[0]
      );

    if (!instance) {

      apex.debug.warn(
        debugName,
        "Region has not been initialized.",
        region$[0]
      );

      return null;

    }

    return instance;

  }

  /*
   * Initialize one Interactive Report region.
   *
   * Plug-in settings are already normalized and defaulted by
   * the APEX plug-in definition and render procedure.
   *
   * A per-region copy is used because an empty Expand Icon is
   * resolved from the current region's text direction.
   */
  function initInstance(
    region,
    options,
    pluginName
  ) {

    const region$ =
      $(region).first();

    if (!region$.length) {

      apex.debug.error(
        pluginName,
        "Unable to initialize region.",
        region
      );

      return false;

    }


    const instanceOptions =
      $.extend(
        {},
        options
      );


    /*
    * When Expand Icon is empty, automatically select
    * the directional icon based on:
    *
    * - Button Position
    * - LTR / RTL direction
    */
    if (!instanceOptions.expandIcon) {

      instanceOptions.expandIcon =
        getDefaultExpandIcon(
          region$,
          instanceOptions.buttonPosition
        );

    }


    const regionId =
      region$.attr("id");


    const instance = {

      region$:
        region$,

      regionId:
        regionId,

      pluginName:
        pluginName,

      options:
        instanceOptions,

      stateStorage:
        getStateStorage(
          regionId,
          instanceOptions.rememberState,
          pluginName
        ),

      storedState:
        null

    };


    loadState(
      instance
    );


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


    apex.debug.info(
      pluginName,
      "Initialized region:",
      regionId
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
    options,
    pluginName
  ) {

    const debugName =
      pluginName ||
      DEFAULT_PLUGIN_NAME;

    const regions$ =
      resolveRegions(
        region
      );

    if (!regions$.length) {

      apex.debug.error(
        debugName,
        "Initialization target did not resolve to any regions.",
        region
      );

      return false;

    }


    apex.debug.info(
      debugName,
      "Initializing regions:",
      regions$.length
    );


    let initialized =
      false;


    regions$
      .each(function() {

        if (
          initInstance(
            this,
            options,
            debugName
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
    source,
    pluginName
  ) {

    const instance =
      getInstance(
        region,
        pluginName
      );

    if (!instance) {
      return false;
    }


    const changedHeaderIds =
      [];

    let changedAny =
      false;


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

          changedAny =
            true;

          const headerId =
            header$.attr(
              "id"
            );

          if (headerId) {

            changedHeaderIds.push(
              headerId
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
    if (changedAny) {

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
   */
  function expandAll(
    region,
    pluginName
  ) {

    return setAllExpanded(
      region,
      true,
      "EXPAND_ALL",
      pluginName
    );

  }


  /*
   * Collapse every control-break group in one region.
   */
  function collapseAll(
    region,
    pluginName
  ) {

    return setAllExpanded(
      region,
      false,
      "COLLAPSE_ALL",
      pluginName
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
  function resetState(
    region,
    pluginName
  ) {

    const instance =
      getInstance(
        region,
        pluginName
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

    let changedAny =
      false;


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

          changedAny =
            true;

          const headerId =
            header$.attr(
              "id"
            );

          if (headerId) {

            changedHeaderIds.push(
              headerId
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
    if (changedAny) {

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

    const pluginName =
      getPluginName(
        daConfig
      );

    plugin.ir
      .controlBreakToggler
      .init(
        daConfig.triggeringElement,
        settings,
        pluginName
      );

  };


  /*
  * Dynamic Action entry point for declarative control-break actions.
  *
  * Intended for use with an Oracle APEX Button Trigger Action.
  *
  * The button is the triggering element, while the target Interactive
  * Report is supplied through the Dynamic Action Affected Elements.
  *
  * Supported actions:
  *
  *   EXPAND_ALL
  *   COLLAPSE_ALL
  *   RESET_STATE
  *
  * The affected region must already have been initialized by the
  * IR Control Break Toggler plug-in.
  */
  window.irControlBreakTogglerAction = (
    settings,
    daConfig
  ) => {

    const pluginName =
      getPluginName(
        daConfig
      );

    const api =
      plugin.ir
        .controlBreakToggler;

    const region$ =
      $(daConfig.affectedElements);


    if (!region$.length) {

      apex.debug.error(
        pluginName,
        "Button Action requires an affected Interactive Report region."
      );

      return false;

    }


    if (region$.length !== 1) {

      apex.debug.error(
        pluginName,
        "Button Action requires exactly one affected region. Matched:",
        region$.length
      );

      return false;

    }


    apex.debug.info(
      pluginName,
      "Executing Button Action:",
      settings.action,
      region$[0]
    );


    switch (settings.action) {

      case "EXPAND_ALL":

        return api.expandAll(
          region$,
          pluginName
        );


      case "COLLAPSE_ALL":

        return api.collapseAll(
          region$,
          pluginName
        );


      case "RESET_STATE":

        return api.resetState(
          region$,
          pluginName
        );


      default:

        apex.debug.warn(
          pluginName,
          "Unsupported Button Action:",
          settings.action
        );

        return false;

    }

  };

})(apex.jQuery, fi_jaris_plugin);
