/**
 * snomed war location: need to change IP where snomed war is deployed 
 */

var index = 0;
var jsonData;
var currentCountDisplayed;
var displaySearch;
var h = 80;
var dialogFormHTML;
var divDialogForm;
var txtId;
var selectedConceptId;
var stateParam;
var semantictagParam;
var acceptabilityParam;
var returnlimitParam;

var enumACCEPTABILITY = {
	ALL : "all",
	PREFERRED : "preferred",
	PREFERRED_EXCLUDING_FSN : "preferredexcludingfsn",
	SYNONYMS : "synonyms",
	ACCEPTABLE : "acceptable"
};
var enumSTATE = {
	BOTH : "both",
	ACTIVE : "active",
	INACTIVE : "inactive"
};

var enumSEMANTICTAG = {

	ALL : "all",
	PROCEDURE : "procedure",
	DISORDER : "disorder",
	FINDING : "finding",
	OBSERVABLE_ENTITY : "observable entity",
	BODY_STRUCTURE : "body structure",
	ORGANISM : "organism",
	SUBSTANCE : "substance",
	SPECIMEN : "specimen",
	SPECIAL_CONCEPT : "special concept",
	LINKAGE_CONCEPT : "linkage concept",
	PHYSICAL_FORCE : "physical force",
	EVENT : "event",
	ENVIRONMENT : "environment",
	GEOGRAPHIC_LOCATION : "geographic location",
	SOCIAL_CONCEPT : "social concept",
	SITUATION_WITH_EXPLICIT_CONTEXT : "situation",
	STAGING_SCALE : "staging scale",
	PHYSICAL_OBJECT : "physical object",
	QUALIFIER_VALUE : "qualifier value",
	RECORD_ARTIFACT : "record artifact",
	PERSON : "person",
	LINK_ASSERTION : "link assertion",
	NAMESPACE_CONCEPT : "namespace concept",
	ATTRIBUTE : "attribute",
	ASSESSMENT_SCALE : "assessment scale",
	RACIAL_GROUP : "racial group",
	TUMOR_STAGING : "tumor staging",
	OCCUPATION : "occupation",
	MORPHOLOGIC_ABNORMALITY : "morphologic abnormality",
	CELL : "cell",
	CELL_STRUCTURE : "cell structure",
	ETHNIC_GROUP : "ethnic group",
	PRODUCT : "product",
	INACTIVE_CONCEPT : "inactive concept",
	NAVIGATIONAL_CONCEPT : "navigational concept",
	LIFE_STYLE : "life style",
	REGIME_THERAPY : "regime/therapy",
	RELIGION_PHILOSOPHY : "religion/philosophy"
};

var enumLANGREFSET={
	UK: "uk",
	US: "us",
};
var enumRELATIONSHIP={
	IS_A: "is a",
	FINDING_SITE:"finding site",
	CAUSATIVE_AGENT:"causative agent",
	HAS_INTENT:"has intent",
	PROCEDURE_SITE:"procedure site",
	SPECIMEN_SUBSTANCE:"specimen substance",
	ASSOCIATED_FINDING:"associated finding",
	ASSOCIATED_WITH:"associated with",
	ASSOCIATED_MORPHOLOGY:"associated morphology",
	HAS_ACTIVE_INGREDIENT:"has active ingredient",
	PROCEDURE_SITE_DIRECT:"procedure site direct",
	SPECIMEN_SOURCE_TOPOGRAPHY:"specimen source topography",
	HAS_FOCUS:"has focus",
	HAS_MEASURED_COMPONENT:"has measured component",
	COMPONENT:"component",
	PROCEDURE_SITE_INDIRECT:"procedure site indirect",
	USING:"using",
	DIRECT_DEVICE:"direct device",
	USING_DEVICE:"using device",
	SPECIMEN_SOURCE_MORPHOLOGY:"specimen source morphology",
	DIRECT_MORPHOLOGY:"direct morphology ",
	INDIRECT_MORPHOLOGY:"indirect morphology ",
	PART_OF:"part of ",
	DUE_TO:"due to ",
	RECIPIENT_CATEGORY:"recipient category ",
	SUBJECT_RELATIONSHIP_CONTEXT:"subject relationship context ",
	DIRECT_SUBSTANCE:"direct substance ",
	USING_SUBSTANCE:"using substance ",
	INTERPRETS:"interprets ",
	SPECIMEN_PROCEDURE:"specimen procedure ",
	HAS_DEFINITIONAL_MANIFESTATION:"has definitional manifestation ",
	ASSOCIATED_ETIOLOGIC_FINDING:"associated etiologic finding ",
	HAS_INTERPRETATION:"has interpretation ",
	AFTER:"after ",
	METHOD:"method ",
	TEMPORALLY_FOLLOWS:"temporally follows ",
	ASSOCIATED_PROCEDURE:"associated procedure ",
	ASSOCIATED_FUNCTION:"associated function ",
	PROCEDURE_DEVICE:"procedure device ",
	REVISION_STATUS:"revision status ",
	MEASUREMENT_METHOD:"measurement method ",
	OCCURRENCE:"occurrence ",
	MEASURES:"measures ",
	PROCEDURE_MORPHOLOGY:"procedure morphology ",
	FINDING_METHOD:"finding method ",
	INDIRECT_DEVICE:"indirect device ",
	ROUTE_OF_ADMINISTRATION:"route of administration ",
	USING_ACCESS_DEVICE:"using access device ",
	TEMPORAL_CONTEXT:"temporal context ",
	APPROACH:"approach ",
	SURGICAL_APPROACH:"surgical approach ",
	SEVERITY:"severity ",
	COURSE:"course ",
	CLINICAL_COURSE:"clinical course ",
	LATERALITY:"laterality ",
	HAS_DOSE_FORM:"has dose form ",
	SPECIMEN_SOURCE_IDENTITY:"specimen source identity ",
	ACCESS_INSTRUMENT:"access instrument ",
	STAGE:"stage ",
	USING_ENERGY:"using energy ",
	ONSET:"onset ",
	INSTRUMENTATION:"instrumentation ",
	PRIORITY:"priority  ",
	EXTENT:"extent ",
	SCALE_TYPE:"scale type ",
	SUBJECT_OF_INFORMATION:"subject of information ",
	FINDING_CONTEXT:"finding context ",
	HAS_SPECIMEN:"has specimen ",
	ACCESS:"access ",
	PROPERTY:"property ",
	TIME_ASPECT:"time aspect ",
	EPISODICITY:"episodicity ",
	LOCATION:"location ",
	PATHOLOGICAL_PROCESS:"pathological process ",
	COMMUNICATION_WITH_WOUND:"communication with wound ",
	PROCEDURE_CONTEXT:"procedure context ",
	FINDING_INFORMER:"finding informer"
};

var enumSERVICES = {
	SEARCH : {
		type : "search",
		suggestbyacceptability_url : "http://192.168.10.59:8081/csnoserv/api/search/suggest",
		searchbyacceptability_url : "http://192.168.10.59:8181/csnoserv/api/search/search",
	},
};
