String generateRdfFile({
  required String title,
  required String description,
  required String identifier,
  required String theme,
  required String themeURI,
  required List<String> keywords,
  required String issued,
  required String modified,
  required String temporalStart,
  required String temporalEnd,
  required String spatial,
  required String frequency,
  required String language,
  required String publisherName,
  required String publisherType,
  required String publisherEmail,
  required String distTitle,
  required String format,
  required String downloadURL,
  required String license,
  required String size,
}) {
  final publisherURI =
      "https://datos.madrid.es/organization/ayuntamiento-madrid";
  final catalogURI = "https://datos.madrid.es/catalog";
  final datasetURI = identifier;
  final distURI = downloadURL;
  final languageURI =
      "http://publications.europa.eu/resource/authority/language/SPA";
  final frequencyURI =
      "http://publications.europa.eu/resource/authority/frequency/DAILY";
  final licenseURI = "https://creativecommons.org/licenses/by/4.0/";
  final formatURI =
      "http://publications.europa.eu/resource/authority/file-type/CSV";

  final buffer = StringBuffer();
  buffer.writeln('<?xml version="1.0" encoding="UTF-8"?>');
  buffer.writeln('<rdf:RDF');
  buffer.writeln('  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"');
  buffer.writeln('  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"');
  buffer.writeln('  xmlns:dcat="http://www.w3.org/ns/dcat#"');
  buffer.writeln('  xmlns:dcterms="http://purl.org/dc/terms/"');
  buffer.writeln('  xmlns:foaf="http://xmlns.com/foaf/0.1/"');
  buffer.writeln('  xmlns:vcard="http://www.w3.org/2006/vcard/ns#"');
  buffer.writeln('  xmlns:adms="http://www.w3.org/ns/adms#"');
  buffer.writeln('  xmlns:skos="http://www.w3.org/2004/02/skos/core#"');
  buffer.writeln('  xmlns:xsd="http://www.w3.org/2001/XMLSchema#">');

  // Catalog
  buffer.writeln('  <dcat:Catalog rdf:about="$catalogURI">');
  buffer.writeln(
      '    <dcterms:title xml:lang="es">Catálogo de Datos Abiertos de Madrid</dcterms:title>');
  buffer.writeln(
      '    <dcterms:description xml:lang="es">Portal de datos abiertos del Ayuntamiento de Madrid</dcterms:description>');
  buffer.writeln('    <dcterms:publisher rdf:resource="$publisherURI"/>');
  buffer.writeln(
      '    <foaf:homepage rdf:resource="https://datos.madrid.es/portal/"/>');
  buffer.writeln('    <dcterms:language rdf:resource="$languageURI"/>');
  buffer.writeln(
      '    <dcterms:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#date">2015-01-01</dcterms:issued>');
  buffer.writeln(
      '    <dcterms:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime">2024-09-15T10:30:00Z</dcterms:modified>');
  buffer.writeln('    <dcat:dataset rdf:resource="$datasetURI"/>');
  buffer.writeln('  </dcat:Catalog>');

  // Organization/Publisher
  buffer.writeln('  <foaf:Organization rdf:about="$publisherURI">');
  buffer.writeln('    <foaf:name xml:lang="es">$publisherName</foaf:name>');
  buffer.writeln(
      '    <dcterms:type rdf:resource="http://purl.org/adms/publishertype/LocalAuthority"/>');
  buffer.writeln('    <vcard:hasEmail rdf:resource="mailto:$publisherEmail"/>');
  buffer.writeln('    <foaf:homepage rdf:resource="https://www.madrid.es/"/>');
  buffer.writeln('  </foaf:Organization>');

  // Dataset
  buffer.writeln('  <dcat:Dataset rdf:about="$datasetURI">');
  buffer.writeln('    <dcterms:title xml:lang="es">$title</dcterms:title>');
  buffer.writeln(
      '    <dcterms:description xml:lang="es">$description</dcterms:description>');
  buffer.writeln('    <dcterms:identifier>$identifier</dcterms:identifier>');
  for (var kw in keywords) {
    if (kw.trim().isNotEmpty) {
      buffer.writeln(
          '    <dcat:keyword xml:lang="es">${kw.trim()}</dcat:keyword>');
    }
  }
  buffer.writeln('    <dcterms:publisher rdf:resource="$publisherURI"/>');
  buffer.writeln('    <dcat:theme rdf:resource="$themeURI"/>');
  buffer.writeln(
      '    <dcterms:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#date">$issued</dcterms:issued>');
  buffer.writeln(
      '    <dcterms:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#date">$modified</dcterms:modified>');
  buffer.writeln('    <dcterms:language rdf:resource="$languageURI"/>');
  buffer.writeln('    <dcterms:temporal>');
  buffer.writeln('      <dcterms:PeriodOfTime>');
  buffer.writeln(
      '        <dcat:startDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">$temporalStart</dcat:startDate>');
  buffer.writeln(
      '        <dcat:endDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">$temporalEnd</dcat:endDate>');
  buffer.writeln('      </dcterms:PeriodOfTime>');
  buffer.writeln('    </dcterms:temporal>');
  buffer.writeln('    <dcterms:spatial>');
  buffer.writeln('      <dcterms:Location>');
  buffer.writeln(
      '        <skos:prefLabel xml:lang="es">$spatial</skos:prefLabel>');
  buffer.writeln('      </dcterms:Location>');
  buffer.writeln('    </dcterms:spatial>');
  buffer.writeln(
      '    <dcterms:accrualPeriodicity rdf:resource="$frequencyURI"/>');
  buffer.writeln('    <dcat:distribution rdf:resource="$distURI"/>');
  buffer.writeln('  </dcat:Dataset>');

  // Distribution
  buffer.writeln('  <dcat:Distribution rdf:about="$distURI">');
  buffer.writeln('    <dcterms:title xml:lang="es">$distTitle</dcterms:title>');
  buffer.writeln('    <dcat:accessURL rdf:resource="$downloadURL"/>');
  buffer.writeln('    <dcat:downloadURL rdf:resource="$downloadURL"/>');
  buffer.writeln('    <dcterms:format rdf:resource="$formatURI"/>');
  buffer.writeln('    <dcat:mediaType>text/csv</dcat:mediaType>');
  if (size.isNotEmpty) {
    buffer.writeln(
        '    <dcat:byteSize rdf:datatype="http://www.w3.org/2001/XMLSchema#decimal">$size</dcat:byteSize>');
  }
  buffer.writeln('    <dcterms:license rdf:resource="$licenseURI"/>');
  buffer.writeln('    <dcterms:rights>');
  buffer.writeln('      <dcterms:RightsStatement>');
  buffer.writeln('        <rdfs:label xml:lang="es">$license</rdfs:label>');
  buffer.writeln('      </dcterms:RightsStatement>');
  buffer.writeln('    </dcterms:rights>');
  buffer.writeln(
      '    <dcterms:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#date">$issued</dcterms:issued>');
  buffer.writeln(
      '    <dcterms:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#date">$modified</dcterms:modified>');
  buffer.writeln('  </dcat:Distribution>');

  buffer.writeln('</rdf:RDF>');
  return buffer.toString();
}
