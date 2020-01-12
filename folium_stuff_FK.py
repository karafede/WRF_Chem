
import os
os.chdir('C:\\ENEA_CAS_WORK\\Catania_RAFAEL')
import osmnx as ox
import networkx as nx
import numpy as np
import pandas as pd
import matplotlib.cm as cm
import matplotlib.colors as colors
import folium
from itertools import chain
import numpy as np
from colour import Color

# def make_folium_polyline(edge,             edge_width, edge_opacity, popup_attribute=None)
def make_folium_polyline(edge, edge_color, edge_width, edge_opacity, popup_attribute=None):

    """
    Turn a row from the gdf_edges GeoDataFrame into a folium PolyLine with
    attributes.

    Parameters
    ----------
    edge : GeoSeries
        a row from the gdf_edges GeoDataFrame
    edge_color : string
        color of the edge lines
    edge_width : numeric
        width of the edge lines
    edge_opacity : numeric
        opacity of the edge lines
    popup_attribute : string
        edge attribute to display in a pop-up when an edge is clicked, if None,
        no popup

    Returns
    -------
    pl : folium.PolyLine
    """

    # check if we were able to import folium successfully
    if not folium:
        raise ImportError('The folium package must be installed to use this optional feature.')

    # locations is a list of points for the polyline
    # folium takes coords in lat,lon but geopandas provides them in lon,lat
    # so we have to flip them around
    locations = list([(lat, lon) for lon, lat in edge['geometry'].coords])

    # if popup_attribute is None, then create no pop-up
    if popup_attribute is None:
        popup = None
    else:
        # folium doesn't interpret html in the html argument (weird), so can't
        # do newlines without an iframe
        popup_text = json.dumps(edge[popup_attribute])
        popup = folium.Popup(html=popup_text)

    # create a folium polyline with attributes
    pl = folium.PolyLine(locations=locations, popup=popup,
                         color=edge_color, weight=edge_width, opacity=edge_opacity)
    return pl


def make_folium_polyline_FK(edge, edge_width, edge_opacity, popup_attribute=None):

    """
    Turn a row from the gdf_edges GeoDataFrame into a folium PolyLine with
    attributes.

    Parameters
    ----------
    edge : GeoSeries
        a row from the gdf_edges GeoDataFrame
    edge_color : string
        color of the edge lines
    edge_width : numeric
        width of the edge lines
    edge_opacity : numeric
        opacity of the edge lines
    popup_attribute : string
        edge attribute to display in a pop-up when an edge is clicked, if None,
        no popup

    Returns
    -------
    pl : folium.PolyLine
    """

    # check if we were able to import folium successfully
    if not folium:
        raise ImportError('The folium package must be installed to use this optional feature.')

    # locations is a list of points for the polyline
    # folium takes coords in lat,lon but geopandas provides them in lon,lat
    # so we have to flip them around
    locations = list([(lat, lon) for lon, lat in edge['geometry'].coords])
    # colors = list([(edge_color) for edge_color in edge['edge_color']])
    colors = edge['edge_color'][0:3]
    colors = Color(hsl = colors)
    colors = "%s" % colors

    # if popup_attribute is None, then create no pop-up
    if popup_attribute is None:
        popup = None
    else:
        # folium doesn't interpret html in the html argument (weird), so can't
        # do newlines without an iframe
        popup_text = json.dumps(edge[popup_attribute])
        popup = folium.Popup(html=popup_text)

    # create a folium polyline with attributes
    pl = folium.PolyLine(locations=locations, popup=popup,
                         color= colors, weight=edge_width, opacity=edge_opacity)  # color= "#4c2745"
    return pl



##########################################################################
##########################################################################

# def plot_graph_folium(gdf_edges, graph_map=None, popup_attribute=None,
#                   tiles='cartodbpositron', zoom=1, fit_bounds=True,
#                   edge_width=5, edge_opacity=1)

def plot_graph_folium(G, graph_map=None, popup_attribute=None,
                      tiles='cartodbpositron', zoom=1, fit_bounds=True,
                      edge_color='#333333', edge_width=5, edge_opacity=1):
    """
    Plot a graph on an interactive folium web map.

    Note that anything larger than a small city can take a long time to plot and
    create a large web map file that is very slow to load as JavaScript.

    Parameters
    ----------
    G : networkx multidigraph
    graph_map : folium.folium.Map
        if not None, plot the graph on this preexisting folium map object
    popup_attribute : string
        edge attribute to display in a pop-up when an edge is clicked
    tiles : string
        name of a folium tileset
    zoom : int
        initial zoom level for the map
    fit_bounds : bool
        if True, fit the map to the boundaries of the route's edges
    edge_color : string
        color of the edge lines
    edge_width : numeric
        width of the edge lines
    edge_opacity : numeric
        opacity of the edge lines

    Returns
    -------
    graph_map : folium.folium.Map
    """

    # check if we were able to import folium successfully
    if not folium:
        raise ImportError('The folium package must be installed to use this optional feature.')

    # create gdf of the graph edges
    gdf_edges = graph_to_gdfs(G, nodes=False, fill_edge_geometry=True)

    # get graph centroid
    x, y = gdf_edges.unary_union.centroid.xy
    graph_centroid = (y[0], x[0])

    # create the folium web map if one wasn't passed-in
    if graph_map is None:
        graph_map = folium.Map(location=graph_centroid, zoom_start=zoom, tiles=tiles)

    # add each graph edge to the map
    for _, row in gdf_edges.iterrows():
        pl = make_folium_polyline(edge=row, edge_color=edge_color, edge_width=edge_width,
                                  edge_opacity=edge_opacity, popup_attribute=popup_attribute)
        pl.add_to(graph_map)

    # if fit_bounds is True, fit the map to the bounds of the route by passing
    # list of lat-lng points as [southwest, northeast]
    if fit_bounds:
        tb = gdf_edges.total_bounds
        bounds = [(tb[1], tb[0]), (tb[3], tb[2])]
        graph_map.fit_bounds(bounds)

    return graph_map



# def plot_graph_folium(gdf_edges, graph_map=None, popup_attribute=None,
#                   tiles='cartodbpositron', zoom=1, fit_bounds=True,
#                   edge_width=5, edge_opacity=1)

# tiles='cartodbpositron'

def plot_graph_folium_FK(gdf_edges, graph_map=None, popup_attribute=None,
                      zoom=1, fit_bounds=True,
                      edge_width=5, edge_opacity=1):
    """
    Plot a graph on an interactive folium web map.

    Note that anything larger than a small city can take a long time to plot and
    create a large web map file that is very slow to load as JavaScript.

    Parameters
    ----------
    G : networkx multidigraph
    graph_map : folium.folium.Map
        if not None, plot the graph on this preexisting folium map object
    popup_attribute : string
        edge attribute to display in a pop-up when an edge is clicked
    tiles : string
        name of a folium tileset
    zoom : int
        initial zoom level for the map
    fit_bounds : bool
        if True, fit the map to the boundaries of the route's edges
    edge_color : string
        color of the edge lines
    edge_width : numeric
        width of the edge lines
    edge_opacity : numeric
        opacity of the edge lines

    Returns
    -------
    graph_map : folium.folium.Map
    """

    # check if we were able to import folium successfully
    if not folium:
        raise ImportError('The folium package must be installed to use this optional feature.')

    # create gdf of the graph edges
    # gdf_edges = graph_to_gdfs(G, nodes=False, fill_edge_geometry=True)

    # get graph centroid
    x, y = gdf_edges.unary_union.centroid.xy
    graph_centroid = (y[0], x[0])

    # create the folium web map if one wasn't passed-in
    if graph_map is None:
        graph_map = folium.Map(location=graph_centroid, zoom_start=zoom) # tiles=tiles

    # add each graph edge to the map
    for _, row in gdf_edges.iterrows():
        pl = make_folium_polyline_FK(edge=row, edge_width=edge_width,
                                  edge_opacity=edge_opacity, popup_attribute=popup_attribute)
        pl.add_to(graph_map)

    # if fit_bounds is True, fit the map to the bounds of the route by passing
    # list of lat-lng points as [southwest, northeast]
    if fit_bounds:
        tb = gdf_edges.total_bounds
        bounds = [(tb[1], tb[0]), (tb[3], tb[2])]
        graph_map.fit_bounds(bounds)

    return graph_map