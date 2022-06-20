import numpy as np
import pandas as pd
import plotly.graph_objects as go
import socket
import sparql_dataframe
import textwrap
import warnings

from argparse import ArgumentParser

from plotly.subplots import make_subplots

from pywebio import start_server
from pywebio.input import *
from pywebio.output import *
from pywebio.pin import *

from urllib.parse import urlparse

warnings.filterwarnings('ignore')

global endpoint
global itinerary_category_options
global region_options
global province_options
global municipality_options
global default_option_for_selection

endpoint = "http://localhost:8080/sparql"
itinerary_category_options = ["aziendale", "culinario", "culturale"]
region_options = []
province_options = []
municipality_options = []
default_option_for_selection = "Seleziona"

def path_to_image_html(path):
    return '<img src="'+ path + '" width="60" alt="nessuna immagine">'

def is_url(url):  
  try:
    result = urlparse(url)
    return all([result.scheme, result.netloc])
  except ValueError:
    return False

def surround_with_quotes(text):
    if '"' in text and "'" in text:
        raise Exception("search text contains single and double quotes")
    if '"' in text:
        return f"'{text}'"
    return f'"{text}"'

def add_default_option(options, value=None, position=0, default=True):
    global default_option_for_selection
    if default:
        options.insert(position, default_option_for_selection)
    else:
        options.insert(position , value)
    return options

def get_clean_result_df_and_plot_df(df, max_text_size_df=50, break_hover_text_at_size=40, max_text_size_hover_text=800):
    if df is None:
        return None
    
    df = df.fillna("Non disponibile")
    plot_df = df.copy()

    all_columns = list(plot_df)
    plot_df[all_columns] = plot_df[all_columns].astype(str)

    for column in all_columns:
        plot_df[column] = plot_df[column].map(lambda x: x if is_url(x) else "<br>".join(textwrap.wrap(x, break_hover_text_at_size, break_long_words=True)))
        plot_df[column] = plot_df[column].map(lambda x: x if is_url(x) or len(str(x)) < max_text_size_hover_text else x[:max_text_size_hover_text-3] + "..." )
    
    filteredColumns = df.dtypes[df.dtypes == np.object]
    listOfColumnNames = list(filteredColumns.index)
    for column in listOfColumnNames:
        df[column] = df[column].map(lambda x: x if is_url(str(x)) or len(str(x)) < max_text_size_df else str(x)[:max_text_size_df-3] + "..." )
    
    df.index += 1
    return df, plot_df

def update(df, with_filter_values):
    filter_values = with_filter_values
    for key in ["region", "province", "municipality"]:
        if filter_values[key] is not None:
            df[key] = filter_values[key]
    return df

def get_company_culinary_cultural_itinerary_df_and_plot(filter_values={"title_search_keyword": None, "description_search_keyword": None, 'categories': itinerary_category_options, 'municipality': None, 'province': None, 'region': None}):
    global endpoint

    company_itineraries_result_df = None
    if not filter_values['categories'] or "aziendale" in filter_values['categories']:
        query_company_itineraries = f"""
            PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
            PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

            select ?image_url ?company_name ?company_production_sector ?brand_name ?localita ?municipality ?province ?region ?type ?company_n_register ?brand_description ?brand_date_registration ?notes ?bibliography ?sitography ?latitude ?longitude 
            where{{
            ?x rdf:type :Company_itinerary;
                :CompanyItLat ?latitude;
                :CompanyItLong ?longitude;
                :companyItineraryInvolves ?company_id;
                :companyItinerarySituatedIn ?municipality_id.

            ?municipality_id :MunicipalityName {'?municipality' if filter_values['municipality'] is None else surround_with_quotes(filter_values['municipality'])};
                :isInProvince ?province_id;
                :isInRegion ?region_id.
            ?province_id :ProvinceAbbreviation {'?province' if filter_values['province'] is None else surround_with_quotes(filter_values['province'])}.
            ?region_id :RegionName {'?region' if filter_values['region'] is None else surround_with_quotes(filter_values['region'])}.

            optional {{ ?x :CompanyItBibl ?bibliography }}
            optional {{ ?x :CompanyItLoc ?localita }}
            optional {{ ?x :CompanyItNote ?notes }}
            optional {{ ?x :CompanyItSit ?sitography }}
            optional {{ ?x :CompanyItType ?type }}            
            optional {{ ?x :CompanyItImageUrl ?image_url }}            

            ?company_id :CompanyName ?company_name.
            optional {{ ?company_id :CompanyNRegister ?company_n_register }}
            optional {{ ?company_id :CompanyProdSector ?company_production_sector }}

            optional {{ ?company_id :hasBrand ?brand

                optional {{ ?brand :BrandDateRegistration ?brand_date_registration }}
                optional {{ ?brand :BrandDescription ?brand_description }}
                ?brand :BrandName ?brand_name
            }}

            {"" if filter_values['title_search_keyword'] is None else f"filter (contains(?company_name, {surround_with_quotes(filter_values['title_search_keyword'])}))"}
            {"" if filter_values['description_search_keyword'] is None else f"filter (contains(?brand_description, {surround_with_quotes(filter_values['description_search_keyword'])}))"}
            }}
            """
        company_itineraries_result_df = sparql_dataframe.get(endpoint, query_company_itineraries)
        company_itineraries_result_df = update(company_itineraries_result_df, with_filter_values=filter_values)
        company_itineraries_result_df, company_itinerary_plot_df = get_clean_result_df_and_plot_df(company_itineraries_result_df)
        company_itineraries_result_df = company_itineraries_result_df.rename(columns={'image_url': 'Immagine', 'company_name': 'Nome azienda', 'company_production_sector': 'Settore di produzione',\
                                                                'brand_name': 'Nome marchio', 'localita': 'Località', 'municipality': 'Comune', 'province': 'Provincia', 'region': 'Regione', \
                                                                'type': 'Tipologia', 'company_n_register': 'N Registro', 'description': 'Descrizione marchio', 'brand_date_registration': 'Data registrazione marchio',\
                                                                'notes': 'Note', 'bibliography': 'Bibliografia', 'sitography': 'Sitografia', 'latitude': 'Latitudine', 'longitude': 'Longitudine'})
        company_itinerary_plot_df['hover_text'] = "<b>Itinerario aziendale:</b><br>" + company_itinerary_plot_df['company_name'] \
                                                 + "<br><b>Nome marchio:</b> " + company_itinerary_plot_df['brand_name'] \
                                                 + "<br><b>Settore produzione:</b> " + company_itinerary_plot_df['company_production_sector'] \
                                                 + "<br><b>Comune:</b> " + company_itinerary_plot_df['municipality'] + " (" + company_itinerary_plot_df['province'] + ")" \
                                                 + "<br><b>Informazioni:</b> " + company_itinerary_plot_df['brand_description']
        

    culinary_itineraries_result_df = None
    if not filter_values['categories'] or "culinario" in filter_values['categories']:
        query_culinary_itineraries = f"""
            PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
            PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

            select ?image_url ?name ?municipality ?province ?region ?type ?description ?notes ?latitude ?longitude 
            where{{
            ?x rdf:type :Culinary_itinerary;
                :CulinaryItLat ?latitude;
                :CulinaryItLong ?longitude;
                :culinaryItineraryProposes ?culinaryProduct;
                :culinaryItinerarySituatedIn ?municipality_id.

            ?municipality_id :MunicipalityName {'?municipality' if filter_values['municipality'] is None else surround_with_quotes(filter_values['municipality'])};
                :isInProvince ?province_id;
                :isInRegion ?region_id.
            ?province_id :ProvinceAbbreviation {'?province' if filter_values['province'] is None else surround_with_quotes(filter_values['province'])}.
            ?region_id :RegionName {'?region' if filter_values['region'] is None else surround_with_quotes(filter_values['region'])}.
            
            ?culinaryProduct :CulinaryProductName ?name.
            
            optional {{ ?x :CulinaryItType ?type }}
            optional {{ ?x :CulinaryItDescr ?description}}
            optional {{ ?x :CulinaryItNote ?notes }}
            optional {{ ?x :CulinaryItImageUrl ?image_url }}            

            {"" if filter_values['title_search_keyword'] is None else f"filter (contains(?name, {surround_with_quotes(filter_values['title_search_keyword'])}))"}
            {"" if filter_values['description_search_keyword'] is None else f"filter (contains(?description, {surround_with_quotes(filter_values['description_search_keyword'])}))"}
            }}
            """
        culinary_itineraries_result_df = sparql_dataframe.get(endpoint, query_culinary_itineraries)
        culinary_itineraries_result_df = update(culinary_itineraries_result_df, with_filter_values=filter_values)
        culinary_itineraries_result_df, culinary_itinerary_plot_df = get_clean_result_df_and_plot_df(culinary_itineraries_result_df)
        culinary_itineraries_result_df = culinary_itineraries_result_df.rename(columns={'image_url': 'Immagine', 'name': 'Nome itinerario', 'municipality': 'Comune', 'province': 'Provincia', \
                                                        'region': 'Regione', 'type': 'Tipologia', 'description': 'Informazioni', 'notes': 'Note', 'latitude': 'Latitudine', 'longitude': 'Longitudine'})
        culinary_itinerary_plot_df['hover_text'] = "<b>Itinerario culinario:</b><br>" + culinary_itinerary_plot_df['name']\
                                                 + "<br><b>Comune:</b> " + culinary_itinerary_plot_df['municipality'] + " (" + culinary_itinerary_plot_df['province'] + ")" \
                                                 + "<br><b>Informazioni:</b><br>" + (culinary_itinerary_plot_df['description'])

    cultural_itineraries_result__df = None
    if not filter_values['categories'] or "culturale" in filter_values['categories']:
        query_cultural_itineraries = f"""
            PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
            PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

            select ?image_url ?name ?localita ?address ?municipality ?province ?region ?type ?type_period ?century ?style ?information ?notes ?bibliography ?sitography ?latitude ?longitude
            where{{
            ?x rdf:type :Cultural_itinerary;
                :CulturalItLat ?latitude;
                :CulturalItLong ?longitude;
                :culturalItineraryProposes ?poi;
                :culturalItinerarySituatedIn ?municipality_id.

            ?municipality_id :MunicipalityName {'?municipality' if filter_values['municipality'] is None else surround_with_quotes(filter_values['municipality'])};
                :isInProvince ?province_id;
                :isInRegion ?region_id.
            ?province_id :ProvinceAbbreviation {'?province' if filter_values['province'] is None else surround_with_quotes(filter_values['province'])}.
            ?region_id :RegionName {'?region' if filter_values['region'] is None else surround_with_quotes(filter_values['region'])}.

            optional {{ ?poi :POIName ?name }}
            optional {{ ?poi :POICentury ?century }}
            optional {{ ?poi :POIStyle ?style }}
            optional {{ ?poi :POIType ?type }}

            optional {{ ?x :CulturalItAddr ?address }}
            optional {{ ?x :CulturalItBibl ?bibliography }}
            optional {{ ?x :CulturalItInfo ?information }}
            optional {{ ?x :CulturalItLoc ?localita }}
            optional {{ ?x :CulturalItNote ?notes }}
            optional {{ ?x :CulturalItSit ?sitography }}
            optional {{ ?x :CulturalItType ?type_period }}
            optional {{ ?x :CulturalItImageUrl ?image_url }}

            {"" if filter_values['title_search_keyword'] is None else f"filter (contains(?name, {surround_with_quotes(filter_values['title_search_keyword'])}))"}
            {"" if filter_values['description_search_keyword'] is None else f"filter (contains(?information, {surround_with_quotes(filter_values['description_search_keyword'])}))"}
            }}
            """

        cultural_itineraries_result__df = sparql_dataframe.get(endpoint, query_cultural_itineraries)  
        cultural_itineraries_result__df = update(cultural_itineraries_result__df, with_filter_values=filter_values)
        cultural_itineraries_result__df, cultural_itinerary_plot_df = get_clean_result_df_and_plot_df(cultural_itineraries_result__df)
        cultural_itineraries_result__df = cultural_itineraries_result__df.rename(columns={'image_url': 'Immagine', 'name': 'Nome itinerario', 'localita': 'Località', 'address': 'Indirizzo', 'municipality': 'Comune', \
                                                                'province': 'Provincia', 'region': 'Regione', 'type': 'Tipologia', 'type_period': 'Itinerario (periodo)', 'century': 'Secolo di costruzione', \
                                                                'style': 'Stile', 'notes': 'Note', 'bibliography': 'Bibliografia', 'sitography': 'Sitografia', 'latitude': 'Latitudine', 'longitude': 'Longitudine'})
        cultural_itinerary_plot_df['hover_text'] = "<b>Itinerario culturale:</b><br>" + cultural_itinerary_plot_df['name']\
                                                 + "<br><b>Tipo:</b> " + cultural_itinerary_plot_df['type']\
                                                 + "<br><b>Comune:</b> " + cultural_itinerary_plot_df['municipality'] + " (" + cultural_itinerary_plot_df['province'] + ")" \
                                                 + "<br><b>Informazioni:</b><br>" + (cultural_itinerary_plot_df['information'])

    fig = go.Figure(go.Scattergeo())
    if cultural_itineraries_result__df is not None:
        fig.add_scattergeo(name= "culturale",
                      lat = cultural_itinerary_plot_df["latitude"],
                      lon = cultural_itinerary_plot_df["longitude"],
                      hoverinfo = "text",
                      hovertext = cultural_itinerary_plot_df['hover_text'],
                      marker_size = 8,
                      marker_color = 'blue',
                      marker_symbol = 'star',
                      showlegend = True) 
    if company_itineraries_result_df is not None:
        fig.add_scattergeo(name= "aziendale",
                      lat = company_itinerary_plot_df["latitude"],
                      lon = company_itinerary_plot_df["longitude"],
                      hoverinfo = "text",
                      hovertext = company_itinerary_plot_df['hover_text'],
                      marker_size = 8,
                      marker_color = 'green',
                      marker_symbol = 'star',
                      showlegend = True)
    if culinary_itineraries_result_df is not None:
        fig.add_scattergeo(name= "culinario",
                      lat = culinary_itinerary_plot_df["latitude"],
                      lon = culinary_itinerary_plot_df["longitude"],
                      hoverinfo = "text",
                      hovertext = culinary_itinerary_plot_df['hover_text'],
                      marker_size = 8,
                      marker_color = 'red',
                      marker_symbol = 'star',
                      showlegend = True)


    fig.update_layout(width = 675, height=900,
            geo = dict(
                scope = 'europe',
                resolution = 50,
                lonaxis_range= [ 6.6, 18.4 ],
                lataxis_range= [35.47, 47.25],
                landcolor = 'rgb(217, 217, 217)',
            ),
            margin = dict(
                t=0,
                l=0,
                r=0,
                b=0,
            ),
            legend_title='<b>Categoria itinerario</b>',
            legend=dict(
                x = 0.8,
                y = .1,
                traceorder = "normal",
                font = dict(
                    family="sans-serif",
                    size=12,
                    color="black"
                )
            )
    )
    return company_itineraries_result_df, culinary_itineraries_result_df, cultural_itineraries_result__df, fig

def get_municipality_zip_code_province_region(municipality=None, zip_code=None, province=None, region=None, return_municipality=False, return_zip_code=False, return_province=False, return_region=False):
    global endpoint

    query = f"""
        PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

        select distinct {"?municipality " if return_municipality else ""}{"?zip_code " if return_zip_code else ""}{"?province " if return_province else ""}{"?region " if return_region else ""}
        where{{
        {"" if municipality else "optional" } {{ ?x rdf:type :Municipality;
            :MunicipalityName {surround_with_quotes(municipality) if municipality else "?municipality"} }}.
        {"" if zip_code else "optional" } {{ ?x :MunicipalityZipCode {zip_code if zip_code else "?zip_code"} }}.
        {"" if province else "optional" } {{ ?x :isInProvince ?province_id.
            ?province_id :ProvinceAbbreviation {surround_with_quotes(province) if province else "?province"}}}.
        {"" if region else "optional" } {{ ?x :isInRegion ?region_id.
            ?region_id :RegionName {surround_with_quotes(region) if region else "?region"}}}.
        }}
        """
    return sparql_dataframe.get(endpoint, query)

def get_all_regions():
    global endpoint

    query = f"""
        PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

        select ?region
        where{{
        ?x rdf:type :Region;
            :RegionName ?region.
        }}
    """
    return sparql_dataframe.get(endpoint, query)

def get_all_provinces():
    global endpoint

    query = f"""
        PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

        select ?province
        where{{
        ?x rdf:type :Province;
            :ProvinceAbbreviation ?province.
        }}
    """
    return sparql_dataframe.get(endpoint, query)

def get_all_municipalities():
    global endpoint

    query = f"""
        PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

        select ?municipality
        where{{
        ?x rdf:type :Municipality;
            :MunicipalityName ?municipality.
        }}
    """
    return sparql_dataframe.get(endpoint, query)

def create_header():
    with use_scope('header'):
    #img = open('top_image.jpg', 'rb').read()
    #put_image(img, width='400px')
        put_html("<div style='text-align: center;'>\
            <h1>Trova il tuo prossimo itinerario!</h1>\
            <img src='https://www.maxpixel.net/static/photo/2x/Cinque-Terre-Italy-Sunset-Liguria-Mediterranean-5060534.jpg' width='700px'>\
            <br><br>\
            <h3>Compila il modulo e trova i migliori suggerimenti per te.</h3>\
            </div>")
    #https://upload.wikimedia.org/wikipedia/commons/d/d3/Costiera_Amalfitana%2C_Italy_%2820842574289%29.jpg alternative 
    return

def create_filters(reset=False):
    global region_options
    global province_options
    global municipality_options
    global itinerary_category_options

    filter_values = {"title_search_keyword": None,
                     "description_search_keyword": None,
                     "region": None,
                     "province": None,
                     "municipality": None,
                     "categories": itinerary_category_options,
                    }
    if reset:
        with use_scope('filters'):
            region_options = add_default_option(sorted(get_all_regions()["region"].to_list()))
            pin_update(name='region', value=region_options)
            province_options=add_default_option(sorted(get_all_provinces()["province"].to_list()))
            pin_update(name='province', value=province_options)
            municipality_options = add_default_option(sorted(get_all_municipalities()["municipality"].to_list()))
            pin_update(name='municipality', value=municipality_options)
            pin_update(name='categories', value=[])
            pin_update(name='title_search_keyword', value="")
            pin_update(name='description_search_keyword', value="")
        return filter_values

    with use_scope('filters'):
        region_options = add_default_option(sorted(get_all_regions()["region"].to_list()))
        put_select(label='Regione', name='region', options=region_options)
        province_options=add_default_option(sorted(get_all_provinces()["province"].to_list()))
        put_select(label='Provincia', name='province', options=province_options)
        municipality_options = add_default_option(sorted(get_all_municipalities()["municipality"].to_list()))
        put_select(label='Comune', name='municipality', options=municipality_options)
        put_checkbox(label='Categoria', name='categories', options=itinerary_category_options, inline=True)
        put_input(label='Cerca nel titolo', name='title_search_keyword', placeholder="Digita qui")
        put_input(label='Cerca nella descrizione', name='description_search_keyword', placeholder="Digita qui")
    return filter_values
    

def check_input(new_filter_value):
    global region_options
    global province_options
    global municipality_options
    global itinerary_category_options
    global default_option_for_selection
    if new_filter_value['name'] in ['region', 'province', 'municipality'] and new_filter_value['value'] == default_option_for_selection:
        new_filter_value['value'] = ""
        return new_filter_value
    if new_filter_value['name'] == 'region' and new_filter_value['value'] not in region_options:
        put_warning("È stato scelto una regione non valida", scope='filters', position=1, closable=True)
        new_filter_value['value'] = ""
        return new_filter_value
    if new_filter_value['name'] == 'province' and new_filter_value['value'] not in province_options:
        put_warning("È stato scelto una provincia non valida", scope='filters', position=2, closable=True)
        new_filter_value['value'] = ""
        return new_filter_value
    if new_filter_value['name'] == 'municipality' and new_filter_value['value'] not in municipality_options:
        put_warning("È stato scelto un comune non valido", scope='filters', position=3, closable=True)
        new_filter_value['value'] = ""
        return new_filter_value
    
    def is_valid_itinerary_category(input):
        global itinerary_category_options
        try:
            if len(input) > len(itinerary_category_options):
                return False
            for value in input:
                if value not in itinerary_category_options:
                    return False
            if len(input) != len(set(input)):
                return False
        except:
            return False
        return True

    if new_filter_value['name'] == 'categories' and not is_valid_itinerary_category(new_filter_value['value']):
        put_warning("È stato scelta una categoria non valida", scope='filters', position=4, closable=True)
        pin_update(name='categories', value=[])
        new_filter_value['value'] = []
        return new_filter_value
    if new_filter_value['name'] == 'title_search_keyword' and '"' in new_filter_value['value'] and "'" in new_filter_value['value']:
        put_warning("Non é possibile usare ' e \" nella stessa ricerca", scope='filters', position=5, closable=True)
        new_input = new_filter_value['value'][:max(new_filter_value['value'].find("'"), new_filter_value['value'].find('"'))]
        pin_update(name='title_search_keyword', value=new_input)
        new_filter_value['value'] = new_input
        return new_filter_value
    if new_filter_value['name'] == 'description_search_keyword' and '"' in new_filter_value['value'] and "'" in new_filter_value['value']:
        put_warning("Non é possibile usare ' e \" nella stessa ricerca", scope='filters', closable=True)
        new_input = new_filter_value['value'][:max(new_filter_value['value'].find("'"), new_filter_value['value'].find('"'))]
        pin_update(name='description_search_keyword', value=new_input)
        new_filter_value['value'] = new_input
        return new_filter_value
    return new_filter_value

def update_municipality_province_region_filter(new_filter_value, filter_values):
    global region_options
    global province_options
    global municipality_options
    if new_filter_value['name'] == 'region':
        province_options = sorted(get_municipality_zip_code_province_region(region=new_filter_value['value'], return_province=True)['province'].to_list())
        province_options = add_default_option(province_options)
        pin_update(name='province', options=province_options)
        filter_values['province'] = None
        municipality_options = sorted(get_municipality_zip_code_province_region(region=new_filter_value['value'], return_municipality=True)['municipality'].to_list())
        municipality_options = add_default_option(municipality_options)
        pin_update(name='municipality', options=municipality_options)
        filter_values['municipality'] = None
        return filter_values
    if new_filter_value['name'] == 'province':
        municipality_options = sorted(get_municipality_zip_code_province_region(region=filter_values['region'], province=new_filter_value['value'], return_municipality=True)['municipality'].to_list())
        municipality_options = add_default_option(municipality_options)
        pin_update(name='municipality', options=municipality_options)
        filter_values['municipality'] = None
        return filter_values
    return filter_values

def update_plot_and_result_tables(filter_values):
    company_itineraries_result_df, culinary_itineraries_result_df, cultural_itineraries_result__df, fig = get_company_culinary_cultural_itinerary_df_and_plot(filter_values)
    with use_scope('map', clear=True):
            put_html(fig.to_html(include_plotlyjs="require", full_html=False))

    with use_scope('table', clear=True):
        if company_itineraries_result_df is not None:
            put_html("<h2>Itinerari aziendali:</h2>")
            put_html(company_itineraries_result_df.to_html(escape=False, formatters=dict(Immagine=path_to_image_html)))
        if culinary_itineraries_result_df is not None:
            put_html("<h2>Itinerari culinari:</h2>")
            put_html(culinary_itineraries_result_df.to_html(escape=False, formatters=dict(Immagine=path_to_image_html)))
        if cultural_itineraries_result__df is not None:
            put_html("<h2>Itinerari culturali:</h2>")
            put_html(cultural_itineraries_result__df.to_html(escape=False, formatters=dict(Immagine=path_to_image_html)))
    
    with use_scope('result_summary', clear=True):
        put_html(f"<h2>Itinerari trovati:</h2><br>\
                   Itinerari aziendali: {0 if company_itineraries_result_df is None else company_itineraries_result_df.shape[0]}<br>\
                   Itinerari culinari: {0 if culinary_itineraries_result_df is None else culinary_itineraries_result_df.shape[0]}<br>\
                   Itinerari culturali: {0 if cultural_itineraries_result__df is None else cultural_itineraries_result__df.shape[0]}")
    return

def app():
    """
    Trova itinerario
    """
    put_scope("header")
    put_row([
        put_column([put_scope("filters"), None, put_scope("result_summary")], size='64% 1% 35%'), 
        None,
        put_scope("map")
        ], size='24% 2% 74%')
    put_scope("table")
    
    create_header()

    filter_values = create_filters()

    update_plot_and_result_tables(filter_values)

    while True:
        try:
            new_filter_value = pin_wait_change(['region', 'province', 'municipality', 'categories', 'title_search_keyword', 'description_search_keyword'])
            new_filter_value = check_input(new_filter_value)
            filter_values[new_filter_value['name']] = None if new_filter_value['value'] == "" else new_filter_value['value']
            filter_values = update_municipality_province_region_filter(new_filter_value, filter_values)
        except:
            put_warning("Sono stati inseriti valori errati. Tutti i filtri sono stati azzerati.", scope='header', closable=True)
            filter_values = create_filters(reset=True)

        update_plot_and_result_tables(filter_values)

        #with use_scope('result_summary'):
        #    put_text(filter_values)
            
def is_port_in_use(port: int) -> bool:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        return s.connect_ex(('localhost', port)) == 0

if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument("-r", "--remote_access", dest="remote_access", default=False,
                        help="If set to true an address for remote access will be created")
    parser.add_argument("-p", "--port", dest="port", default=8080, type=int,
                        help="Set the port on which to access the web-application")
    parser.add_argument("-d", "--debug", dest="debug", default=False,
                        help="Set the environment to debug mode")
    parser.add_argument("-a", "--auto_open_webbrowser", dest="auto_open_webbrowser", default=True,
                        help="Opens the web-application in default browser after launch")

    args = parser.parse_args()
    port = args.port
    while is_port_in_use(port):
        print('\033[93m' + f"Port {port} already in use. Switching to {port+1}" + '\x1b[0m')
        port += 1

    start_server(app, debug=False, port=port, remote_access=args.remote_access, auto_open_webbrowser=args.auto_open_webbrowser)