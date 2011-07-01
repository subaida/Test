// Copyright 2007 Google Inc. All Rights Reserved.

var VisualizationModule = {
  changeDateRange: function(dateRange) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._DATE_RANGE, dateRange);
    manager._set(goog.analytics.Properties._COMPARISON_TYPE, "site");

    manager._set(
        goog.analytics.Properties._EVENT_ID, "DateSliderChanged");
    if (typeof(table) == "object") {
      manager._set(goog.analytics.Properties._TABLE_START_ROW, "0");
      if (table._getData().State.ChartColumn) {
        manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN,
            table._getData().State.ChartColumn);
      }
    }

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeDateRangeAndComparisonDateRange: function(dateRange, comparisonDateRange) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._COMPARISON_TYPE, "date_range");
    manager._set(goog.analytics.Properties._DATE_RANGE, dateRange);
    manager._set(goog.analytics.Properties._COMPARE_DATE_RANGE, comparisonDateRange);

    manager._set(goog.analytics.Properties._EVENT_ID, "DateSliderChanged");

    if (typeof(table) == "object") {
      manager._set(goog.analytics.Properties._TABLE_START_ROW, 0);
      if (table._getData().State.ChartColumn) {
        manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
      }
    }
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeDateRangeAndComparisonType: function(dateRange, comparisonType) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._COMPARISON_TYPE, comparisonType);
    manager._set(goog.analytics.Properties._DATE_RANGE, dateRange);

    manager._set(goog.analytics.Properties._EVENT_ID, "DateSliderChanged");

    if (typeof(table) == "object") {
      if (table._getData().State.ChartColumn) {
        manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
      }
    }
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeComparisonType: function(comparisonType) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._COMPARISON_TYPE, comparisonType);

    manager._set(goog.analytics.Properties._EVENT_ID, "DateSliderChanged");

    if (typeof(table) == "object") {
      if (table._getData().State.ChartColumn) {
        manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
      }
    }
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeSortBy: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "TableChanged");
    if (table._getData().State.ChartColumn) {
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
    }
    manager._set(goog.analytics.Properties._TABLE_SORT_COLUMN, table._getData().State.SortColumn)
    manager._set(goog.analytics.Properties._TABLE_START_ROW, 0);

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeChartColumn: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "TableChanged");
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeView: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    var newViewId = table._getData().State.View;
    manager._set(goog.analytics.Properties._EVENT_ID, "ViewChanged");
    manager._set(goog.analytics.Properties._TABLE_VIEW, newViewId);
    if (table._getData().State.View == 0) {
      manager._set(goog.analytics.Properties._TABLE_SORT_COLUMN, "");
    }

    _createEvent("Table View", ""+newViewId,
        manager._get(goog.analytics.Properties._REPORT_NAME));

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeTab: function(tab) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "TabChanged");
    manager._set(goog.analytics.Properties._TABLE_TAB, tab);
    manager._set(goog.analytics.Properties._TABLE_START_ROW, 0);
    if (tab == 0) {
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, 0);
    } else {
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, 1);
    }
    manager._set(goog.analytics.Properties._TABLE_SORT_COLUMN, "");

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeSortOrder: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "TableChanged");
    if (table._getData().State.ChartColumn) {
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
    }
    manager._set(goog.analytics.Properties._TABLE_SORT_ORDER, table._getData().State.SortOrder);
    manager._set(goog.analytics.Properties._TABLE_START_ROW, 0);
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changePage: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "TableChanged");
    if (table._getData().State.ChartColumn) {
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
    }
    manager._set(goog.analytics.Properties._TABLE_START_ROW, table._getData().RowStart);
    manager._set(goog.analytics.Properties._TABLE_ROW_COUNT, table._getData().RowShow);
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeSearch: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "Filter");
    if (table._getData().State.ChartColumn) {
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
    }
    manager._set(goog.analytics.Properties._FILTER, table._getData().FilterString);
    manager._set(goog.analytics.Properties._FILTER_TYPE, table._getData().FilterType);
    manager._set(goog.analytics.Properties._TABLE_START_ROW, 0);
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeMinitableSegment: function(segmentBy) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "MinitableChanged");
    manager._set(goog.analytics.Properties._SEGMENT_BY, segmentBy);

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeSegmentBy: function(segmentBy) {
    var manager = goog.analytics.PropertyManager._getInstance();
    _createEvent("Segmentation Menu", segmentBy, manager._get(goog.analytics.Properties._REPORT_NAME));
    if (typeof(table) == "object") {
      manager._set(goog.analytics.Properties._EVENT_ID, "NarrativeChanged");
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
      manager._set(goog.analytics.Properties._FILTER, "");
      manager._set(goog.analytics.Properties._TABLE_START_ROW, 0);
      manager._set(goog.analytics.Properties._SEGMENT_BY, segmentBy);
      manager._set(goog.analytics.Properties._SEGMENT, 1);

      goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
    } else {
      var path = window.location.pathname;

      var newPropertyManager = goog.analytics.PropertyManager._getNewInstance();
      newPropertyManager._addProperties(manager._getQueryString());

      newPropertyManager._set(goog.analytics.Properties._EVENT_ID, "");
      newPropertyManager._set(goog.analytics.Properties._SEGMENT, "1");
      newPropertyManager._set(goog.analytics.Properties._SEGMENT_BY, segmentBy);

      newPropertyManager._set(goog.analytics.Properties._EVENT_ID, "");

      window.location.href = path + "?" + newPropertyManager._getQueryString();
    }
  },

  changeSegmentation: function(showSegment) {
    var path = window.location.pathname;
    var manager = goog.analytics.PropertyManager._getInstance();
    var newPropertyManager = goog.analytics.PropertyManager._getNewInstance();
    newPropertyManager._addProperties(propertyManager._getQueryString());
    newPropertyManager._set(goog.analytics.Properties._SEGMENT, (showSegment ? "1" : "0"));
    newPropertyManager._set(goog.analytics.Properties._EVENT_ID, "");

    window.location.href = path + "?" + newPropertyManager._getQueryString();
  },

  changeSliceBy: function(slice) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "NarrativeChanged");
    if (typeof(table) == "object") {
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
      manager._set(goog.analytics.Properties._FILTER, "");
      manager._set(goog.analytics.Properties._TABLE_START_ROW, "0");
    }
    manager._set(goog.analytics.Properties._SLICE_BY, slice);
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeDetailKeyword: function(drilldown) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "Filter");
    if (table._getData().State.ChartColumn) {
      manager._set(goog.analytics.Properties._TABLE_CHART_COLUMN, table._getData().State.ChartColumn);
    }
    if (drilldown && drilldown != "") {
      manager._set(goog.analytics.Properties._DRILLDOWN, drilldown);
    }
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeDrilldown: function(newDrilldown) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "DrilldownChanged");
    manager._set(goog.analytics.Properties._DRILLDOWN, newDrilldown);
    manager._set(goog.analytics.Properties._DRILLDOWN2, "");
    manager._set(goog.analytics.Properties._DRILLDOWN3, "");
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  updateGraph: function(mode, primaryValue, opt_secondaryValue) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "GraphChanged");

    if (mode == "primary") {
      manager._set(goog.analytics.Properties._GRAPH_VALUE, primaryValue);
      manager._set(goog.analytics.Properties._GRAPH_LINE_COUNT, 1);
    } else if (mode == "metric_comparison") {
      manager._set(
          goog.analytics.Properties._SECONDARY_GRAPH_TYPE, "current_data");
      manager._set(goog.analytics.Properties._GRAPH_VALUE, primaryValue);
      manager._set(
          goog.analytics.Properties._SECONDARY_GRAPH_VALUE, opt_secondaryValue);
      manager._set(goog.analytics.Properties._GRAPH_LINE_COUNT, 2);
    } else {
      manager._set(
          goog.analytics.Properties._SECONDARY_GRAPH_TYPE, "other_data");
      manager._set(goog.analytics.Properties._GRAPH_VALUE, primaryValue);
      manager._set(
          goog.analytics.Properties._SECONDARY_GRAPH_VALUE, primaryValue);
      manager._set(goog.analytics.Properties._GRAPH_LINE_COUNT, 2);
    }

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  updateGraphDateFormat : function(graphDateFormat) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "GraphDateFormatChanged");
    manager._set(goog.analytics.Properties._GRAPH_DATE_FORMAT, graphDateFormat);
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  turnOffSecondaryLine: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "GraphChanged");

    manager._set(goog.analytics.Properties._GRAPH_LINE_COUNT, 1);
    document.getElementById("toggle_button").className = "toggle_button off";

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeBenchmarkId: function(benchmarkId) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "BenchmarkChanged");
    manager._set(goog.analytics.Properties._BENCHMARK_ID, benchmarkId);
    manager._set(goog.analytics.Properties._COMPARISON_TYPE, "benchmark");
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeMapIndex: function(index) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "MapChanged");
    manager._set(goog.analytics.Properties._GEOMAP_VALUE_INDEX, index);
    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeGoal: function(goalNumber) {
    var params = goog.analytics.Properties._GOAL + "=" + goalNumber;
    VisualizationModule.changeReport(location.pathname, params);
  },


  changeReport: function(report, params) {
    var propertyManager = goog.analytics.PropertyManager._getInstance();
    propertyManager._set(goog.analytics.Properties._EVENT_ID, "");
    if (params && params != "") {
      window.location.href =  report + "?" + propertyManager._getPersistentQueryString() + "&" + params;
    } else {
      window.location.href =  report + "?" + propertyManager._getPersistentQueryString();
    }
    return false;
  },

  changeReportAndComparison: function(report, comparison) {
    var propertyManager = goog.analytics.PropertyManager._getInstance();
    propertyManager._set(goog.analytics.Properties._COMPARISON_TYPE, comparison);
    return this.changeReport(report);
  },

  launchOverlay: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    var newManager = manager._cloneAll();
    var url =  "overlay_launch?" + newManager._getQueryString();
    var mywin = window.open(url, "GA_SiteOverlay",'scrollbars=yes,menubar=yes,toolbar=yes,location=yes,width=800,height=600,resizable=yes');
    mywin.focus();
    return false;
  },

  launchDefaultOverlay: function() {
    var manager = goog.analytics.PropertyManager._getInstance();
    var newManager = manager._cloneAll();
    newManager._set(goog.analytics.Properties._DRILLDOWN, "");
    newManager._set(goog.analytics.Properties._DRILLDOWN2, "");
    newManager._set(goog.analytics.Properties._DRILLDOWN3, "");
    var url =  "overlay_launch?" + newManager._getQueryString();
    var mywin = window.open(url, "GA_SiteOverlay",'scrollbars=yes,menubar=yes,toolbar=yes,location=yes,width=800,height=600,resizable=yes');
    mywin.focus();
    return false;
  },

  changeSelectorFilter: function(filterString) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "SelectorFilterChanged");
    manager._set(goog.analytics.Properties._SELECTOR_FILTER, filterString);
    goog.analytics.Ajax.sendCustomLoading(location.pathname+"?"+manager._getQueryString(), "ContentControl_menu_loading");
  },

  changeSegmentView: function(viewId) {
    var path = window.location.pathname;

    var manager = goog.analytics.PropertyManager._getInstance();
    var clonedManager = goog.analytics.PropertyManager._getInstance()._cloneAll();
    clonedManager._set(goog.analytics.Properties._EVENT_ID, "");
    clonedManager._set(goog.analytics.Properties._TABLE_VIEW, viewId);
    clonedManager._set(goog.analytics.Properties._SEGMENT, "1");

    window.location.href = path + "?" + clonedManager._getQueryString();
  },

  changeAnalyzeContent: function(analyzeUrl, opt_qParam) {
    var manager = goog.analytics.PropertyManager._getInstance();
    var clonedManager = manager._clonePersistent();

    clonedManager._set(goog.analytics.Properties._DRILLDOWN,
        manager._get(goog.analytics.Properties._DRILLDOWN));

    // Including optional query parameter if it's being passed in by the caller
    window.location.href = analyzeUrl + "?" + clonedManager._getQueryString() +
                           (opt_qParam ? opt_qParam : "");
  },

  changeAnalyzeSiteSearchCategory: function(analyzeUrl) {
    var manager = goog.analytics.PropertyManager._getInstance();
    var clonedManager = manager._clonePersistent();

    clonedManager._set(goog.analytics.Properties._DRILLDOWN,
        manager._get(goog.analytics.Properties._DRILLDOWN));
    clonedManager._set(goog.analytics.Properties._DRILLDOWN2,
        manager._get(goog.analytics.Properties._DRILLDOWN2));

    if (analyzeUrl.indexOf("content") > -1 ||
        analyzeUrl.indexOf("refinement") > -1) {
      clonedManager._set(goog.analytics.Properties._TABLE_VIEW, 1);
    }

    window.location.href = analyzeUrl + "?" + clonedManager._getQueryString();
  },

  changeAnalyzeSiteSearchContent: function(analyzeUrl) {
    var manager = goog.analytics.PropertyManager._getInstance();
    var clonedManager = manager._clonePersistent();

    clonedManager._set(goog.analytics.Properties._DRILLDOWN,
        manager._get(goog.analytics.Properties._DRILLDOWN));
    clonedManager._set(goog.analytics.Properties._DRILLDOWN2,
        manager._get(goog.analytics.Properties._DRILLDOWN2));

    if (analyzeUrl.indexOf("keyword_content") > -1) {
      clonedManager._set(goog.analytics.Properties._TABLE_VIEW, 1);
    }

    window.location.href = analyzeUrl + "?" + clonedManager._getQueryString();
  },

  changeAnalyzeSiteSearchResult: function(analyzeUrl) {
    var manager = goog.analytics.PropertyManager._getInstance();
    var clonedManager = manager._clonePersistent();

    clonedManager._set(goog.analytics.Properties._DRILLDOWN,
        manager._get(goog.analytics.Properties._DRILLDOWN));
    clonedManager._set(goog.analytics.Properties._DRILLDOWN2,
        manager._get(goog.analytics.Properties._DRILLDOWN2));

    if (analyzeUrl.indexOf("keyword_content") > -1) {
      clonedManager._set(goog.analytics.Properties._TABLE_VIEW, 1);
    }

    window.location.href = analyzeUrl + "?" + clonedManager._getQueryString();
  },

  changeAnalyzeSiteSearchKeyword: function(analyzeUrl) {
    var manager = goog.analytics.PropertyManager._getInstance();
    var clonedManager = manager._clonePersistent();

    clonedManager._set(goog.analytics.Properties._DRILLDOWN,
        manager._get(goog.analytics.Properties._DRILLDOWN));
    if (analyzeUrl.indexOf("refinement") > -1) {
      clonedManager._set(goog.analytics.Properties._TABLE_VIEW, 1);
    }

    window.location.href = analyzeUrl + "?" + clonedManager._getQueryString();
  },

  redirectReport: function(report, params) {
    var clonedManager = goog.analytics.PropertyManager._getInstance()._cloneAll();

    if (params && params != "") {
      clonedManager._addProperties(params);
    }
    clonedManager._set(goog.analytics.Properties._EVENT_ID, "");

    window.location.href = report + "?" + clonedManager._getQueryString() + getLimitParam();
  },

  exportReport: function(params) {
    var manager = goog.analytics.PropertyManager._getInstance();
    var newPropertyManager = goog.analytics.PropertyManager._getNewInstance();
    manager._set(goog.analytics.Properties._EVENT_ID, "");
    newPropertyManager._addProperties(manager._getQueryString() + "&" + params);
   
    var action = "UNKNOWN";
    if (params.indexOf("fmt=0") >= 0) {
      action = "PDF";
    } else if (params.indexOf("fmt=1") >= 0) {
      action = "XML";
    } else if (params.indexOf("fmt=2") >= 0) {
      action = "CSV";
    } else if (params.indexOf("fmt=3") >= 0) {
      action = "TSV";
    }
    _createEvent("Export", action, newPropertyManager._get(goog.analytics.Properties._REPORT_NAME));

    window.open("export" + "?" + newPropertyManager._getQueryString() + getLimitParam());
  },

  changePathInitialSelection: function(selection) {
    var manager = goog.analytics.PropertyManager._getInstance();

    manager._set(goog.analytics.Properties._PATH_INIT_SELECTION, selection);
    manager._set(goog.analytics.Properties._EVENT_ID, "PathChanged");

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changeGeoMap: function(targetId, zoomLevel, segmentBy) {
    var clonedManager = goog.analytics.PropertyManager._getInstance()._cloneAll();
    clonedManager._set(goog.analytics.Properties._DRILLDOWN, targetId);
    clonedManager._set(goog.analytics.Properties._GEOMAP_ZOOM_LEVEL, zoomLevel);
    clonedManager._set(goog.analytics.Properties._SEGMENT_BY, segmentBy);
    clonedManager._set(goog.analytics.Properties._EVENT_ID, "");

    location.href = "maps?" + clonedManager._getQueryString();
  },

  segmentMap: function(segmentBy) {
    var clonedManager = goog.analytics.PropertyManager._getInstance()._cloneAll();
    clonedManager._set(goog.analytics.Properties._SEGMENT_BY, segmentBy);
    clonedManager._set(goog.analytics.Properties._SEGMENT, "1");
    clonedManager._set(goog.analytics.Properties._EVENT_ID, "");

    location.href = "map_detail?" + clonedManager._getQueryString();
  },

  returnToMap: function(segmentBy) {
    var clonedManager = goog.analytics.PropertyManager._getInstance()._cloneAll();
    clonedManager._set(goog.analytics.Properties._SEGMENT_BY, segmentBy);
    clonedManager._set(goog.analytics.Properties._SEGMENT, "1");
    clonedManager._set(goog.analytics.Properties._EVENT_ID, "");

    location.href = "maps?" + clonedManager._getQueryString();
  },

  changeTimeSlice: function(newTimeSlice) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._TIME_RESOLUTION, newTimeSlice);
    manager._set(goog.analytics.Properties._EVENT_ID, "SliceChanged");

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changePathInitialRowCount: function(rows) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._PATH_INIT_ROW_COUNT, rows);
    manager._set(goog.analytics.Properties._EVENT_ID, "PathChanged");

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changePathFinalRowCount: function(rows) {
    var manager = goog.analytics.PropertyManager._getInstance();
    manager._set(goog.analytics.Properties._PATH_END_ROW_COUNT, rows);
    manager._set(goog.analytics.Properties._EVENT_ID, "PathChanged");

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  changePathSelectorPagination: function(sectionName, newStartRow) {
    var manager = goog.analytics.PropertyManager._getInstance();
    if (sectionName == "initial") {
      manager._set(goog.analytics.Properties._PATH_INIT_START_ROW, newStartRow);
    } else {
      manager._set(goog.analytics.Properties._PATH_END_START_ROW, newStartRow);
    }
    propertyManager._set(goog.analytics.Properties._EVENT_ID, "PathChanged");

    goog.analytics.Ajax.send(location.pathname+"?"+manager._getQueryString());
  },

  viewEventObjectDetail: function(objectName, segmentBy) {
    var clonedManager = goog.analytics.PropertyManager._getInstance()._clonePersistent();

    clonedManager._set(goog.analytics.Properties._DRILLDOWN, objectName);
    clonedManager._set(goog.analytics.Properties._SEGMENT_BY, segmentBy);
    clonedManager._set(goog.analytics.Properties._EVENT_ID, "");

    location.href = "event_object_detail?" + clonedManager._getQueryString();
  },

  viewEventObjectActionDetail: function(objectName, drilldownValue, detailType) {
    var clonedManager = goog.analytics.PropertyManager._getInstance()._clonePersistent();

    clonedManager._set(goog.analytics.Properties._DRILLDOWN, objectName);
    clonedManager._set(goog.analytics.Properties._DRILLDOWN2, drilldownValue);
    clonedManager._set(goog.analytics.Properties._EVENT_ID, "");

    var report;
    if (detailType == "event_action") {
      report = "event_object_action_detail";
    } else {
      report = "event_object_label_detail";
    }

    location.href = report + "?" + clonedManager._getQueryString();
  },

  changeSingleItemReport: function(newReport) {
    var pages = new Object();
    pages["ADS_REVENUE"] = "adsense_trending_revenue";
    pages["ADS_REVENUE_PER_THOUSAND_VISITS"] =
        "adsense_revenue_per_thousand_visits";
    pages["ADS_CLICKED"] = "adsense_trending_clicks";
    pages["ADS_CLICKED_PER_VISIT"] = "adsense_clicks_per_visit";
    pages["ADS_CLICK_THROUGH_RATE"] = "adsense_trending_ctr";
    pages["ADS_ESTIMATED_COST_PER_MILLE"] = "adsense_trending_ecpm";
    pages["ADS_UNITS_VIEWED"] = "adsense_trending_unit_impressions";
    pages["ADS_UNITS_VIEWED_PER_VISIT"] =
        "adsense_trending_unit_impressions_per_visit";
    pages["ADS_PAGES_VIEWED"] = "adsense_trending_page_impressions";
    pages["ADS_PAGES_VIEWED_PER_VISIT"] = "adsense_page_impressions_per_visit";
    
    pages["VISITS_WITH_SEARCHES"] = "search_visits";
    pages["UNIQUE_INTERNAL_SEARCHES"] = "unique_searches";
    pages["PAGEVIEWS_PER_SEARCH"] = "search_pageviews";
    pages["PERCENT_SEARCH_EXITS"] = "search_exits";
    pages["PERCENT_SEARCH_REFINEMENTS"] = "search_refinements";
    pages["DURATION_PER_SEARCH"] = "search_duration";
    pages["DEPTH_PER_SEARCH"] = "search_depth";

    pages["EVENTS"] = "events_item";
    pages["VISITS_WITH_EVENT"] = "visits_with_event";
    pages["EVENTS_PER_VISIT"] = "events_per_visit";
    VisualizationModule.changeReport(pages[newReport]);
  }

};

var VisualizationInstance = function() { }
VisualizationInstance.prototype = VisualizationModule;

var Visualization = new VisualizationInstance();


var FormsetSections = function(id, default_section) {
  this.id = id;
  this.currentSection = default_section;
}
FormsetSections.prototype = {
  toggle: function(section) {
    if (this.currentSection == section) return;

    goog.style.setStyle(document.getElementById(this.id+'_section_'+this.currentSection), "display", "none");

    goog.style.setStyle(document.getElementById(this.id+'_section_'+section), "display", "block");

    goog.dom.classes.remove(document.getElementById(this.id+'_tab_'+this.currentSection), "current");

    goog.dom.classes.add(document.getElementById(this.id+'_tab_'+section), "current");

    this.currentSection = section;

    email_preview.update(section);

    _createEvent("Email Setup", "Change Tab", section);
  }
}

var EmailPreview = function(numScheduledEmails, numReports) {
  this.numScheduledEmails = numScheduledEmails;
  this.numReports = numReports;
  this.numFormats = 4;
}
EmailPreview.prototype = {
  update: function(source) {
    this.updateToEmails(source);
    this.updateSubject(source);
    this.updateDescription(source);
    this.updateAttachments(source);
  },
  setNumReports: function(numReports) {
    this.numReports = numReports;
  },
  updateToEmails: function(source) {
    var to_emails='';
    var user_email = userEmail;
    if (source!='add_to') {
      var recipientsElement =
          document.getElementById('f_email_'+source+'_to_emails');
      if (recipientsElement) {
        to_emails = recipientsElement.value;
      }
      to_emails = to_emails.replace(/,/g, ", ");
      var ccSelfElement = document.getElementById('f_email_'+source+'_cc_self');
      if (ccSelfElement && ccSelfElement.checked) {
        if (to_emails!='') {
          to_emails+=', '+user_email;
        } else {
          to_emails=user_email;
        }
      }
    } else {
      for (var s = 0; s < this.numScheduledEmails; s++) {
        var targetElement =
            document.getElementById('f_email_target_schedule_'+s);
        if (targetElement && targetElement.checked) {
          to_emails=document.getElementById('f_email_target_schedule_'+s+'_to_emails').innerHTML;
        }
      }
    }
    document.getElementById('f_email_preview_to_emails').innerHTML =
      scriptEscape(to_emails);
  },
  updateSubject: function(source) {
    var subject = "";

    var schedule = "now";
    if (source == "schedule") {
      var scheduleElement = document.getElementById("f_email_schedule_repeating_schedule");
      if (scheduleElement) {
        var selectedSchedule = scheduleElement.options[scheduleElement.selectedIndex];
        schedule = selectedSchedule.value;
      }
    }
    var date_range = subjectDate[schedule];
    if (source != 'add_to') {
      subject = date_range;
      var subjectElement = document.getElementById('f_email_'+source+'_subject');
      var userText = "";
      if (subjectElement) {
        userText = subjectElement.value;
      }
      if (userText.length > 0) {
        subject += " (" + userText + ")";
      }
    } else {
      for (var s = 0; s < this.numScheduledEmails; s++) {
        var targetElement =
            document.getElementById('f_email_target_schedule_'+s);
        if (targetElement && targetElement.checked) {
          subject=document.getElementById('f_email_target_schedule_'+s+'_subject').innerHTML;
        }
        date_range = "";
      }
    }
    document.getElementById('f_email_preview_subject').innerHTML =
      scriptEscape(subject);
  },
  updateDescription: function(source) {
    var description='';
    if (source!='add_to') {
      var bodyElement = document.getElementById('f_email_'+source+'_description');
      if (bodyElement) {
        description = bodyElement.value;
      }
    } else {
      for (var i = 0; i < this.numScheduledEmails; i++) {
        var targetElement =
            document.getElementById('f_email_target_schedule_'+i);
        if (targetElement && targetElement.checked) {
          var dataFieldId = "f_email_target_schedule_" + i + "_description";
          var dataField = document.getElementById(dataFieldId);
          description = dataField.innerHTML;
        }
      }
    }
    document.getElementById('f_email_preview_description').innerHTML =
      scriptEscape(description);
  },
  updateAttachments: function(source) {
    var formatName = "";
    var attachmentText = "";

    if (source == "send_now" || source == "schedule" || source == "edit") {
      for (var f = 0 ; f < this.numFormats; f++) {
        var formatRadioId = "f_email_" + source + "_format_" + (f + 1);
        var currentFormatRadio = document.getElementById(formatRadioId);
        if (currentFormatRadio && currentFormatRadio.checked) {
          formatName = currentFormatRadio.value;
          break;
        }
      }

      if (source == "send_now") {
        var formatNum = 0;
        if (formatName == "pdf") {
          formatNum = 0;
        } else if (formatName == "xml") {
          formatNum = 1;
        } else if (formatName == "csv") {
          formatNum = 2;
        } else if (formatName == "tsv") {
          formatNum = 3;
        }

        var href = "export" +
                   "?" + goog.analytics.Properties._EXPORT_FORMAT +
                        "=" + formatNum +
                   "&" + goog.analytics.Properties._REPORT_NAME +
                        "=" + enc_report_name +
                   "&" + goog.analytics.PropertyManager._getInstance().
                            _getQueryString();

        attachmentText =
          '<a href="' + href + '" class="'+formatName+'">'+formatName.toUpperCase()+'</a>';
      } else {
        attachmentText = "<div class=\"" + formatName + "\">" +
                         formatName.toUpperCase() +"</div>";
      }
    } else if (source == "add_to") {
      for (var i = 0; i < this.numScheduledEmails; i++) {
        var targetElement =
            document.getElementById("f_email_target_schedule_" + i);
        if (targetElement && targetElement.checked) {
          var dataFieldId = "f_email_target_schedule_" + i + "_format";
          var dataField = document.getElementById(dataFieldId);
          formatName = dataField.innerHTML;
        }
      }
      attachmentText = "<div class=\"" + formatName + "\">" +
                       formatName +"</div>";
    }
    document.getElementById("f_email_preview_attachments").innerHTML = attachmentText;
  }
}

function scriptEscape(str) {
  str = str.replace(/\>/g, "&gt;");
  str = str.replace(/\</g, "&lt;");
  return str;
}

function isValidEmail(str) {
	return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);
}
function _openFeedback() {
  var manager = goog.analytics.PropertyManager._getInstance();
  var email = document.getElementById("f_email").innerHTML;
  var request = manager._getQueryString();

  var url = "http://www.google.com/support/analytics/bin/request.py?";
  url += "fb_email=" + encodeURIComponent(email);
  url += "&fb_cookie=" + encodeURIComponent(request);
  var mywin = window.open(url, "googlefeedback",'scrollbars=yes,menubar=yes,toolbar=yes,location=yes,width=800,height=600,resizable=yes');
  mywin.focus();
  return false;
}

function openAdmin() {
  var element = document.getElementById("profile");
  var profileId = element.options[element.selectedIndex].value;

  var accountId = "";
  if ((element = document.getElementById("account"))) {
    accountId = element.options[element.selectedIndex].value;
  } else if ((element = document.getElementById("accountId"))) {
    accountId = element.value;
  }

  var urlBase = "/analytics/home/admin?vid=1101&rid="+profileId;
  if (typeof adminUrlBase != 'undefined') urlBase = adminUrlBase;
  var url = urlBase+"&scid="+accountId;
  var mywin = window.open(url, "gaadmin",'scrollbars=yes,menubar=yes,toolbar=yes,location=yes,width=800,height=600,resizable=yes');
  mywin.focus();
  return false;
}
function _openHelp(path) {
  var manager = goog.analytics.PropertyManager._getInstance();
  var lang = manager._get(goog.analytics.Properties._LOCALE_HELP);
  var urlPath = "http://www.google.com/support/googleanalytics/bin/";
  var url = "";

  if (window.helpCenterUrlPath && window.helpCenterUrlPath != "") {
    urlPath = window.helpCenterUrlPath;
  }

  // Temporary work around.
  var newPath = path.replace(/ /g, "");
  newPath = newPath.replace(/75968/, "76269");

  if (path.indexOf("?") > -1) {
    url = urlPath + newPath + "&hl=" + lang;
  } else {
    url = urlPath + newPath + "?hl=" + lang;
  }
  var mywin = window.open(url, "gahelp",'scrollbars=yes,menubar=yes,toolbar=yes,location=yes,width=800,height=600,resizable=yes');
  mywin.focus();
}

var gaEvents = [];
function _createEvent(obj, action, label) {
  if (typeof(_pageTracker) == 'undefined') {
    return;
  }
  if (!gaEvents[obj]) {
    gaEvents[obj] = _pageTracker._createEventTracker(obj);
  }
  gaEvents[obj]._trackEvent(action, label);
}

var dropdowns = new Object();

function toggleMenu(dropdownId) {
  goog.analytics.Menu.toggle(dropdownId + "_button", dropdownId + "_menu", goog.analytics.MenuType.NARRATIVE)
}

function toggleAndFetchMenu(dropdownId, bodyId) {
  if (!dropdowns[dropdownId]) {
    var propertyManager = goog.analytics.PropertyManager._getInstance();
    propertyManager._set(goog.analytics.Properties._EVENT_ID, "Load" + bodyId);
    goog.analytics.Ajax.sendCustomLoading(location.pathname + "?" + propertyManager._getQueryString(), dropdownId + "_menu_loading");
    dropdowns[dropdownId] = true;
  }
  goog.analytics.Menu.toggle(dropdownId + "_button", dropdownId + "_menu", goog.analytics.MenuType.NARRATIVE)
}

function getLimitParam() {
  var limit = getUrlParam("limit");
  return (limit && (limit != "")) ? ("&limit=" + limit) : "";
}

function getUrlParam(name) {
  var regexp = new RegExp("[\\?&]" + name + "=([^&#]*)");
  var results = regexp.exec(window.location.href);
  return (results == null) ? null : results[1];
}
