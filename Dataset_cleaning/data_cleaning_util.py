import geopandas as gpd
import json
import Levenshtein
import numpy as np
import math
import pandas as pd
import re

NULL_VALUE = "NULL"
DATE_FORMAT = "\d{4}/\d{2}/\d{2}"

elenco_comuni_istat_df = pd.read_excel('./resources/Elenco-comuni-italiani.xls')
elenco_comuni_istat_df = elenco_comuni_istat_df.fillna('')
comuni_istat_ita_list = elenco_comuni_istat_df['Denominazione in italiano'].tolist()
comuni_istat_altra_lingua_list = elenco_comuni_istat_df['Denominazione altra lingua'].tolist()
comuni_istat_ita_e_straniero_list = elenco_comuni_istat_df['Denominazione (Italiana e straniera)'].tolist()

def municipality_alignment(*, comune, comuni_istat_ita_list, comuni_istat_altra_lingua_list=None, comuni_istat_ita_e_straniero_list=None, null_value="NULL", max_levenshtein_distance=2):
    if comune == null_value:
        return comune
    
    comuni_istat_list = comuni_istat_ita_list.copy()
    number_comuni = len(comuni_istat_ita_list)
    if comuni_istat_altra_lingua_list is not None and number_comuni == len(comuni_istat_altra_lingua_list):
        comuni_istat_list.extend(comuni_istat_altra_lingua_list)
    else:
        raise Exception(f"La lunghezza della lista comuni_istat_ita_list non é uguale alla lunghezza lista comuni_istat_altra_lingua_list")
        
    if comuni_istat_ita_e_straniero_list is not None and number_comuni == len(comuni_istat_ita_e_straniero_list):
         comuni_istat_list.extend(comuni_istat_ita_e_straniero_list)
    else:
       raise Exception(f"La lunghezza della lista comuni_istat_ita_list non é uguale alla lunghezza lista comuni_istat_ita_e_straniero_list")

    comune = " ".join(comune.split())
    comune_candidates = set()
    for index, comune_istat in enumerate(comuni_istat_list):
        if comune.lower() == comune_istat.lower():
            if comune != comuni_istat_ita_list[index % number_comuni]:
                print(f"Corrected comune {comune} to {comuni_istat_ita_list[index % number_comuni]}")
            return comuni_istat_ita_list[index % number_comuni]
        if comune.lower() in comune_istat.lower().split():
            comune_candidates.add(comuni_istat_ita_list[index % number_comuni])
    if len(comune_candidates) == 1:
        comune_corrected = comune_candidates.pop()
        print(f"Corrected comune {comune} to {comune_corrected}")
        return comune_corrected
    elif len(comune_candidates) > 1:
        raise Exception(f"Il nome del comune {comune} é contenuto in piú nomi ufficiali {', '.join(list(comune_candidates))}")

    lv_distances = [Levenshtein.distance(comune.lower(), comune_istat.lower()) for comune_istat in comuni_istat_list]
    arg_min_list = np.flatnonzero(lv_distances == np.min(lv_distances))

    if lv_distances[arg_min_list[0]] > max_levenshtein_distance:
        raise Exception(f"Non é stato trovato nome ufficiale del comune {comune} con distanza Levenshtein massima di {max_levenshtein_distance}")

    arg_min_list = list(set([arg_min % number_comuni for arg_min in arg_min_list]))

    if len(arg_min_list) == 1:
        print(f"Corrected comune {comune} to {comuni_istat_list[arg_min_list[0] % number_comuni]}")
        return comuni_istat_list[arg_min_list[0] % number_comuni]
    else:
        raise Exception(f"Il nome del comune {comune} ha la stessa distanza Levenshtein da {', '.join([comuni_istat_list[arg_min] for arg_min in arg_min_list])}")

elenco_comuni_cap = pd.read_excel('./resources/comuni-localita-cap-italia.xls', converters={'CAP':str})

def map_comune_to_elenco_comuni_cap(comune):
    mapping = dict()
    mapping["Sant'Egidio del Monte Albino"] = "SANT'EGIDIO DEL MONTALBINO"
    return mapping[comune] if comune in mapping else comune

def getAddressInfo(*, comune, elenco_comuni_cap):
    #special rule added cause the table in elenco comuni does not contain the correct data and return values from different place
    if comune == "Corbara":
        return "84010", "SA", "Campania"
    comune_cap_row = elenco_comuni_cap.loc[elenco_comuni_cap['Comune Localita’'] == comune.upper()]
    cap = comune_cap_row.iloc[:,2].values[0]
    province = comune_cap_row.iloc[:,1].values[0]
    region = comune_cap_row.iloc[:,4].values[0]
    return cap, province, region

def remove_extra_spaces(string):
    return " ".join(string.split())

def check_date_format(date, date_format):
    if re.match(date_format, date):
        return date
    raise Exception(f"date {date} does not match date_format {date_format}")

def get_latitude_longitude(*, string, null_value=None):
    search_result = re.fullmatch("(\d+\.?\d*),\s*(\d+\.?\d*)", string)
    if search_result:
        latitude = float(search_result.group(1))
        longitude = float(search_result.group(2))
        return latitude, longitude

    try:
        string = string.replace('"properties":null', '"properties":{}')
        geo_json = json.loads(string)
    except ValueError as e:
        return null_value, null_value if null_value else None

    if not isinstance(geo_json, dict):# and "features" not in geo_json:
        return null_value, null_value if null_value else None

    if "features" not in geo_json:
        return null_value, null_value if null_value else None

    gdf = gpd.GeoDataFrame.from_features(geo_json)
    latitude = gdf["geometry"].centroid.y[0]
    longitude = gdf["geometry"].centroid.x[0]
    return latitude, longitude

def float_tuple_to_string_list(float_tuple):
    return [str(x) for x in float_tuple]