[QueryItem="Brand"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?name ?description ?registrationDate
where{
?brand_id a :Brand.
optional { ?brand_id :BrandName ?name }
optional { ?brand_id :BrandDateRegistration ?registrationDate }
optional { ?brand_id :BrandDescription ?description }
}
[QueryItem="Company"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?company_id ?name ?nreg ?sector ?brand_id
where{
?company_id a :Company;
     :CompanyNRegister ?nreg;
     :CompanyName ?name;
     :CompanyProdSector ?sector.
}
[QueryItem="Culinary Product"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?name
where{
?culinary_product_id a :Culinary_product;
     :CulinaryProductName ?name.
}
[QueryItem="Municipality"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?municipality ?zipcode  ?province ?region
where{
            	?municipality_id a :Municipality;
		:MunicipalityName ?municipality;
		:MunicipalityZipCode ?zipcode;
                		:isInProvince ?province_id;
                		:isInRegion ?region_id.
            	?province_id :ProvinceAbbreviation ?province.
            	?region_id :RegionName ?region.
}
[QueryItem="Province"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?abbr
where{
	?x a :Province;
     		:ProvinceAbbreviation ?abbr.
}
[QueryItem="Region"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?name
where{
	?x a :Region;
     		:RegionName ?name.
}
[QueryItem="POI"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?name ?type ?century ?style
where{
	?x a :Point_of_interest;
     		:POIName ?name;
     		:POIType ?type;
     		:POICentury ?century;
     		:POIStyle ?style.
}
[QueryItem="Company Itinerary"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?image_url ?company_name ?company_production_sector ?brand_name ?localita ?municipality ?province ?region ?type ?company_n_register ?brand_description ?brand_date_registration ?notes ?bibliography ?sitography ?latitude ?longitude
where{
	?x a :Company_itinerary;
                		:CompanyItLat ?latitude;
                		:CompanyItLong ?longitude;
                		:companyItineraryInvolves ?company_id;
                		:companyItinerarySituatedIn ?municipality_id.

            	?municipality_id :MunicipalityName ?municipality;
                		:isInProvince ?province_id;
                		:isInRegion ?region_id.
            	?province_id :ProvinceAbbreviation ?province.
            	?region_id :RegionName ?region.

            	optional { ?x :CompanyItBibl ?bibliography }
            	optional { ?x :CompanyItLoc ?localita }
            	optional { ?x :CompanyItNote ?notes }
            	optional { ?x :CompanyItSit ?sitography }
            	optional { ?x :CompanyItType ?type }
            	optional { ?x :CompanyItImageUrl ?image_url }

            	?company_id :CompanyName ?company_name.
            	optional { ?company_id :CompanyNRegister ?company_n_register }
            	optional { ?company_id :CompanyProdSector ?company_production_sector }

            	optional { ?company_id :hasBrand ?brand

                		optional { ?brand :BrandDateRegistration ?brand_date_registration }
                		optional { ?brand :BrandDescription ?brand_description }
                		?brand :BrandName ?brand_name
            	}
}
[QueryItem="Culinary Itinerary"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?image_url ?name ?municipality ?province ?region ?type ?description ?notes ?latitude ?longitude
where{
            	?x rdf:type :Culinary_itinerary;
                		:CulinaryItLat ?latitude;
                		:CulinaryItLong ?longitude;
               	 	:culinaryItineraryProposes ?culinaryProduct;
                		:culinaryItinerarySituatedIn ?municipality_id.

            	?municipality_id :MunicipalityName ?municipality;
                		:isInProvince ?province_id;
                		:isInRegion ?region_id.
           	?province_id :ProvinceAbbreviation ?province.
            	?region_id :RegionName ?region.

           	?culinaryProduct :CulinaryProductName ?name.

            	optional { ?x :CulinaryItType ?type }
            	optional { ?x :CulinaryItDescr ?description}
            	optional { ?x :CulinaryItNote ?notes }
            	optional { ?x :CulinaryItImageUrl ?image_url }
}
[QueryItem="Cultural itinerary"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?image_url ?name ?localita ?address ?municipality ?province ?region ?type ?type_period ?century ?style ?information ?notes ?bibliography ?sitography ?latitude ?longitude
where{
	?x rdf:type :Cultural_itinerary;
		:CulturalItLat ?latitude;
                		:CulturalItLong ?longitude;
               		:culturalItineraryProposes ?poi;
                		:culturalItinerarySituatedIn ?municipality_id.

            	?municipality_id :MunicipalityName ?municipality;
               	 	:isInProvince ?province_id;
                		:isInRegion ?region_id.
            	?province_id :ProvinceAbbreviation ?province.
            	?region_id :RegionName ?region.

           	optional { ?poi :POIName ?name }
            	optional { ?poi :POICentury ?century }
            	optional { ?poi :POIStyle ?style }
            	optional { ?poi :POIType ?type }

           	optional { ?x :CulturalItAddr ?address }
            	optional { ?x :CulturalItBibl ?bibliography }
            	optional { ?x :CulturalItInfo ?information }
            	optional { ?x :CulturalItLoc ?localita }
            	optional { ?x :CulturalItNote ?notes }
            	optional { ?x :CulturalItSit ?sitography }
            	optional { ?x :CulturalItType ?type_period }
            	optional { ?x :CulturalItImageUrl ?image_url }
}
[QueryItem="Test single quote escape"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?municipality ?zipcode  ?province ?region
where{
            	?municipality_id a :Municipality;
		:MunicipalityName "Sant'Egidio del Monte Albino";
		:MunicipalityZipCode ?zipcode;
                		:isInProvince ?province_id;
                		:isInRegion ?region_id.
            	?province_id :ProvinceAbbreviation ?province.
            	?region_id :RegionName ?region.
}
[QueryItem="Test double quotes escape"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?municipality ?zipcode  ?province ?region
where{
            	?municipality_id a :Municipality;
		:MunicipalityName 'Sant''Egidio del Monte Albino';
		:MunicipalityZipCode ?zipcode;
                		:isInProvince ?province_id;
                		:isInRegion ?region_id.
            	?province_id :ProvinceAbbreviation ?province.
            	?region_id :RegionName ?region.
}
[QueryItem="Municipality with optional"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

select distinct ?name ?zipcode ?province ?region
where{
?x rdf:type :Municipality;
     :MunicipalityName ?name.
optional { ?x :MunicipalityZipCode ?zipcode }.
optional { ?x :isInProvince ?province  }.
optional { ?x :isInRegion ?region }.
}
[QueryItem="test"]
PREFIX : <http://www.semanticweb.org/marcozenere/ontologies/2022/0/untitled-ontology-11#>

select ?municipality_id ?region
where{
            	?municipality_id a :Municipality;

                		<http://www.cidoc-crm.org/cidoc-crm#P89_falls_within> ?region.


}